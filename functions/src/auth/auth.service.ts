import { Resend } from "resend";

const resend = new Resend(process.env.RESEND_API_KEY);

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
    footer:
      "Mã này có hiệu lực trong <b>5 phút</b>. Vui lòng không chia sẻ cho bất kỳ ai.",
  },
  en: {
    title: "Spend Flow Authentication",
    subjectRegister: "Registration code for creating an account",
    subjectReset: "Password reset code for resetting your password",
    greeting: "Hi there,",
    actionRegister: "registering an account for Spend Flow",
    actionReset: "resetting your password for Spend Flow",
    otpLabel: "Your verification code is:",
    footer:
      "This code is valid for <b>5 minutes</b>. Please do not share it with anyone.",
  },
};

export const sendOTPEmail = async (
  email: string,
  otp: string,
  type: "REGISTER" | "RESET",
  lang: string = "en",
) => {
  const t = translations[lang] || translations["en"];
  const isRegister = type === "REGISTER";
  const subjectPrefix = isRegister ? t.subjectRegister : t.subjectReset;
  const actionText = isRegister ? t.actionRegister : t.actionReset;

  const htmlContent = `
        <div style="font-family: sans-serif; max-width: 600px; margin: auto; border: 1px solid #eee; padding: 20px; border-radius: 10px;">
            <h2 style="color: #2196F3; text-align: center;">${t.title}</h2>
            <p>${t.greeting}</p>
            <p>Bạn đang thực hiện ${actionText}.</p>
            <p style="text-align: center; margin-top: 25px;">${t.otpLabel}</p>
            <div style="background: #f8f9fa; padding: 20px; text-align: center; font-size: 36px; font-weight: bold; color: #2196F3; letter-spacing: 8px; border-radius: 8px; margin: 10px 0;">
                ${otp}
            </div>
            <p style="margin-top: 20px; color: #666; font-size: 13px; text-align: center;">${t.footer}</p>
            <hr style="border: none; border-top: 1px solid #eee; margin: 20px 0;">
            <p style="font-size: 11px; color: #aaa; text-align: center;">© 2026 Spend Flow Team. Sent via Resend.</p>
        </div>
    `;

  try {
    const { data, error } = await resend.emails.send({
      from: "Spend Flow <no-reply.spendflow@24dklabs.online>",
      to: [email],
      subject: `[Spend Flow] ${subjectPrefix}`,
      html: htmlContent,
    });

    if (error) {
      throw new Error(error.message);
    }

    console.log(`[AUTH] Email sent via Resend to ${email}. ID: ${data?.id}`);
  } catch (error) {
    console.error("[ERROR][SEND_EMAIL_RESEND]", error);
    throw error;
  }
};