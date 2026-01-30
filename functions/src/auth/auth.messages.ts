export const authMessages: Record<string, any> = {
    vi: {
        otpSent: "Mã OTP đã được gửi.",
        newOtpSent: "Mã OTP mới đã được gửi!",
        verifySuccess: "Xác thực thành công!",
        passwordUpdated: "Mật khẩu đã được cập nhật!",
        emailExists: "Email này đã được đăng ký.",
        userNotFound: "Tài khoản không tồn tại.",
        invalidOtp: "Mã OTP không chính xác.",
        otpExpired: "Mã OTP đã hết hạn.",
        wrongPassword: "Sai mật khẩu.",
        waitResend: "Vui lòng đợi 60 giây.",
        missingFields: "Thiếu thông tin bắt buộc.",
        reqNotFound: "Yêu cầu không tồn tại hoặc hết hạn.",
        emailUsedWithSocial: "Email này đã được đăng ký bằng Google hoặc Apple. Vui lòng sử dụng phương thức đăng nhập tương ứng."
    },
    en: {
        otpSent: "OTP code has been sent.",
        newOtpSent: "A new OTP code has been sent!",
        verifySuccess: "Verification successful!",
        passwordUpdated: "Password has been updated!",
        emailExists: "This email is already registered.",
        userNotFound: "Account does not exist.",
        invalidOtp: "Incorrect OTP code.",
        otpExpired: "OTP code has expired.",
        wrongPassword: "Wrong password.",
        waitResend: "Please wait 60 seconds.",
        missingFields: "Missing required fields.",
        reqNotFound: "Request not found or expired.",
        emailUsedWithSocial: "This email is registered with Google or Apple. Please use the corresponding login method."
    }
};

export const getT = (lang: string = 'en') => authMessages[lang] || authMessages['en'];