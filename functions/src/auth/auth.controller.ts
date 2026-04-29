import * as admin from "firebase-admin";
import { getFirestore, FieldValue } from "firebase-admin/firestore";
import { HttpsError, CallableRequest } from "firebase-functions/v2/https";
import { randomUUID } from "crypto";
import bcrypt from "bcryptjs";
import { sendOTPEmail } from "./auth.service.js";
import { getT } from "./auth.messages.js";

const validateFields = (fields: Record<string, any>, t: any) => {
  const missing = Object.keys(fields).filter((k) => !fields[k]);
  if (missing.length > 0) {
    throw new HttpsError(
      "invalid-argument",
      `${t.missingFields}: ${missing.join(", ")}`,
    );
  }
};

const wrapError = (error: any, context: string) => {
  console.error(`[ERROR][${context.toUpperCase()}]`, error);
  if (error instanceof HttpsError) return error;
  return new HttpsError("internal", `Server Error: ${error.message || error}`, {
    context,
  });
};

export const registerHandler = async (request: CallableRequest) => {
  const { email, password, lang } = request.data;
  const t = getT(lang);
  const db = getFirestore();

  validateFields({ email, password }, t);

  try {
    // Kiểm tra User trong Auth
    try {
      const authUser = await admin.auth().getUserByEmail(email);
      if (authUser) {
        const providers = authUser.providerData.map((p) => p.providerId);
        const providerKey = providers.includes("google.com")
          ? t.emailUsedWithGoogle
          : providers.includes("apple.com")
            ? t.emailUsedWithApple
            : providers.includes("facebook.com")
              ? t.emailUsedWithFacebook
              : t.emailUsedWithSocial;
        throw new HttpsError("already-exists", providerKey);
      }
    } catch (error: any) {
      if (error.code !== "auth/user-not-found") throw error;
    }

    const otp = Math.floor(100000 + Math.random() * 900000).toString();

    await db
      .collection("temp_users")
      .doc(email)
      .set({
        userId: randomUUID(),
        email,
        password: await bcrypt.hash(password, 10),
        otp,
        expiresAt: Date.now() + 5 * 60 * 1000,
        lastSentAt: Date.now(),
        createdAt: FieldValue.serverTimestamp(),
      });

    await sendOTPEmail(email, otp, "REGISTER", lang || "en");

    return { success: true, message: t.otpSent };
  } catch (error) {
    throw wrapError(error, "register");
  }
};

export const verifyOtpRegisterHandler = async (request: CallableRequest) => {
  const { email, otp, lang } = request.data;
  const t = getT(lang);
  const db = getFirestore();

  validateFields({ email, otp }, t);

  try {
    const tempDoc = await db.collection("temp_users").doc(email).get();
    const userData = tempDoc.data();

    if (!tempDoc.exists || !userData)
      throw new HttpsError("not-found", t.reqNotFound);
    if (userData.otp !== otp)
      throw new HttpsError("permission-denied", t.invalidOtp);
    if (Date.now() > userData.expiresAt + 30000)
      throw new HttpsError("deadline-exceeded", t.otpExpired);

    await admin.auth().createUser({
      uid: userData.userId,
      email: email,
      emailVerified: true,
    });

    await db.collection("users").doc(email).set({
      userId: userData.userId,
      email: userData.email,
      password: userData.password,
      createdAt: FieldValue.serverTimestamp(),
      isVerified: true,
      signInMethod: "password",
    });

    await db.collection("temp_users").doc(email).delete();
    return { success: true, message: t.verifySuccess, userId: userData.userId };
  } catch (error) {
    throw wrapError(error, "verify-otp");
  }
};

export const resendOtpRegisterHandler = async (request: CallableRequest) => {
  const { email, lang } = request.data;
  const t = getT(lang);
  const db = getFirestore();

  validateFields({ email }, t);

  try {
    const tempDoc = await db.collection("temp_users").doc(email).get();
    if (!tempDoc.exists) throw new HttpsError("not-found", t.reqNotFound);

    const userData = tempDoc.data()!;
    if (Date.now() - (userData.lastSentAt || 0) < 60000) {
      throw new HttpsError("resource-exhausted", t.waitResend);
    }

    const newOtp = Math.floor(100000 + Math.random() * 900000).toString();

    await db
      .collection("temp_users")
      .doc(email)
      .update({
        otp: newOtp,
        expiresAt: Date.now() + 5 * 60 * 1000,
        lastSentAt: Date.now(),
      });

    await sendOTPEmail(email, newOtp, "REGISTER", lang || "en");
    return { success: true, message: t.newOtpSent };
  } catch (error) {
    throw wrapError(error, "resend-otp");
  }
};

export const loginHandler = async (request: CallableRequest) => {
  const { email, password, lang, signInMethod } = request.data;
  const t = getT(lang);
  const db = getFirestore();

  validateFields({ email, password }, t);

  try {
    const userDoc = await db.collection("users").doc(email).get();
    const userData = userDoc.data();

    if (!userDoc.exists || !userData) {
      try {
        const authUser = await admin.auth().getUserByEmail(email);
        if (authUser)
          throw new HttpsError("already-exists", t.emailUsedWithSocial);
      } catch (e: any) {
        if (e.code !== "auth/user-not-found")
          throw new HttpsError("internal", t.serverError);
      }
      throw new HttpsError("not-found", t.userNotFound);
    }

    const isMatch = await bcrypt.compare(password, userData.password);
    if (!isMatch) throw new HttpsError("unauthenticated", t.wrongPassword);

    await db
      .collection("info_users")
      .doc(userData.userId)
      .set(
        {
          lastLogin: admin.firestore.FieldValue.serverTimestamp(),
          email: email,
          signInMethod: signInMethod || "password",
        },
        { merge: true },
      );

    await admin.auth().updateUser(userData.userId, {
      email: email,
      emailVerified: true,
    });

    const customToken = await admin.auth().createCustomToken(userData.userId);
    return { success: true, customToken, userId: userData.userId };
  } catch (error) {
    throw wrapError(error, "login");
  }
};

export const forgotPasswordHandler = async (request: CallableRequest) => {
  const { email, lang } = request.data;
  const t = getT(lang);
  const db = getFirestore();

  validateFields({ email }, t);

  try {
    const userDoc = await db.collection("users").doc(email).get();
    if (!userDoc.exists) throw new HttpsError("not-found", t.userNotFound);

    const otp = Math.floor(100000 + Math.random() * 900000).toString();

    await db
      .collection("password_resets")
      .doc(email)
      .set({
        email,
        otp,
        expiresAt: Date.now() + 5 * 60 * 1000,
        createdAt: FieldValue.serverTimestamp(),
      });

    await sendOTPEmail(email, otp, "RESET", lang || "en");
    return { success: true, message: t.otpSent };
  } catch (error) {
    throw wrapError(error, "forgot-password");
  }
};

export const resetPasswordHandler = async (request: CallableRequest) => {
  const { email, otp, newPassword, lang } = request.data;
  const t = getT(lang);
  const db = getFirestore();

  validateFields({ email, otp, newPassword }, t);

  try {
    const resetDoc = await db.collection("password_resets").doc(email).get();
    const resetData = resetDoc.data();

    if (!resetDoc.exists || !resetData)
      throw new HttpsError("not-found", t.reqNotFound);
    if (resetData.otp !== otp)
      throw new HttpsError("permission-denied", t.invalidOtp);
    if (Date.now() > resetData.expiresAt)
      throw new HttpsError("deadline-exceeded", t.otpExpired);

    await db
      .collection("users")
      .doc(email)
      .update({
        password: await bcrypt.hash(newPassword, 10),
      });
    await db.collection("password_resets").doc(email).delete();

    return { success: true, message: t.passwordUpdated };
  } catch (error) {
    throw wrapError(error, "reset-password");
  }
};
