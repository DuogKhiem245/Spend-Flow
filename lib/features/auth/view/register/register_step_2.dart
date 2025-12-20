import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/widgets/password_strength/password_strength.dart';

class RegisterStep2Page extends StatefulWidget {
  const RegisterStep2Page({super.key});

  @override
  State<RegisterStep2Page> createState() => _RegisterStep2PageState();
}

class _RegisterStep2PageState extends State<RegisterStep2Page> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String password = "";
  String confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CupertinoPageScaffold(
      child: SafeArea(
        top: true,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.translucent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
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
                l10n.create_password,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
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
                      l10n.password,
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
                              CupertinoIcons.lock_fill,
                              size: 20.w,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                          Expanded(
                            child: CupertinoTextField(
                              placeholder: l10n.enter_your_password,
                              obscureText: _obscurePassword,
                              padding: EdgeInsets.all(16.h),
                              decoration: null,
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: Icon(
                                _obscurePassword
                                    ? CupertinoIcons.eye_slash_fill
                                    : CupertinoIcons.eye_fill,
                                size: 20.w,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    PasswordStrength(password: password),

                    SizedBox(height: 16.h),

                    Text(
                      l10n.confirm_password,
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
                              CupertinoIcons.lock_fill,
                              size: 20.w,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                          Expanded(
                            child: CupertinoTextField(
                              placeholder: l10n.enter_your_password,
                              obscureText: _obscureConfirmPassword,
                              padding: EdgeInsets.all(16.h),
                              decoration: null,
                              onChanged: (value) {
                                setState(() {
                                  confirmPassword = value;
                                });
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: Icon(
                                _obscureConfirmPassword
                                    ? CupertinoIcons.eye_slash_fill
                                    : CupertinoIcons.eye_fill,
                                size: 20.w,
                                color: CupertinoColors.systemGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    AnimatedOpacity(
                      opacity:
                          (password == confirmPassword ||
                              confirmPassword.isEmpty)
                          ? 0.0
                          : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.h, left: 10.w),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.exclamationmark_circle_fill,
                              color: CupertinoColors.systemRed,
                              size: 14.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              l10n.passwords_mismatch,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    fontSize: 14.sp,
                                    color: CupertinoColors.systemRed,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    CupertinoButton.filled(
                      onPressed: () {
                        // Handle register action
                      },
                      borderRadius: BorderRadius.circular(30.r),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Text(
                        l10n.create_account,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
