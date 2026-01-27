import { Resend } from "resend";

export const sendOTPEmail = async (email: string, otp: string, type: 'REGISTER' | 'RESET') => {
    const resend = new Resend(process.env.RESEND_API_KEY);

    const isReset = type === 'RESET';

    const subject = isReset ? "Đặt lại mật khẩu SpendFlow" : "Mã xác thực đăng ký SpendFlow";
    const title = isReset ? "Yêu cầu đặt lại mật khẩu" : "Chào mừng đến với SpendFlow";
    const color = isReset ? "#d9534f" : "#FF5722";
    const message = isReset
        ? "Sử dụng mã dưới đây để đặt lại mật khẩu của bạn:"
        : "Sử dụng mã dưới đây để hoàn tất việc đăng ký tài khoản:";

    try {
        await resend.emails.send({
            from: "SpendFlow <onboarding@resend.dev>",
            to: [email],
            subject: subject,
            html: `
                <div style="font-family: sans-serif; padding: 20px; border: 1px solid #f0f0f0;">
                    <h2 style="color: ${color};">${title}</h2>
                    <p>${message}</p>
                    <h1 style="background: #f4f4f4; padding: 10px; display: inline-block; letter-spacing: 2px;">${otp}</h1>
                    <p>Mã sẽ hết hạn sau 5 phút.</p>
                </div>
            `,
        });
    } catch (error) {
        throw new Error("Lỗi gửi email");
    }
};