import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/features/setting/widget/account_widget.dart';
import 'package:spend_flow/features/setting/widget/setting_general_widget.dart';
import 'package:spend_flow/features/setting/widget/setting_security_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return CupertinoPageScaffold(
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text(
      //     'Setting',
      //     style: CupertinoTheme.of(context).textTheme.navTitleTextStyle
      //         .copyWith(fontWeight: FontWeight.w600, fontSize: 20.sp),
      //   ),
      // ),
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
            AccountWidget(),
            SizedBox(height: 20.h),
            SettingGeneralWidget(),
            SizedBox(height: 20.h),
            SettingSecurityWidget(),
            SizedBox(height: 30.h),
            CupertinoButton.filled(
              onPressed: () {},
              minimumSize: Size(double.infinity, 40.h),
              color: CupertinoTheme.of(context).barBackgroundColor,
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
            ),
          ],
        ),
      ),
    );
  }
}
