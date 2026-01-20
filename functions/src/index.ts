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
    {
        secrets: ["GEMINI_API_KEY"],
    },
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
        
        IMPORTANT: All text fields ("title", "note") in the output MUST be in ${targetLang}.
        If you cannot identify the language, default to English.

        User categories: ${categoriesJson}
        Today: ${new Date().toISOString()}

        REQUIREMENTS:
            1. amount: Find the FINAL total amount (Grand Total).
            2. categoryId: Map to the most relevant ID from the list provided based on the overall purchase.
            3. title: Summarize the MAIN content of the transaction (e.g., "Grocery shopping", "Dinner at Restaurant", "Electronics purchase"). Do NOT just use the Store name.
            4. note: Provide details including: Store name, a brief list of key items purchased (e.g., "Starbucks. Items: 2 Lattes, 1 Croissant").
            5. actionType: Always "TRANSACTION".

        Output plain JSON (No Markdown):
        {
            "actionType": "TRANSACTION",
            "data": {
            "amount": number,
            "title": string,
            "categoryId": string,
            "date": string (ISO 8601),
            "note": string (optional),
            "isIncome": false
            }
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
    {
        secrets: ["GEMINI_API_KEY"],
    },
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
        
        IMPORTANT: All text fields ("title", "note") in the output MUST be in ${targetLang}.
        If the requested language is not clear, default to English.

        Categories: ${categoriesJson}
        Today: ${new Date().toISOString()}

        TASKS:
        1. Determine "actionType": TRANSACTION or BUDGET.
        2. Extract data:
           - amount: The value.
           - title: Brief summary (e.g., "Salary", "Coffee").
           - note: Extract any additional context from the text such as people involved, or payment methods (e.g., "Paid via Momo", "Lunch with Team"). If no extra info, summarize the intent.

        Output plain JSON (No Markdown):
        {
            "actionType": "TRANSACTION" | "BUDGET",
            "data": {
            "amount": number,
            "title": string,
            "categoryId": string,
            "isIncome": boolean,
            "date": string (ISO 8601),
            "note": string (optional)
            }
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
