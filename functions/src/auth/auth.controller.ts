import * as admin from "firebase-admin";
import { HttpsError, CallableRequest } from "firebase-functions/v2/https";
import bcrypt from "bcrypt";
import { randomUUID } from "crypto";
import { sendOTPEmail } from "./auth.service.js";

export const registerHandler = async (request: CallableRequest) => {
    const { email, password } = request.data;
    const db = admin.firestore();

    if (!email || !password) {
        throw new HttpsError("invalid-argument", "Vui lòng nhập đầy đủ thông tin.");
    }

    try {
        const userDoc = await db.collection("users").doc(email).get();
        if (userDoc.exists) {
            throw new HttpsError("already-exists", "Email này đã được sử dụng.");
        }

        const userId = randomUUID();
        const hashedPassword = await bcrypt.hash(password, 10);
        const otp = Math.floor(100000 + Math.random() * 900000).toString();
        const expiresAt = Date.now() + 5 * 60 * 1000; 

        await db.collection("temp_users").doc(email).set({
            userId,
            email,
            password: hashedPassword,
            otp,
            expiresAt,
            lastSentAt: Date.now(),
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        await sendOTPEmail(email, otp, 'REGISTER');

        return {
            success: true,
            message: "Mã OTP đã được gửi.",
        };

    } catch (error: any) {
        if (error instanceof HttpsError) throw error;
        throw new HttpsError("internal", error.message);
    }
};

export const verifyOtpHandler = async (request: CallableRequest) => {
    const { email, otp } = request.data;
    const db = admin.firestore();

    if (!email || !otp) {
        throw new HttpsError("invalid-argument", "Thiếu email hoặc mã OTP.");
    }

    try {
        const tempUserDoc = await db.collection("temp_users").doc(email).get();

        if (!tempUserDoc.exists) {
            throw new HttpsError("not-found", "Yêu cầu đăng ký không tồn tại.");
        }

        const userData = tempUserDoc.data()!;

        if (userData.otp !== otp) {
            throw new HttpsError("permission-denied", "Mã OTP không chính xác.");
        }

        if (Date.now() > (userData.expiresAt + 30000)) {
            throw new HttpsError("deadline-exceeded", "Mã OTP đã hết hạn.");
        }

        await db.collection("users").doc(email).set({
            userId: userData.userId, 
            email: userData.email,
            password: userData.password,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
            isVerified: true
        });

        await db.collection("temp_users").doc(email).delete();

        return {
            success: true,
            message: "Xác thực thành công! Bạn có thể đăng nhập ngay bây giờ.",
            userId: userData.userId
        };

    } catch (error: any) {
        if (error instanceof HttpsError) throw error;
        throw new HttpsError("internal", error.message);
    }
};

export const resendOtpHandler = async (request: CallableRequest) => {
    const { email } = request.data;
    const db = admin.firestore();

    if (!email) {
        throw new HttpsError("invalid-argument", "Vui lòng cung cấp địa chỉ email.");
    }

    try {
        const tempUserDoc = await db.collection("temp_users").doc(email).get();

        if (!tempUserDoc.exists) {
            throw new HttpsError("not-found", "Yêu cầu không tồn tại.");
        }

        const userData = tempUserDoc.data()!;

        const now = Date.now();
        if (userData.lastSentAt && now - userData.lastSentAt < 60000) {
            throw new HttpsError("resource-exhausted", "Vui lòng đợi 60 giây trước khi yêu cầu mã mới.");
        }

        const newOtp = Math.floor(100000 + Math.random() * 900000).toString();
        const newExpiresAt = now + 5 * 60 * 1000; 

        await db.collection("temp_users").doc(email).update({
            otp: newOtp,
            expiresAt: newExpiresAt,
            lastSentAt: now
        });

        await sendOTPEmail(email, newOtp, 'REGISTER');

        return { success: true, message: "Mã OTP mới đã được gửi!" };

    } catch (error: any) {
        if (error instanceof HttpsError) throw error;
        throw new HttpsError("internal", error.message);
    }
};

export const loginHandler = async (request: CallableRequest) => {
    const { email, password } = request.data;
    const db = admin.firestore();

    try {
        const userDoc = await db.collection("users").doc(email).get();
        if (!userDoc.exists) {
            throw new HttpsError("not-found", "Tài khoản không tồn tại.");
        }

        const userData = userDoc.data()!;
        const isPasswordMatch = await bcrypt.compare(password, userData.password);

        if (!isPasswordMatch) {
            throw new HttpsError("unauthenticated", "Sai mật khẩu.");
        }

 
        const customToken = await admin.auth().createCustomToken(userData.userId);

        return {
            success: true,
            customToken, 
            userId: userData.userId
        };
    } catch (error: any) {
        throw new HttpsError("internal", error.message);
    }
};

export const forgotPasswordHandler = async (request: CallableRequest) => {
    const { email } = request.data;
    const db = admin.firestore();

    if (!email) {
        throw new HttpsError("invalid-argument", "Vui lòng nhập email.");
    }

    try {
        const userDoc = await db.collection("users").doc(email).get();
        if (!userDoc.exists) {
            throw new HttpsError("not-found", "Email này chưa được đăng ký.");
        }

        const otp = Math.floor(100000 + Math.random() * 900000).toString();
        const expiresAt = Date.now() + 5 * 60 * 1000;

        await db.collection("password_resets").doc(email).set({
            email,
            otp,
            expiresAt,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        await sendOTPEmail(email, otp, 'RESET');

        return {
            success: true,
            message: "Mã xác thực đặt lại mật khẩu đã được gửi đến email."
        };

    } catch (error: any) {
        if (error instanceof HttpsError) throw error;
        throw new HttpsError("internal", error.message);
    }
};

export const resetPasswordHandler = async (request: CallableRequest) => {
    const { email, otp, newPassword } = request.data;
    const db = admin.firestore();

    if (!email || !otp || !newPassword) {
        throw new HttpsError("invalid-argument", "Thiếu thông tin cần thiết.");
    }

    try {
        const resetDoc = await db.collection("password_resets").doc(email).get();
        if (!resetDoc.exists) {
            throw new HttpsError("not-found", "Yêu cầu đặt lại mật khẩu không hợp lệ.");
        }

        const resetData = resetDoc.data()!;

        if (resetData.otp !== otp) {
            throw new HttpsError("permission-denied", "Mã xác thực không đúng.");
        }

        if (Date.now() > resetData.expiresAt) {
            throw new HttpsError("deadline-exceeded", "Mã xác thực đã hết hạn.");
        }

        const hashedPassword = await bcrypt.hash(newPassword, 10);
        await db.collection("users").doc(email).update({
            password: hashedPassword
        });

        await db.collection("password_resets").doc(email).delete();

        return {
            success: true,
            message: "Mật khẩu của bạn đã được cập nhật thành công!"
        };

    } catch (error: any) {
        if (error instanceof HttpsError) throw error;
        throw new HttpsError("internal", error.message);
    }
};