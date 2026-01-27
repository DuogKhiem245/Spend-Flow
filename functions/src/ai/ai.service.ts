import { GoogleGenerativeAI } from "@google/generative-ai";
import { HttpsError } from "firebase-functions/v2/https";

export const getLanguageLabel = (langCode: string | number): string => {
    const supportedLangs = {
        vi: "Tiếng Việt (Vietnamese)",
        en: "English",
        // ja: "Japanese",
        // ko: "Korean",
        // fr: "French",
    };
    return (supportedLangs[String(langCode) as keyof typeof supportedLangs] || "English");
};

export const getAIModel = (apiKey: string | undefined) => {
    if (!apiKey) {
        throw new HttpsError("failed-precondition", "GEMINI_API_KEY is not configured.");
    }
    const genAI = new GoogleGenerativeAI(apiKey);
    return genAI.getGenerativeModel({
        model: "gemini-2.5-flash-lite"
    });
};