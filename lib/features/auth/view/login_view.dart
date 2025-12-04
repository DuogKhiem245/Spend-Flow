import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/auth/view/register/register_step_1.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
                    duration: Duration(milliseconds: 1000),
                    child: Image.asset(
                      CupertinoTheme.of(context).brightness == Brightness.dark
                          ? 'lib/assets/images/logoDark.png'
                          : 'lib/assets/images/logoLight.png',
                      key: ValueKey(CupertinoTheme.of(context).brightness),
                      width: 100.w,
                      height: 100.w,
                    ),
                  )
                ),
                SizedBox(height: 24.h),
                Text(
                  l10n.login,
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
                    border: Border.all(color: AppColors.borderColor, width: 0.5.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 4.h),
                    
                      Text(
                        l10n.email,
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                    
                      SizedBox(height: 8.h),
                    
                      Container(
                        decoration: BoxDecoration(
                          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
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
                                padding: EdgeInsets.all(16.w),
                                decoration: null,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                      SizedBox(height: 16.h),
                    
                      Text(
                        l10n.password,
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                    
                      SizedBox(height: 8.h),
                    
                      Container(
                        decoration: BoxDecoration(
                          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
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
                    
                      SizedBox(height: 24.h),
                    
                      CupertinoButton.filled(
                        onPressed: () {
                          // Handle login action
                        },
                        borderRadius: BorderRadius.circular(30.r),
                        child: Text(
                          l10n.login,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    
                      SizedBox(height: 6.h),
                    
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.no_account,
                            style: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.copyWith(fontSize: 14.sp),
                          ),
                          SizedBox(width: 4.w),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Text(
                              l10n.register,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const RegisterStep1Page(),
                                ),
                              );
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
