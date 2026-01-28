import nodemailer from "nodemailer";

interface EmailContent {
    title: string;
    subjectRegister: string;
    subjectReset: string;
    greeting: string;
    actionRegister: string;
    actionReset: string;
    otpLabel: string;
    footer: string;
}

const translations: Record<string, EmailContent> = {
    vi: {
        title: "Xác thực Spend Flow",
        subjectRegister: "Mã xác thực đăng ký tài khoản của bạn",
        subjectReset: "Mã đặt lại mật khẩu của bạn",
        greeting: "Chào bạn,",
        actionRegister: "đăng ký tài khoản ứng dụng Spend Flow",
        actionReset: "đặt lại mật khẩu ứng dụng Spend Flow",
        otpLabel: "Mã xác thực của bạn là:",
        footer: "Mã này có hiệu lực trong <b>5 phút</b>. Vui lòng không chia sẻ cho bất kỳ ai."
    },
    en: {
        title: "Spend Flow Authentication",
        subjectRegister: "Registration code for creating an account",
        subjectReset: "Password reset code for resetting your password",
        greeting: "Hi there,",
        actionRegister: "registering an account for Spend Flow",
        actionReset: "resetting your password for Spend Flow",
        otpLabel: "Your verification code is:",
        footer: "This code is valid for <b>5 minutes</b>. Please do not share it with anyone."
    }
};

export const sendOTPEmail = async (
    email: string,
    otp: string,
    type: 'REGISTER' | 'RESET',
    lang: string = 'en' 
) => {
    const t = translations[lang] || translations['en'];

    const transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: "spendflow.noreply@gmail.com",
            pass: process.env.GMAIL_APP_PASSWORD,
        },
    });

    const isRegister = type === 'REGISTER';
    const subjectPrefix = isRegister ? t.subjectRegister : t.subjectReset;
    const actionText = isRegister ? t.actionRegister : t.actionReset;

    const htmlContent = `
        <div style="font-family: sans-serif; max-width: 600px; margin: auto; border: 1px solid #eee; padding: 20px;">
            <h2 style="color: #333;">${t.title}</h2>
            <p>${t.greeting} bạn đang thực hiện ${actionText}.</p>
            <p>${t.otpLabel}</p>
            <div style="background: #f4f4f4; padding: 15px; text-align: center; font-size: 32px; font-weight: bold; color: #2196F3; letter-spacing: 5px;">
                ${otp}
            </div>
            <p style="margin-top: 20px; color: #666;">${t.footer}</p>
        </div>
    `;

    try {
        await transporter.sendMail({
            from: '"Spend Flow" <spendflow.noreply@gmail.com>',
            to: email,
            subject: `[Spend Flow] ${subjectPrefix}`,
            html: htmlContent,
        });
        console.log(`[AUTH] Email sent (${lang}) to ${email}`);
    } catch (error) {
        console.error("[ERROR][SEND_EMAIL]", error);
        throw error;
    }
};