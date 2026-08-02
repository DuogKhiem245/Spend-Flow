import { CallableRequest, HttpsError } from "firebase-functions/v2/https";
import { generateContentFlashLite, generateContentFlash, getLanguageLabel } from "./ai.service.js";
import * as logger from "firebase-functions/logger";

const cleanAIResponse = (response : string) => {
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
  const categoriesJson = JSON.stringify(categories);
  const systemInstruction = `
        You are an AI financial expert. Analyze the receipt image.
        
        IMPORTANT: All text fields in the output MUST be in ${targetLang}.
        User categories: ${categoriesJson}

        DATE LOGIC RULES:
        1. Extract the date from the receipt.
        2. STRICT RULE: The "date" field MUST NOT be in the future relative to "Today".
        3. If the date on the receipt appears to be in the future, you MUST use "Today" as the value for "date".

        IRRELEVANT CONTENT RULE:
        If the image is NOT a receipt, bill, invoice, or related to financial transactions, you MUST return an empty results array: {"results": []} and stop processing.

        DISCOUNT & PROMOTION HANDLING (CRITICAL):
        1. If you see a discount, promotion, voucher, or negative amount (e.g., -9,000) directly under or next to an item, you MUST SUBTRACT that discount from the parent item's amount.
        2. DO NOT create separate transactions for negative amounts or discounts.
        3. If an item is listed and immediately followed by a discount that makes its final cost 0 (e.g., "Trân châu 9k" followed by "Khuyến mãi -9k"), IGNORE that item entirely. Do not include it in the results.
        4. The final "amount" for any transaction MUST be greater than 0.

        QUANTITY & CALCULATION RULES:
        1. For each item, identify the QUANTITY and UNIT PRICE.
        2. Set "amount" as the FINAL TOTAL for that line item (Quantity * Unit Price - Discounts).
        3. In the "note" field, follow this format: "[Store Name] - [Qty] x [Unit Price]".
        
        STRICT RULES TO AVOID DOUBLE COUNTING:
        1. List individual items ONLY. DO NOT include "Total", "Tax", "Change", or "Cash rendered".
        2. Read rows carefully. Do not split a single purchased item into multiple transactions.
        3. If individual items are unclear or too messy, provide one single transaction for the Grand Total.
        
        ADDRESS LOGIC:
        1. Try to extract the full physical address of the store.
        2. If the full address is not clear, use the STORE NAME.
        3. If BOTH the address and store name cannot be identified with high confidence, set "address" to null.

        REQUIREMENTS:
        - Map each item to the best categoryId.
        - title: Item name (e.g., "Coca Cola", "Apple").
        - amount: Total final cost for this item (Number only, must be > 0).
        - address: Full street address, Store Name, or null.
        - isIncome: Set to false (purchases/expenses). Set to true ONLY if it's clearly a receipt for receiving money/refund.

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

  try {
    const prompt = `Today is: ${new Date().toISOString()}. Analyze this receipt image.`;

    const imagePart = {
      inlineData: { data: imageBase64, mimeType: "image/jpeg" },
    };

    const response = await generateContentFlash(
      process.env.GEMINI_API_KEY,
      systemInstruction,
      [prompt, imagePart],
    );
    const cleanJson = cleanAIResponse(response.text ?? "");

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
  const categoriesJson = JSON.stringify(categories);
  const systemInstruction = `
      You are an intelligent financial assistant.
        IMPORTANT: All text fields MUST be in ${targetLang}.
        Categories: ${categoriesJson}
        Today: ${new Date().toISOString()}

        IRRELEVANT CONTENT RULE:
        If the text is casual conversation, non-financial, or does NOT contain any intent about spending, receiving, or managing money, you MUST return an empty results array: {"results": []} and stop processing.

        TASKS:
        1. Identify ALL individual transactions mentioned in the text.
        2. amount: Extract the numerical value.
        3. title: Brief summary (e.g., "Lunch", "Salary").
        4. isIncome: Analyze the intent. Set "true" if the user is receiving money. Set "false" if the user is spending money.
        5. note: Add context like payment method or people involved.
        6. date: Extract the date. If not mentioned, use Today. 
           STRICT RULE: If the extracted date is in the future relative to "Today" (${new Date().toISOString()}), you MUST override it and use "Today" instead. 
           The transaction date can NEVER be later than Today.

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

  try {
    const prompt = `Analyze this text: "${text}"`;

    const response = await generateContentFlashLite(
      process.env.GEMINI_API_KEY,
      systemInstruction,
      prompt,
    );
    const cleanJson = cleanAIResponse(response.text ?? "");

    return { success: true, result: JSON.parse(cleanJson) };
  } catch (e) {
    logger.error("Analyze Text Error", e);
    throw new HttpsError("internal", "Lỗi xử lý văn bản: " + e);
  }
};