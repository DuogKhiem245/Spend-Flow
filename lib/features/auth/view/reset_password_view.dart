import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String email;
  const ForgotPasswordPage({super.key, required this.email});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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
                style: CupertinoTheme.of(
                  context,
                ).textTheme.textStyle.copyWith(fontSize: 16.sp, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
