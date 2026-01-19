import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { GoogleGenerativeAI } from "@google/generative-ai";

const apiKey = process.env.GEMINI_API_KEY;
const genAI = new GoogleGenerativeAI(apiKey || "");

const getLanguageLabel = (langCode: string | number) => {
    const supportedLangs = {
        'vi': 'Tiếng Việt (Vietnamese)',
        'en': 'English',
        'ja': 'Japanese',
        'ko': 'Korean',
        'fr': 'French'
    };
    return supportedLangs[String(langCode) as keyof typeof supportedLangs] || 'English';
}

export const analyzeReceiptImage = onCall(async (request) => {
    const { imageBase64, categories, language } = request.data;
    const targetLang = getLanguageLabel(language);

    if (!imageBase64) {
        throw new HttpsError("invalid-argument", "Missing image data");
    }

    try {
        const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash-lite" });
        const categoriesJson = JSON.stringify(categories);

        const prompt = `
      You are an AI financial expert. Analyze the receipt image.
      
      IMPORTANT: All text fields ("title", "note") in the output MUST be in ${targetLang}.
      If you cannot identify the language, default to English.

      User categories: ${categoriesJson}
      Today: ${new Date().toISOString()}

      REQUIREMENTS:
      1. amount: Find the FINAL total amount (Grand Total).
      2. categoryId: Map to the most relevant ID from the list provided.
      3. title: Extract the Store/Brand name.
      4. actionType: Always "TRANSACTION".

      Output plain JSON (No Markdown):
      {
        "actionType": "TRANSACTION",
        "data": {
          "amount": number,
          "title": string,
          "categoryId": string,
          "date": string (ISO 8601),
          "note": string,
          "isIncome": false
        }
      }
    `;

        const imagePart = {
            inlineData: { data: imageBase64, mimeType: "image/jpeg" },
        };

        const result = await model.generateContent([prompt, imagePart]);
        const response = result.response.text();
        const cleanJson = response.replace(/```json|```/g, "").trim();

        return { success: true, result: JSON.parse(cleanJson) };
    } catch (error) {
        logger.error("Analyze Image Error", error);
        throw new HttpsError("internal", "Lỗi phân tích hóa đơn: " + error);
    }
});

export const analyzeTransactionText = onCall(async (request) => {
    const { text, categories, language } = request.data;
    const targetLang = getLanguageLabel(language);

    if (!text) {
        throw new HttpsError("invalid-argument", "Please provide text content.");
    }

    try {
        const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash-lite" });
        const categoriesJson = JSON.stringify(categories);

        const prompt = `
      You are an intelligent financial assistant. Analyze this text: "${text}"
      
      IMPORTANT: All text fields ("title", "note") in the output MUST be in ${targetLang}.
      If the requested language is not clear, default to English.

      Categories: ${categoriesJson}
      Today: ${new Date().toISOString()}

      TASKS:
      1. Determine "actionType": 
         - "TRANSACTION": for buying/selling/income (e.g., "Lunch 50k", "Salary 10M").
         - "BUDGET": for setting limits/budgets (e.g., "Set travel budget 5M").
      2. Extract data:
         - If TRANSACTION: amount, title, categoryId, isIncome.
         - If BUDGET: amount, title (as budget name), categoryId.

      Output plain JSON (No Markdown):
      {
        "actionType": "TRANSACTION" | "BUDGET",
        "data": {
          "amount": number,
          "title": string,
          "categoryId": string,
          "isIncome": boolean,
          "date": string (ISO 8601),
          "note": string
        }
      }
    `;

        const result = await model.generateContent(prompt);
        const response = result.response.text();
        const cleanJson = response.replace(/```json|```/g, "").trim();

        return { success: true, result: JSON.parse(cleanJson) };
    } catch (e) {
        logger.error("Analyze Text Error", e);
        throw new HttpsError("internal", "Lỗi xử lý văn bản: " + e);
    }
});
