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

        QUANTITY & CALCULATION RULES:
        1. For each item, identify the QUANTITY and UNIT PRICE.
        2. Set "amount" as the TOTAL for that line item (Quantity * Unit Price).
        3. In the "note" field, follow this format: "[Store Name] - [Qty] x [Unit Price]".
        
        STRICT RULES TO AVOID DOUBLE COUNTING:
        1. List individual items ONLY. DO NOT include "Total", "Tax", or "Change".
        2. If items are unclear, provide one single transaction for the Grand Total.
        
        ADDRESS LOGIC:
        1. Try to extract the full physical address of the store.
        2. If the full address is not clear, use the STORE NAME.
        3. If BOTH the address and store name cannot be identified with high confidence, set "address" to null.
        4. NEVER guess or provide a generic address.

        REQUIREMENTS:
        - Map each item to the best categoryId.
        - title: Item name (e.g., "Coca Cola", "Apple").
        - amount: Total cost for this item (Number only).
        - address: Full street address, Store Name, or null.
        - isIncome: false.

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
                        "address": string | null,
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