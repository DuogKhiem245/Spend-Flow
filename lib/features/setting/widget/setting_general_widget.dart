import 'package:cupertino_native/components/switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/setting/currency/currency_view.dart';
import 'package:spend_flow/features/setting/language/language_view.dart';
import 'package:spend_flow/main.dart' show themeService;

class SettingGeneralWidget extends StatefulWidget {
  const SettingGeneralWidget({super.key});

  @override
  State<SettingGeneralWidget> createState() => _SettingGeneralWidgetState();
}

class _SettingGeneralWidgetState extends State<SettingGeneralWidget> {
  bool isNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final bool isDark =
        CupertinoTheme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.general,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: CupertinoTheme.of(
              context,
            ).textTheme.textStyle.color?.withValues(alpha: .7),
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.boxShadow,
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 123, 53, 1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      CupertinoIcons.bell_fill,
                      size: 22.r,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    l10n.notifications,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              CNSwitch(
                value: isNotificationsEnabled,
                onChanged: (v) => setState(() => isNotificationsEnabled = v),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.boxShadow,
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(59, 130, 246, 1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      CupertinoIcons.circle_lefthalf_fill,
                      size: 22.r,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    l10n.dark_mode,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              CNSwitch(
                value: isDark,
                onChanged: (v) {
                  themeService.setTheme(v);
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),

        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const LanguageView()),
            ),
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.boxShadow,
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(99, 102, 241, 1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        CupertinoIcons.globe,
                        size: 22.r,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      l10n.language,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'English',
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: CupertinoColors.systemGrey,
                          ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 22.r,
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 10.h),

        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const CurrencyView()),
            ),
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.boxShadow,
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(33, 197, 94, 1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        CupertinoIcons.money_dollar_circle,
                        size: 22.r,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      l10n.currency,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'USD',
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: CupertinoColors.systemGrey,
                          ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      CupertinoIcons.chevron_right,
                      size: 22.r,
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
