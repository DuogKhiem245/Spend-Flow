import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { GoogleGenerativeAI } from "@google/generative-ai";

const getLanguageLabel = (langCode: string | number) => {
    const supportedLangs = {
        vi: "Tiếng Việt (Vietnamese)",
        en: "English",
        ja: "Japanese",
        ko: "Korean",
        fr: "French",
    };
    return (
        supportedLangs[String(langCode) as keyof typeof supportedLangs] || "English"
    );
};

const getAIModel = (apiKey: string | undefined) => {
    if (!apiKey) {
        throw new HttpsError("failed-precondition", "GEMINI_API_KEY is not configured in Firebase Secrets.");
    }
    const genAI = new GoogleGenerativeAI(apiKey);
    return genAI.getGenerativeModel({ model: "gemini-2.5-flash-lite" });
}

export const analyzeReceiptImage = onCall(
    { secrets: ["GEMINI_API_KEY"] },
    async (request) => {
        if (!request.data || !request.data.imageBase64) {
            throw new HttpsError("invalid-argument", "Missing imageBase64 data");
        }

        const { imageBase64, categories, language } = request.data;
        const targetLang = getLanguageLabel(language);

        try {
            const model = getAIModel(process.env.GEMINI_API_KEY);
            const categoriesJson = JSON.stringify(categories);

            const prompt = `
        You are an AI financial expert. Analyze the receipt image.
        
        IMPORTANT: All text fields in the output MUST be in ${targetLang}.
        User categories: ${categoriesJson}
        Today: ${new Date().toISOString()}

        STRICT RULES TO AVOID DOUBLE COUNTING:
        1. If you can identify individual items with their specific prices, list ONLY those items. 
           DO NOT include the "Total" or "Grand Total" as a separate transaction in this case.
        2. If the receipt is too blurry or complex to list individual items, provide ONLY one single transaction representing the Grand Total.
        3. NEVER include both the individual items and the total amount in the same response.

        REQUIREMENTS:
        - Map each transaction to the most relevant categoryId.
        - title: Concise summary (e.g., "Starbucks Coffee", "Chicken Breast").
        - note: Include store name and details.
        - isIncome: false (default for receipts).

        Output plain JSON (No Markdown):
        {
            "results": [
                {
                    "actionType": "TRANSACTION",
                    "data": {
                        "amount": number,
                        "title": string,
                        "categoryId": string,
                        "date": string (ISO 8601),
                        "note": string,
                        "isIncome": boolean
                    }
                }
            ]
        }
        `;

            const imagePart = {
                inlineData: { data: imageBase64, mimeType: "image/jpeg" },
            };

            const result = await model.generateContent([prompt, imagePart]);
            const response = result.response.text();
            const jsonMatch = response.match(/\{[\s\S]*\}/);
            const cleanJson = jsonMatch ? jsonMatch[0] : response;

            return { success: true, result: JSON.parse(cleanJson) };
        } catch (error) {
            logger.error("Analyze Image Error", error);
            throw new HttpsError("internal", "Lỗi phân tích hóa đơn: " + error);
        }
    },
);

export const analyzeTransactionText = onCall(
    { secrets: ["GEMINI_API_KEY"] },
    async (request) => {
        if (!request.data || !request.data.text) {
            throw new HttpsError("invalid-argument", "Please provide text content.");
        }

        const { text, categories, language } = request.data;
        const targetLang = getLanguageLabel(language);

        try {
            const model = getAIModel(process.env.GEMINI_API_KEY);
            const categoriesJson = JSON.stringify(categories);

            const prompt = `
        You are an intelligent financial assistant. Analyze this text: "${text}"
        
        IMPORTANT: All text fields MUST be in ${targetLang}.
        Categories: ${categoriesJson}
        Today: ${new Date().toISOString()}

        TASKS:
        1. Identify ALL individual transactions mentioned in the text.
        2. amount: Extract the numerical value.
        3. title: Brief summary (e.g., "Lunch", "Salary").
        4. isIncome: Set true for income (salary, gift) and false for expenses (shopping, food).
        5. note: Add context like payment method or people involved.

        Output plain JSON with an array of results (No Markdown):
        {
            "results": [
                {
                    "actionType": "TRANSACTION",
                    "data": {
                        "amount": number,
                        "title": string,
                        "categoryId": string,
                        "isIncome": boolean,
                        "date": string (ISO 8601),
                        "note": string
                    }
                }
            ]
        }
        `;

            const result = await model.generateContent(prompt);
            const response = result.response.text();
            const jsonMatch = response.match(/\{[\s\S]*\}/);
            const cleanJson = jsonMatch ? jsonMatch[0] : response;

            return { success: true, result: JSON.parse(cleanJson) };
        } catch (e) {
            logger.error("Analyze Text Error", e);
            throw new HttpsError("internal", "Lỗi xử lý văn bản: " + e);
        }
    },
);