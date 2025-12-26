import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { GoogleGenerativeAI } from "@google/generative-ai";

const apiKey = process.env.GEMINI_API_KEY;
const genAI = new GoogleGenerativeAI(apiKey || "");

export const analyzeReceiptImage = onCall(async (request) => {
    const imageBase64 = request.data.imageBase64;
    const categories = request.data.categories;

    if (!imageBase64) {
        throw new HttpsError("invalid-argument", "Vui lòng gửi dữ liệu ảnh.");
    }

    try {
        const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash-lite" });
        const categoriesJson = JSON.stringify(categories);

        const prompt = `
      Bạn là một chuyên gia kế toán AI. Hãy nhìn vào hình ảnh hóa đơn và trích xuất thông tin giao dịch chính xác nhất.

      Danh mục của người dùng: ${categoriesJson}
      Ngày hôm nay: ${new Date().toISOString().split('T')[0]}

      Yêu cầu:
      - Tìm "Tổng tiền" (Total Amount) của hóa đơn.
      - Tìm tên cửa hàng hoặc món chính để làm "Title".
      - Dựa vào nội dung, chọn categoryId phù hợp nhất.
      - Trích xuất ngày tháng.
      
      Output JSON (Không markdown):
      {
        "amount": number,
        "title": string,
        "categoryId": string (hoặc null),
        "date": string (ISO 8601),
        "note": string,
        "isIncome": false
      }
    `;

        const imagePart = {
            inlineData: {
                data: imageBase64,
                mimeType: "image/jpeg",
            },
        };

        const result = await model.generateContent([prompt, imagePart]);
        const response = result.response.text();
        const cleanJson = response.replace(/```json|```/g, "").trim();

        return {
            success: true,
            data: JSON.parse(cleanJson)
        };

    } catch (error) {
        logger.error("Analyze Image Error", error);
        throw new HttpsError("internal", "Lỗi xử lý: " + error);
    }
});

export const analyzeTransactionText = onCall(async (request) => {
    const text = request.data.text;
    const categories = request.data.categories;

    if (!text) {
        throw new HttpsError("invalid-argument", "Vui lòng gửi nội dung văn bản.");
    }

    try {
        const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash-lite" });
        const categoriesJson = JSON.stringify(categories);

        const prompt = `
      Bạn là trợ lý tài chính thông minh. Hãy phân tích văn bản (từ giọng nói hoặc nhập liệu) để trích xuất thông tin giao dịch.

      Danh sách danh mục của người dùng (ID và Tên):
      ${categoriesJson}

      Nội dung cần phân tích:
      "${text}"
      
      Ngày hôm nay là: ${new Date().toISOString().split('T')[0]}.

      Yêu cầu đầu ra (JSON thuần, không markdown):
      {
        "amount": number (số tiền, ưu tiên VNĐ. Nếu user nói "50k", hiểu là 50000. Nếu "2 lít", hiểu là 200000),
        "title": string (Tiêu đề ngắn gọn, ví dụ: "Ăn phở", "Đổ xăng"),
        "categoryId": string (Chọn 1 ID từ danh sách trên khớp nhất. Nếu không tìm thấy, trả về null),
        "date": string (ISO 8601 YYYY-MM-DDT00:00:00.000),
        "note": string (Mô tả chi tiết hơn nếu có),
        "isIncome": boolean (true nếu là khoản thu/lương/được tặng, false nếu là chi tiêu)
      }
    `;

        const result = await model.generateContent(prompt);
        const response = result.response.text();
        const cleanJson = response.replace(/```json|```/g, "").trim();

        return {
            success: true,
            data: JSON.parse(cleanJson)
        };
    } catch (e) {
        logger.error("Analyze Text Error", e);
        throw new HttpsError("internal", "Lỗi xử lý văn bản: " + e);
    }
});