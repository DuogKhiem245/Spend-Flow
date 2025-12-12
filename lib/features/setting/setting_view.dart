import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/features/setting/widget/account_widget.dart';
import 'package:spend_flow/features/setting/widget/setting_general_widget.dart';
import 'package:spend_flow/features/setting/widget/setting_security_widget.dart';
import 'package:spend_flow/features/setting/widget/upgrade_premium_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10.h,
          left: 16.w,
          right: 16.w,
          bottom: 10.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AccountWidget(isLoggedIn: _isLoggedIn),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  children: [
                    const UpgradePremiumWidget(),
                    SizedBox(height: 30.h),
                    const SettingGeneralWidget(),
                    SizedBox(height: 20.h),
                    const SettingSecurityWidget(),
                    SizedBox(height: 40.h),
                    _isLoggedIn
                        ? CupertinoButton(
                            onPressed: () {
                              setState(() {
                                _isLoggedIn = false;
                              });
                            },
                            borderRadius: BorderRadius.circular(30.r),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            minimumSize: Size(double.infinity, 60.h),
                            color: CupertinoTheme.of(
                              context,
                            ).barBackgroundColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.square_arrow_right,
                                  color: CupertinoColors.systemRed,
                                  size: 20.r,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  l10n.logout,
                                  style: TextStyle(
                                    color: CupertinoColors.systemRed,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
