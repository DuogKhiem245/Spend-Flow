import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';

class CheckMailPage extends StatelessWidget {
  final String email;

  const CheckMailPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.mail_solid,
                size: 100.w,
                color: CupertinoTheme.of(context).primaryColor,
              ),

              SizedBox(height: 20.h),

              Text(
                l10n.check_your_mail,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
              ),
              SizedBox(height: 16.h),

              Text(
                l10n.we_have_sent_mail,
                textAlign: TextAlign.center,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 16.sp,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                email,
                textAlign: TextAlign.center,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                l10n.please_check_your_mail_to_verify_account,
                textAlign: TextAlign.center,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 14.sp,
                  color: CupertinoColors.systemGrey,
                ),
              ),

              SizedBox(height: 40.h),

              CupertinoButton.filled(
                onPressed: () {
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(30.r),
                child: Text(
                  l10n.back_login,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
