import 'package:cloud_functions/cloud_functions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';
import 'package:spend_flow/core/widgets/bottom_bar.dart';
import 'package:spend_flow/main.dart';
import 'package:spend_flow/screen/auth/auth_viewmodel.dart';
import 'package:spend_flow/screen/auth/view/forgot_password_view.dart';
import 'package:spend_flow/screen/auth/view/register_view.dart';
import 'package:spend_flow/screen/wallet/wallet_view.dart';

class LoginPage extends StatefulWidget {
  final bool fromCreateWallet;
  final bool haveBack;
  final String? email;
  const LoginPage({
    super.key,
    this.fromCreateWallet = false,
    this.haveBack = false,
    this.email,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthViewModel _viewModel = AuthViewModel();
  final _premiumViewModel = premiumViewModel;

  bool _obscurePassword = true;

  late TextEditingController _emailController;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email ?? '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final l10n = AppLocalizations.of(context)!;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    List<String> missingFields = [];

    if (email.isEmpty) {
      missingFields.add(l10n.email);
    }
    if (password.isEmpty) {
      missingFields.add(l10n.password);
    }

    if (!EmailValidator.validate(email) && email.isNotEmpty) {
      missingFields.add(l10n.invalid_email_format);
    }

    if (missingFields.isNotEmpty) {
      CheckValidWidget.showIncompleteDetailsSheet(
        context: context,
        title: l10n.incomplete_details,
        description: l10n.please_fill_required_fields,
        missingFields: missingFields,
        buttonText: "OK",
      );
      return;
    }

    try {
      await _viewModel.loginWithEmail(email, password, context);
      //await _viewModel.updateSignInMethod('password');
      _navigateToHome();
    } on FirebaseFunctionsException catch (e) {
      String message = l10n.login_error;

      switch (e.code) {
        case 'not-found':
          message = l10n.user_not_found;
          break;
        case 'unauthenticated':
          message = l10n.incorrect_email_or_password;
          break;
        case 'resource-exhausted':
          message = l10n.too_many_requests_please_try_later;
          break;
        default:
          message = e.message ?? message;
      }

      if (context.mounted) {
        CheckValidWidget.showIncompleteDetailsSheet(
          context: context,
          title: l10n.error,
          description: message,
          buttonText: "OK",
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = l10n.login_error;
      switch (e.code) {
        case 'invalid-credential':
          message = l10n.incorrect_email_or_password;
          break;
        case 'user-disabled':
          message = l10n.this_account_has_been_disabled;
          break;
        default:
          message = e.message ?? message;
      }
      if (context.mounted) {
        CheckValidWidget.showIncompleteDetailsSheet(
          context: context,
          title: l10n.error,
          description: message,
          buttonText: "OK",
        );
      }
    } catch (e) {
      if (context.mounted) {
        CheckValidWidget.showIncompleteDetailsSheet(
          context: context,
          title: l10n.error,
          description: e.toString(),
          buttonText: "OK",
        );
      }
    }
  }

  Future<void> _handleSocialLogin(
    Future<UserCredential?> Function() method,
    BuildContext context,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final credential = await method();
      if (credential != null && credential.user != null) {
        // await SyncService().syncData();
        //await _viewModel.updateSignInMethod('password');
        await _premiumViewModel.handleLoginPremium(credential.user!.uid);
        _navigateToHome();
      }
    } catch (e) {
      final errorString = e.toString().toLowerCase();
      final bool isUserCanceled =
          errorString.contains('canceled') ||
          errorString.contains('user-cancelled');

      if (isUserCanceled) {
        return;
      }
      if (context.mounted) {
        CheckValidWidget.showIncompleteDetailsSheet(
          context: context,
          title: l10n.error,
          description: l10n.have_error_occurred,
          buttonText: "OK",
        );
      }
    }
  }

  void _navigateToHome() async {
    final prefs = await SharedPreferences.getInstance();
    final bool createFirstWallet =
        prefs.getBool('create_first_wallet') ?? false;
    if (!createFirstWallet) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => const WalletView(firstWallet: true)),
          (route) => false,
        );
      }
      return;
    }
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => const BottomNavbar()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return Stack(
          children: [
            CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor: CupertinoTheme.of(
                  context,
                ).scaffoldBackgroundColor,
                padding: EdgeInsetsDirectional.only(end: 10.w),
                leading: widget.haveBack
                    ? CupertinoNavigationBarBackButton(
                        color: CupertinoTheme.of(context).primaryColor,
                        onPressed: () => Navigator.pop(context),
                      )
                    : null,
              ),
              child: child!,
            ),
            if (_viewModel.isLoading)
              Positioned.fill(
                child: Container(
                  color: CupertinoColors.black.withValues(alpha: 0.4),
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: CupertinoTheme.of(context).primaryColor,
                      size: 30.w,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
      child: SafeArea(
        top: true,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 1000),
                      child: Image.asset(
                        CupertinoTheme.of(context).brightness == Brightness.dark
                            ? 'lib/assets/images/logoDark.png'
                            : 'lib/assets/images/logoLight.png',
                        key: ValueKey(CupertinoTheme.of(context).brightness),
                        width: 125.w,
                        height: 125.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    l10n.login,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(15.w),
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: CupertinoTheme.of(context).barBackgroundColor,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(
                        color: AppColors.borderColor.withValues(alpha: .5),
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
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(height: 8.h),
                        _buildInputEmail(context, l10n),
                        SizedBox(height: 16.h),
                        Text(
                          l10n.password,
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(height: 8.h),
                        _buildInputPassword(context, l10n),
                        SizedBox(height: 8.h),
                        _buildForgotPassword(context, l10n),

                        SizedBox(height: 20.h),

                        CupertinoButton.filled(
                          onPressed: _viewModel.isLoading
                              ? null
                              : () => _handleLogin(context),
                          borderRadius: BorderRadius.circular(30.r),
                          child: Text(
                            l10n.login,
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: CupertinoColors.white,
                                ),
                          ),
                        ),

                        SizedBox(height: 6.h),

                        _buildRegister(l10n, context),

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
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text(
                                  l10n.or_continue_with,
                                  style: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle
                                      .copyWith(
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
                            context,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _buildSocialButton(
                          context: context,
                          icon: FontAwesomeIcons.apple,
                          label: l10n.sign_in_with('Apple'),
                          isApple: true,
                          onTap: () => _handleSocialLogin(
                            _viewModel.signInWithApple,
                            context,
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
  }

  Align _buildForgotPassword(BuildContext context, AppLocalizations l10n) {
    return Align(
      alignment: Alignment.centerRight,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        minimumSize: Size(0, 0),
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const ForgotPasswordPage(),
            ),
          );
        },
        child: Text(
          l10n.forgot_password,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: CupertinoTheme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  Row _buildRegister(AppLocalizations l10n, BuildContext context) {
    return Row(
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
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: CupertinoTheme.of(context).primaryColor,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const RegisterPage()),
            );
          },
        ),
      ],
    );
  }

  Container _buildInputPassword(BuildContext context, AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: AppColors.borderColor.withValues(alpha: .5),
          width: 0.5.w,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 14.w),
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
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
              decoration: null,
              style: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.copyWith(fontSize: 14.sp),
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
    );
  }

  Container _buildInputEmail(BuildContext context, AppLocalizations l10n) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: AppColors.borderColor.withValues(alpha: .5),
          width: 0.5.w,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 14.w),
            child: Icon(
              CupertinoIcons.mail_solid,
              size: 16.w,
              color: CupertinoColors.systemGrey,
            ),
          ),
          Expanded(
            child: CupertinoTextField(
              controller: _emailController,
              placeholder: l10n.enter_email,
              keyboardType: TextInputType.emailAddress,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
              decoration: null,
              style: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.copyWith(fontSize: 14.sp),
            ),
          ),
        ],
      ),
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
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30.r),
          border: border,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withValues(alpha: .1),
          //     offset: const Offset(0, 2),
          //     blurRadius: 4,
          //   ),
          // ],
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
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
