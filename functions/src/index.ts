import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { GoogleGenerativeAI } from "@google/generative-ai";

const GEMINI_API_KEY = "YOUR_GEMINI_API_KEY";

const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);


export const scanReceipt = onCall(async (request) => {
    const imageBase64 = request.data.imageBase64;
    if (!imageBase64) {
        throw new HttpsError("invalid-argument", "Vui lòng gửi ảnh hóa đơn (base64).");
    }

    try {
        const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

        const prompt = `
      Bạn là một trợ lý kế toán AI chuyên nghiệp.
      Nhiệm vụ: Trích xuất thông tin từ hình ảnh hóa đơn này.
      
      Yêu cầu đầu ra:
      - Chỉ trả về duy nhất một chuỗi JSON hợp lệ.
      - Không được bọc trong markdown (như \`\`\`json).
      - Các trường cần lấy:
        - "total": số tiền (number), ưu tiên VNĐ. Nếu không rõ đơn vị, hãy đoán dựa trên ngữ cảnh.
        - "date": ngày hóa đơn (string, định dạng ISO 8601 YYYY-MM-DD). Nếu không thấy năm, lấy năm hiện tại.
        - "category": loại chi tiêu (string). Hãy chọn 1 trong các loại sau: "food", "transport", "shopping", "bill", "health", "education", "other".
        - "note": tóm tắt ngắn gọn tên cửa hàng hoặc món chính (string, tiếng Việt).
    `;

        const imagePart = {
            inlineData: {
                data: imageBase64,
                mimeType: "image/jpeg",
            },
        };

        const result = await model.generateContent([prompt, imagePart]);
        const response = result.response;
        const text = response.text();

        logger.info("Gemini Raw Response:", text);

        // 6. Xử lý kết quả (Làm sạch chuỗi JSON)
        // Đôi khi AI trả về: ```json {data} ``` -> Cần xóa ký tự thừa
        const cleanJson = text.replace(/```json|```/g, "").trim();

        // Parse sang Object
        const data = JSON.parse(cleanJson);

        return {
            success: true,
            data: data
        };

    } catch (error) {
        logger.error("Scan Receipt Error", error);
        // Trả về lỗi để App Flutter biết
        throw new HttpsError("internal", "Lỗi khi xử lý hình ảnh: " + error);
    }
});

/**
 * Hàm 2: Xử lý giọng nói / Văn bản tự nhiên (Voice Command)
 * Input: { text: string } (Ví dụ: "Hôm qua đi ăn lẩu hết 500k")
 * Output: JSON object đã phân tích
 */
export const processVoiceCommand = onCall(async (request) => {
    const commandText = request.data.text;

    if (!commandText) {
        throw new HttpsError("invalid-argument", "Vui lòng gửi nội dung văn bản.");
    }

    try {
        const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

        const prompt = `
      Nhiệm vụ: Phân tích câu nói sau để trích xuất thông tin chi tiêu tài chính.
      Câu nói: "${commandText}"
      Ngày hôm nay là: ${new Date().toISOString().split('T')[0]}.
      
      Yêu cầu đầu ra (JSON thuần, không markdown):
      {
        "amount": number (số tiền),
        "date": string (ISO 8601 YYYY-MM-DD). Xử lý các từ như "hôm qua", "sáng nay", "tuần trước" dựa trên ngày hôm nay.
        "note": string (mô tả ngắn gọn nội dung chi tiêu),
        "category": string (dự đoán category: "food", "transport", "shopping", "bill", "entertainment", "other")
      }
    `;

        const result = await model.generateContent(prompt);
        const text = result.response.text();

        const cleanJson = text.replace(/```json|```/g, "").trim();
        const data = JSON.parse(cleanJson);

        return {
            success: true,
            data: data
        };

    } catch (error) {
        logger.error("Voice Process Error", error);
        throw new HttpsError("internal", "Lỗi khi xử lý văn bản: " + error);
    }
});