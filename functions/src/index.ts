import { onCall } from "firebase-functions/v2/https";
import { analyzeReceiptImageHandler, analyzeTransactionTextHandler } from "./ai/ai.controller.js";
import { forgotPasswordHandler, loginHandler, registerHandler, resendOtpHandler, resetPasswordHandler, verifyOtpHandler } from "./auth/auth.controller.js";
import { getApps, initializeApp } from "firebase-admin/app";

if (getApps().length === 0) {
    initializeApp();
}

export const registerUser = onCall(
    { secrets: ["RESEND_API_KEY"] },
    registerHandler
);

export const verifyOtp = onCall(
    verifyOtpHandler
);

export const resendOtp = onCall(
    { secrets: ["RESEND_API_KEY"] },
    resendOtpHandler
);

export const loginUser = onCall(
    loginHandler
);

export const forgotPassword = onCall(
    { secrets: ["RESEND_API_KEY"] },
    forgotPasswordHandler
);

export const resetPassword = onCall(
    resetPasswordHandler
);

export const analyzeReceiptImage = onCall(
    { secrets: ["GEMINI_API_KEY"] },
    analyzeReceiptImageHandler
);

export const analyzeTransactionText = onCall(
    { secrets: ["GEMINI_API_KEY"] },
    analyzeTransactionTextHandler
);
