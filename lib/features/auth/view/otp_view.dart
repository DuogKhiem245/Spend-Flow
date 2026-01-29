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
import 'package:spend_flow/features/auth/auth_viewmodel.dart';
import 'package:spend_flow/features/auth/view/login_view.dart';

class OTPPage extends StatefulWidget {
  final String email;
  final String? password;

  const OTPPage({super.key, required this.email, this.password});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final AuthViewModel _authViewModel = AuthViewModel();

  final TextEditingController _currentController = TextEditingController();
  final FocusNode _currentFocus = FocusNode();
  final FocusNode _newFocus = FocusNode();

  Timer? _timer;
  int _start = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _canResend = false;
    _start = 60;
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
    _currentController.dispose();
    _currentFocus.dispose();
    _newFocus.dispose();
    super.dispose();
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
                backgroundColor: CupertinoTheme.of(
                  context,
                ).scaffoldBackgroundColor,
                padding: EdgeInsetsDirectional.only(end: 10.w),
                leading: CupertinoNavigationBarBackButton(
                  color: CupertinoTheme.of(context).primaryColor,
                  onPressed: () =>
                      _authViewModel.isLoading ? null : Navigator.pop(context),
                ),
              ),
              child: child!,
            ),
            if (_authViewModel.isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.4),
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
              padding: EdgeInsets.only(bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: SizedBox(
                      width: 100.w,
                      height: 100.w,
                      child: Image.asset(
                        CupertinoTheme.of(context).brightness == Brightness.dark
                            ? 'lib/assets/images/logoDark.png'
                            : 'lib/assets/images/logoLight.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    l10n.verify_otp,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      l10n.we_sent_otp,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 16.sp,
                            color: CupertinoColors.systemGrey,
                          ),
                      textAlign: TextAlign.center,
                    ),
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
                      children: [
                        _buildPinCodeInput(
                          controller: _currentController,
                          focusNode: _currentFocus,
                          isAutoFocus: true,
                          nextFocus: _newFocus,
                        ),
                        SizedBox(height: 24.h),
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
                                if (!_canResend) return;
                                HapticFeedback.mediumImpact();
                                try {
                                  await _authViewModel.resendOtp(
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
                        SizedBox(height: 24.h),
                        SizedBox(
                          width: double.infinity,
                          child: CupertinoButton.filled(
                            borderRadius: BorderRadius.circular(30.r),
                            child: Text(
                              l10n.verify,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: CupertinoColors.white,
                                  ),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              String otp = _currentController.text;
                              HapticFeedback.mediumImpact();
                              if (otp.length == 6) {
                                try {
                                  await _authViewModel.verifyOtp(
                                    context,
                                    widget.email,
                                    otp,
                                  );
                                  if (!context.mounted) return;
                                  AdaptiveAlertDialog.show(
                                    context: context,
                                    title: l10n.register_successful,
                                    message:
                                        l10n.register_successful_description,
                                    icon: 'checkmark.seal.fill',
                                    actions: [
                                      AlertAction(
                                        title: "OK",
                                        style: AlertActionStyle.primary,
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => LoginPage(
                                                email: widget.email,
                                                haveBack: false,
                                              ),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                } catch (e) {
                                  CheckValidWidget.showIncompleteDetailsSheet(
                                    context: context,
                                    title: l10n.error,
                                    description: e.toString(),
                                    buttonText: "OK",
                                  );
                                }
                              } else {
                                CheckValidWidget.showIncompleteDetailsSheet(
                                  context: context,
                                  title: l10n.error,
                                  description: l10n.plese_enter_valid_otp,
                                  buttonText: "OK",
                                );
                              }
                            },
                          ),
                        ),
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
}
