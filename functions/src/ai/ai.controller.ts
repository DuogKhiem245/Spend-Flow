import { CallableRequest, HttpsError } from "firebase-functions/v2/https";
import { getAIModel, getLanguageLabel } from "./ai.service.js";
import * as logger from "firebase-functions/logger";

const cleanAIResponse = (response: string) => {
  let cleanStr = response
    .replace(/```json/gi, "")
    .replace(/```/g, "")
    .trim();
  const startIndex = cleanStr.indexOf("{");
  const endIndex = cleanStr.lastIndexOf("}");
  if (startIndex !== -1 && endIndex !== -1) {
    return cleanStr.substring(startIndex, endIndex + 1);
  }
  return cleanStr;
};

export const analyzeReceiptImageHandler = async (request: CallableRequest) => {
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

        REQUIREMENTS:
        - Map each item to the best categoryId.
        - title: Item name (e.g., "Coca Cola", "Apple").
        - amount: Total cost for this item (Number only).
        - address: Full street address, Store Name, or null.
        - isIncome: Classify the transaction. Set to "false" if it's a purchase/expense receipt (most common). Set to "true" ONLY if it's clearly a receipt for receiving money/refund.

        Output plain JSON ONLY (No Markdown, no extra text):
        {
            "results": [
                {
                    "actionType": "TRANSACTION",
                    "data": {
                        "amount": number,
                        "title": string,
                        "categoryId": string,
                        "date": string,
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
    const cleanJson = cleanAIResponse(result.response.text());

    return { success: true, result: JSON.parse(cleanJson) };
  } catch (error) {
    logger.error("Analyze Image Error", error);
    throw new HttpsError("internal", "Lỗi phân tích hóa đơn: " + error);
  }
};

export const analyzeTransactionTextHandler = async (
  request: CallableRequest,
) => {
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
        4. isIncome: Analyze the intent. Set "true" if the user is receiving money (e.g., salary, gift, getting paid). Set "false" if the user is spending money (e.g., shopping, eating, paying).
        5. note: Add context like payment method or people involved.
        6. date: Extract the date of the transaction. If not mentioned, use today's date.

        Output plain JSON ONLY with an array of results (No Markdown, no extra text):
        {
            "results": [
                {
                    "actionType": "TRANSACTION",
                    "data": {
                        "amount": number,
                        "title": string,
                        "categoryId": string,
                        "isIncome": boolean,
                        "date": string,
                        "note": string
                    }
                }
            ]
        }
        `;

    const result = await model.generateContent(prompt);
    const cleanJson = cleanAIResponse(result.response.text());

    return { success: true, result: JSON.parse(cleanJson) };
  } catch (e) {
    logger.error("Analyze Text Error", e);
    throw new HttpsError("internal", "Lỗi xử lý văn bản: " + e);
  }
};
