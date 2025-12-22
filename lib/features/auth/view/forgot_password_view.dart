import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
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
      _showDialog(l10n.error, l10n.please_enter_email_and_password);
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
        _showDialog(l10n.error, e.toString());
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showDialog(String title, String content) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(AppLocalizations.of(context)!.ok),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          l10n.forgot_password,
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
              .copyWith(fontWeight: FontWeight.w600, fontSize: 20.sp),
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
                style: TextStyle(
                  fontSize: 15.sp,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              SizedBox(height: 30.h),

              Text(
                l10n.email,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
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
                child: CupertinoTextField(
                  controller: _emailController,
                  placeholder: l10n.enter_email,
                  keyboardType: TextInputType.emailAddress,
                  padding: EdgeInsets.all(16.w),
                  decoration: null,
                  prefix: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Icon(
                      CupertinoIcons.mail_solid,
                      size: 20.w,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              CupertinoButton.filled(
                onPressed: _isLoading ? null : _handleResetPassword,
                borderRadius: BorderRadius.circular(30.r),
                child: _isLoading
                    ? CupertinoActivityIndicator(
                        color: CupertinoTheme.of(context).textTheme.textStyle.color,
                      )
                    : Text(
                        l10n.send_email_reset,
                        style: TextStyle(
                          fontSize: 18.sp,
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
