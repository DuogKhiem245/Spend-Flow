import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/widgets/otp/otp_view.dart';
import 'package:spend_flow/features/auth/view/register/register_step_2.dart'; // Đảm bảo import đúng đường dẫn

class RegisterStep1Page extends StatefulWidget {
  const RegisterStep1Page({super.key});

  @override
  State<RegisterStep1Page> createState() => _RegisterStep1PageState();
}

class _RegisterStep1PageState extends State<RegisterStep1Page> {
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 100.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1000),
                    child: Image.asset(
                      CupertinoTheme.of(context).brightness == Brightness.dark
                          ? 'lib/assets/images/logoDark.png'
                          : 'lib/assets/images/logoLight.png',
                      key: ValueKey(CupertinoTheme.of(context).brightness),
                      width: 100.w,
                      height: 100.w,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  l10n.create_account,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(fontSize: 28.sp, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 30.h),

                Container(
                  padding: EdgeInsets.all(15.w),
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).barBackgroundColor,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColors.borderColor,
                      width: 0.5.w,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 4.h),

                      Text(
                        l10n.email,
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),

                      SizedBox(height: 8.h),

                      Container(
                        decoration: BoxDecoration(
                          color: CupertinoTheme.of(
                            context,
                          ).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: AppColors.borderColor,
                            width: 0.5.w,
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Icon(
                                CupertinoIcons.mail_solid,
                                size: 20.w,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                            Expanded(
                              child: CupertinoTextField(
                                placeholder: l10n.enter_email,
                                keyboardType: TextInputType.emailAddress,
                                padding: EdgeInsets.fromLTRB(
                                  16.w,
                                  16.h,
                                  0,
                                  16.h,
                                ),
                                decoration: null,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Text(
                                l10n.send_otp,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              onPressed: () {
                                // Handle send OTP action
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Text(
                        "OTP",
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),

                      SizedBox(height: 8.h),

                      OTPInputView(
                        onChanged: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            l10n.no_otp,
                            style: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.copyWith(fontSize: 14.sp),
                          ),
                          SizedBox(width: 4.w),
                          CupertinoButton(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              l10n.resend,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onPressed: () {
                              // Handle resend action
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      CupertinoButton.filled(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const RegisterStep2Page(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(30.r),
                        child: Text(
                          l10n.continueAction,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.have_account,
                            style: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.copyWith(fontSize: 16.sp),
                          ),
                          SizedBox(width: 6.w),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Text(
                              l10n.login,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
