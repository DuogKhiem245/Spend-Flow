import { onCall } from "firebase-functions/v2/https";
import { analyzeReceiptImageHandler, analyzeTransactionTextHandler } from "./ai/ai.controller.js";
import { forgotPasswordHandler, loginHandler, registerHandler, resendOtpHandler, resetPasswordHandler, verifyOtpHandler } from "./auth/auth.controller.js";
import { getApps, initializeApp } from "firebase-admin/app";

if (getApps().length === 0) {
    initializeApp();
}

export const registerUser = onCall(
    { secrets: ["GMAIL_APP_PASSWORD"] },
    registerHandler
);

export const verifyOtp = onCall(
    verifyOtpHandler
);

export const resendOtp = onCall(
    { secrets: ["GMAIL_APP_PASSWORD"] },
    resendOtpHandler
);

export const loginUser = onCall(
    loginHandler
);

export const forgotPassword = onCall(
    { secrets: ["GMAIL_APP_PASSWORD"] },
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
