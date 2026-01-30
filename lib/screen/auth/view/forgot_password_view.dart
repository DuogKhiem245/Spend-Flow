import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';
import 'package:spend_flow/screen/auth/auth_viewmodel.dart';
import 'package:spend_flow/screen/auth/view/reset_password_view.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _viewModel = AuthViewModel();

  Future<void> _handleResetPassword(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      CheckValidWidget.showIncompleteDetailsSheet(
        context: context,
        title: l10n.incomplete_details,
        description: l10n.please_fill_required_fields,
        missingFields: [l10n.email],
        buttonText: "OK",
      );
      return;
    }

    try {
      await _viewModel.sendForgotPasswordOtp(email, context);
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => ResetPasswordPage(email: email)),
      );
    } catch (e) {
      if (context.mounted) {
        CheckValidWidget.showIncompleteDetailsSheet(
          context: context,
          title: l10n.error,
          description: _viewModel.cleanErrorMessage(e),
          buttonText: "OK",
        );
      }
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
                middle: Text(
                  l10n.reset_password,
                  style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 18.sp),
                ),
                padding: EdgeInsetsDirectional.only(end: 10.w),
                leading: CupertinoNavigationBarBackButton(
                  color: CupertinoTheme.of(context).primaryColor,
                  onPressed: () => Navigator.pop(context),
                ),
                border: null,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    l10n.forgot_password_description,
                    textAlign: TextAlign.center,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          fontSize: 15.sp,
                          color: CupertinoColors.systemGrey,
                        ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    l10n.email,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(
                        color: AppColors.borderColor.withValues(alpha: .5),
                        width: 0.5.w,
                      ),
                    ),
                    child: CupertinoTextField(
                      controller: _emailController,
                      placeholder: l10n.enter_email,
                      keyboardType: TextInputType.emailAddress,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 14.h,
                      ),
                      decoration: null,
                      style: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.copyWith(fontSize: 14.sp),
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 16.w),
                        child: Icon(
                          CupertinoIcons.mail_solid,
                          size: 16.w,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  CupertinoButton.filled(
                    onPressed: () => _handleResetPassword(context),
                    borderRadius: BorderRadius.circular(30.r),
                    child: Text(
                      l10n.send_otp,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.white,
                          ),
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
}
