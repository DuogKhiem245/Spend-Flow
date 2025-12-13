import 'package:cupertino_native/components/switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/data/language_data.dart';
import 'package:spend_flow/core/services/language_service.dart';
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

  static final List<Map<String, String>> _allLanguages = LanguageData.allLanguages;

  static String getNameByCode(String code) {
    try {
      final language = _allLanguages.firstWhere(
        (element) => element['code'] == code,
        orElse: () => _allLanguages
            .first, 
      );
      return language['name'] ?? 'English';
    } catch (e) {
      return 'English';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            l10n.general,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .6),
            ),
          ),
        ),

        _SettingItem(
          title: l10n.notifications,
          icon: CupertinoIcons.bell_fill,
          iconBgColor: const Color(0xFFE97B35),
          trailing: CNSwitch(
            value: isNotificationsEnabled,
            onChanged: (v) => setState(() => isNotificationsEnabled = v),
          ),
        ),

        _SettingItem(
          title: l10n.dark_mode,
          icon: CupertinoIcons
              .moon_fill, 
          iconBgColor: const Color(0xFF3B82F6),
          trailing: CNSwitch(
            value: isDark,
            onChanged: (v) => themeService.setTheme(v),
          ),
        ),

        _SettingItem(
          title: l10n.language,
          icon: CupertinoIcons.globe,
          iconBgColor: const Color(0xFF6366F1),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const LanguageView()),
            );
          },
          trailing: _buildTextTrailing(context, getNameByCode(LanguageService().currentLanguageName)),
        ),

        _SettingItem(
          title: l10n.currency,
          icon: CupertinoIcons.money_dollar_circle_fill,
          iconBgColor: const Color(0xFF21C55E),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const CurrencyView()),
            );
          },
          trailing: _buildTextTrailing(context, 'USD'),
        ),
      ],
    );
  }

  Widget _buildTextTrailing(BuildContext context, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: CupertinoColors.systemGrey,
          ),
        ),
        SizedBox(width: 6.w),
        Icon(
          CupertinoIcons.chevron_right,
          size: 18.sp, 
          color: CupertinoColors.systemGrey3,
        ),
      ],
    );
  }
}

class _SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconBgColor;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingItem({
    required this.title,
    required this.icon,
    required this.iconBgColor,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h), 
      height: 60.h,
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(30.r), 
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadow.withValues(
              alpha: 0.05,
            ), 
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30.r),
          splashColor: onTap == null ? Colors.transparent : null,
          highlightColor: onTap == null ? Colors.transparent : null,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  width: 36.w, 
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(icon, size: 20.sp, color: Colors.white),
                ),
                SizedBox(width: 14.w),

                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color,
                    ),
                  ),
                ),

                trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
