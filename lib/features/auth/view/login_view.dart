import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/widgets/nav.dart';
import 'package:spend_flow/features/auth/auth_viewmodel.dart';
import 'package:spend_flow/features/auth/view/register/register_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthViewModel _viewModel = AuthViewModel();

  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();
    final l10n = AppLocalizations.of(context)!;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog(l10n.please_enter_email_and_password);
      return;
    }

    try {
      final user = await _viewModel.loginWithEmail(email, password);

      if (user != null) {
        if (user.emailVerified) {
          _navigateToHome();
        } else {
          if (mounted) _showVerificationDialog(user);
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = l10n.login_error;
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          message = l10n.incorrect_email_or_password;
          break;
        case 'invalid-email':
          message = l10n.invalid_email_format;
          break;
        case 'user-disabled':
          message = l10n.this_account_has_been_disabled;
          break;
        case 'too-many-requests':
          message = l10n.too_many_requests_please_try_later;
          break;
        default:
          message = e.message ?? message;
      }
      if (mounted) _showErrorDialog(message);
    } catch (e) {
      if (mounted) _showErrorDialog(l10n.login_error);
    }
  }

  Future<void> _handleSocialLogin(
    Future<UserCredential?> Function() method,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final credential = await method();
      if (credential != null && credential.user != null) {
        _navigateToHome();
      }
    } catch (e) {
      if (mounted) _showErrorDialog(l10n.have_error_occurred);
    }
  }

  void _navigateToHome() {
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => const BottomNavbar()),
        (route) => false,
      );
    }
  }

  void _showErrorDialog(String message) {
    final l10n = AppLocalizations.of(context)!;
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(l10n.error),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(l10n.ok),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  void _showVerificationDialog(User user) {
    final l10n = AppLocalizations.of(context)!;
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(l10n.email_not_verified),
        content: Text(l10n.please_verify_your_email_to_continue),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.resend),
            onPressed: () async {
              try {
                await user.sendEmailVerification();
                if (!context.mounted) return;
                Navigator.pop(ctx);
                await _viewModel.signOut();
              } catch (e) {
                debugPrint(e.toString());
              }
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(l10n.ok),
            onPressed: () async {
              Navigator.pop(ctx);
              await _viewModel.signOut();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        final isLoading = _viewModel.isLoading;

        return CupertinoPageScaffold(
          child: SafeArea(
            top: true,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              behavior: HitTestBehavior.translucent,
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.r),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 1000),
                          child: Image.asset(
                            CupertinoTheme.of(context).brightness ==
                                    Brightness.dark
                                ? 'lib/assets/images/logoDark.png'
                                : 'lib/assets/images/logoLight.png',
                            key: ValueKey(
                              CupertinoTheme.of(context).brightness,
                            ),
                            width: 100.w,
                            height: 100.w,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        l10n.login,
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
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
                              l10n.email,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
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
                                      controller: _emailController,
                                      placeholder: l10n.enter_email,
                                      keyboardType: TextInputType.emailAddress,
                                      padding: EdgeInsets.all(16.w),
                                      decoration: null,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              l10n.password,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
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
                                      controller: _passwordController,
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
                              onPressed: isLoading ? null : _handleLogin,
                              borderRadius: BorderRadius.circular(30.r),
                              child: isLoading
                                  ? const CupertinoActivityIndicator(
                                      color: CupertinoColors.white,
                                    )
                                  : Text(
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
                                  style: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle
                                      .copyWith(fontSize: 14.sp),
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
                                        builder: (context) =>
                                            const RegisterPage(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),

                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Divider(
                                      color: CupertinoColors.systemGrey4,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
                                    child: Text(
                                      l10n.or_continue_with,
                                      style: TextStyle(
                                        color: CupertinoColors.systemGrey,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Divider(
                                      color: CupertinoColors.systemGrey4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),

                            _buildSocialButton(
                              context: context,
                              imageAsset: 'lib/assets/images/google.png',
                              label: l10n.sign_in_with('Google'),
                              onTap: () => _handleSocialLogin(
                                _viewModel.signInWithGoogle,
                              )
                            ),

                            SizedBox(height: 12.h),

                            _buildSocialButton(
                              context: context,
                              icon: FontAwesomeIcons.apple,
                              label: l10n.sign_in_with('Apple'),
                              isApple: true,
                              onTap: () => _handleSocialLogin(
                                _viewModel.signInWithApple,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
    IconData? icon,
    String? imageAsset,
    Color? iconColor,
    bool isApple = false,
    bool isLoading = false,
  }) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;

    Color backgroundColor;
    Color textColor;
    Color finalIconColor;
    Border? border;

    if (isApple) {
      backgroundColor = isDark ? CupertinoColors.white : CupertinoColors.black;
      textColor = isDark ? CupertinoColors.black : CupertinoColors.white;
      finalIconColor = textColor;
    } else {
      backgroundColor = CupertinoColors.white;
      textColor = CupertinoColors.black;
      finalIconColor = iconColor ?? textColor;
      border = Border.all(color: CupertinoColors.systemGrey4, width: 1.0);
    }

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isLoading ? 0.6 : 1.0,
        child: Container(
          height: 52.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(30.r),
            border: border,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .1),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageAsset != null)
                Image.asset(imageAsset, width: 22.w, height: 22.w)
              else if (icon != null)
                FaIcon(icon, size: 26.sp, color: finalIconColor),
              SizedBox(width: 12.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
