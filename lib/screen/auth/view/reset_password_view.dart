import 'dart:async';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';
import 'package:spend_flow/core/widgets/password_strength/password_strength.dart';
import 'package:spend_flow/screen/auth/auth_viewmodel.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final AuthViewModel _authViewModel = AuthViewModel();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _currentController = TextEditingController();
  final FocusNode _currentFocus = FocusNode();
  final FocusNode _newFocus = FocusNode();

  Timer? _timer;
  int _start = 60;
  bool _canResend = false;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String password = '';
  String confirmPassword = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _start = 90;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _currentController.dispose();
    _currentFocus.dispose();
    _newFocus.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    FocusScope.of(context).unfocus();

    final l10n = AppLocalizations.of(context)!;

    final otp = _currentController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPass = _confirmPasswordController.text.trim();

    List<String> missingFields = [];
    String title = l10n.incomplete_details;
    String description = l10n.please_fill_required_fields;

    if (otp.isEmpty || otp.length != 6) missingFields.add("OTP");
    if (password.isEmpty) missingFields.add(l10n.password);
    if (confirmPass.isEmpty) missingFields.add(l10n.confirm_password);

    if (missingFields.isEmpty) {
      if (password != confirmPass) {
        title = l10n.passwords_mismatch;
        description = l10n.please_edit_fields;
        missingFields.addAll([l10n.password, l10n.confirm_password]);
      } else if (!PasswordStrength.isValid(password)) {
        title = l10n.password_weak_password;
        description = l10n.please_edit_fields;
        missingFields.add(l10n.password);
      }
    }

    if (missingFields.isNotEmpty) {
      CheckValidWidget.showIncompleteDetailsSheet(
        context: context,
        title: title,
        description: description,
        missingFields: missingFields,
        buttonText: "OK",
      );
      return;
    }

    try {
      await _authViewModel.resetPassword(
        widget.email,
        _currentController.text,
        password,
        context,
      );
      if (!mounted) return;
      AdaptiveAlertDialog.show(
        context: context,
        title: l10n.reset_password_successful,
        message: l10n.reset_password_successful_description,
        icon: 'checkmark.seal.fill',
        actions: [
          AlertAction(
            title: "OK",
            style: AlertActionStyle.primary,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    } catch (e) {
      if (mounted) {
        CheckValidWidget.showIncompleteDetailsSheet(
          context: context,
          title: l10n.error,
          description: _authViewModel.cleanErrorMessage(e),
          buttonText: "OK",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: _authViewModel,
      builder: (context, child) {
        return Stack(
          children: [
            CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text(
                  l10n.reset_password,
                  style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 18.sp),
                ),
                border: null,
                backgroundColor: CupertinoTheme.of(
                  context,
                ).scaffoldBackgroundColor,
                leading: CupertinoNavigationBarBackButton(
                  color: CupertinoTheme.of(context).primaryColor,
                  onPressed: () => Navigator.pop(context),
                ),
                padding: EdgeInsetsDirectional.only(end: 10.w),
              ),
              child: child!,
            ),
            if (_authViewModel.isLoading)
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    l10n.enter_otp_reset_password,
                    textAlign: TextAlign.center,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(fontSize: 16.sp, height: 1.5),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(15.w),
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
                          "OTP",
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(height: 8.h),
                        _buildPinCodeInput(
                          controller: _currentController,
                          focusNode: _currentFocus,
                          isAutoFocus: true,
                          nextFocus: _newFocus,
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.dont_receive_otp,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    fontSize: 14.sp,
                                    color: CupertinoColors.systemGrey,
                                  ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              minimumSize: Size.zero,
                              child: Text(
                                l10n.resend,
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: CupertinoTheme.of(
                                        context,
                                      ).primaryColor,
                                    ),
                              ),
                              onPressed: () async {
                                if (!_canResend) {
                                  CheckValidWidget.showIncompleteDetailsSheet(
                                    context: context,
                                    title: l10n.error,
                                    description:
                                        l10n.not_time_yet_to_resend_otp,
                                    buttonText: "OK",
                                  );
                                  return;
                                }
                                HapticFeedback.mediumImpact();
                                try {
                                  await _authViewModel.resendForgotPasswordOtp(
                                    widget.email,
                                    context,
                                  );
                                  _startTimer();
                                } catch (e) {
                                  if (!context.mounted) return;
                                  CheckValidWidget.showIncompleteDetailsSheet(
                                    context: context,
                                    title: l10n.error,
                                    description: e.toString(),
                                    buttonText: "OK",
                                  );
                                }
                              },
                            ),
                            _canResend
                                ? const SizedBox.shrink()
                                : Text(
                                    "(${_start}s)",
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: CupertinoTheme.of(
                                            context,
                                          ).primaryColor,
                                        ),
                                  ),
                          ],
                        ),
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
                        _buildPasswordField(
                          context: context,
                          controller: _passwordController,
                          placeholder: l10n.password,
                          obscureText: _obscurePassword,
                          onToggle: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),

                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsets.only(left: 8.w),
                          child: PasswordStrength(
                            password: _passwordController.text,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        Text(
                          l10n.confirm_password,
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(height: 8.h),
                        _buildPasswordField(
                          context: context,
                          controller: _confirmPasswordController,
                          placeholder: l10n.confirm_password,
                          obscureText: _obscureConfirmPassword,
                          onToggle: () => setState(
                            () => _obscureConfirmPassword =
                                !_obscureConfirmPassword,
                          ),
                          onChanged: (value) {
                            setState(() {
                              confirmPassword = value;
                            });
                          },
                        ),

                        SizedBox(height: 16.h),

                        CupertinoButton.filled(
                          onPressed: _authViewModel.isLoading
                              ? null
                              : () => _handleResetPassword(),
                          borderRadius: BorderRadius.circular(30.r),
                          child: Text(
                            l10n.reset_password,
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

                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeInput({
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool isAutoFocus,
    FocusNode? prevFocus,
    FocusNode? nextFocus,
  }) {
    return AnimatedBuilder(
      animation: Listenable.merge([controller, focusNode]),
      builder: (context, child) {
        return SizedBox(
          height: 60.h,
          child: Stack(
            children: [
              Positioned.fill(
                child: CupertinoTextField(
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: isAutoFocus,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  style: const TextStyle(color: Colors.transparent),
                  cursorColor: Colors.transparent,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    HapticFeedback.lightImpact();
                    if (value.length == 6 && nextFocus != null) {
                      nextFocus.requestFocus();
                    }
                    if (value.isEmpty && prevFocus != null) {
                      prevFocus.requestFocus();
                    }
                  },
                ),
              ),

              IgnorePointer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    final isFilled = index < controller.text.length;
                    final isFocused =
                        focusNode.hasFocus && index == controller.text.length;
                    final String digit = isFilled ? controller.text[index] : "";

                    return _buildSingleDigitBox(
                      digit: digit,
                      isFocused: isFocused && FocusScope.of(context).hasFocus,
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSingleDigitBox({
    required String digit,
    required bool isFocused,
  }) {
    final theme = CupertinoTheme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: 48.w,
      height: 56.h,
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2C2C2E) : CupertinoColors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: isFocused
              ? theme.primaryColor
              : (isDarkMode ? Colors.white12 : Colors.black12),
          width: isFocused ? 2 : 1,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          digit,
          style: theme.textTheme.textStyle.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: theme.textTheme.textStyle.color,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required BuildContext context,
    required TextEditingController controller,
    required String placeholder,
    required bool obscureText,
    required VoidCallback onToggle,
    required ValueChanged<String> onChanged,
  }) {
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
            padding: EdgeInsets.only(left: 16.w),
            child: Icon(
              CupertinoIcons.lock_fill,
              size: 16.w,
              color: CupertinoColors.systemGrey,
            ),
          ),
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              obscureText: obscureText,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
              decoration: null,
              style: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.copyWith(fontSize: 14.sp),
              onChanged: (value) {
                setState(() {
                  onChanged(value);
                });
              },
            ),
          ),
          GestureDetector(
            onTap: onToggle,
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Icon(
                obscureText
                    ? CupertinoIcons.eye_slash_fill
                    : CupertinoIcons.eye_fill,
                size: 18.w,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
