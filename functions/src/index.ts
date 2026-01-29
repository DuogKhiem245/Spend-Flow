import { onCall } from "firebase-functions/v2/https";
import { analyzeReceiptImageHandler, analyzeTransactionTextHandler } from "./ai/ai.controller.js";
import { forgotPasswordHandler, loginHandler, registerHandler, resendOtpRegisterHandler, resetPasswordHandler, verifyOtpRegisterHandler } from "./auth/auth.controller.js";
import { getApps, initializeApp } from "firebase-admin/app";

if (getApps().length === 0) {
    initializeApp({
        projectId: 'spend-flow-82e37',
        serviceAccountId: 'spend-flow-82e37@appspot.gserviceaccount.com',
    });
}

export const registerUser = onCall(
    { secrets: ["GMAIL_APP_PASSWORD"] },
    registerHandler
);

export const verifyOtpRegister = onCall(
    verifyOtpRegisterHandler
);

export const resendOtpRegister = onCall(
    { secrets: ["GMAIL_APP_PASSWORD"] },
    resendOtpRegisterHandler
);

export const loginUser = onCall(
    {
        serviceAccount: 'spend-flow-82e37@appspot.gserviceaccount.com' 
    },
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
