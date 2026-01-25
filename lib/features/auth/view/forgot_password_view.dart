import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';
import 'package:spend_flow/features/auth/auth_viewmodel.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _viewModel = AuthViewModel();
  bool _isLoading = false;

  Future<void> _handleResetPassword() async {
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

    setState(() => _isLoading = true);

    try {
      await _viewModel.resetPassword(email);

      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: Text(l10n.success),
            content: Text(l10n.password_reset_email_sent),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(l10n.ok),
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        CheckValidWidget.showIncompleteDetailsSheet(
          context: context,
          title: l10n.error,
          description: e.toString(),
          buttonText: "OK",
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          l10n.reset_password,
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
              .copyWith(fontWeight: FontWeight.w600, fontSize: 18.sp),
        ),
        border: null,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.h),
              Text(
                l10n.forgot_password_description,
                textAlign: TextAlign.center,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 15.sp,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              SizedBox(height: 30.h),

              Text(
                l10n.email,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
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
                onPressed: _isLoading ? null : _handleResetPassword,
                borderRadius: BorderRadius.circular(30.r),
                child: _isLoading
                    ? CupertinoActivityIndicator(
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color,
                      )
                    : Text(
                        l10n.send_email_reset,
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
