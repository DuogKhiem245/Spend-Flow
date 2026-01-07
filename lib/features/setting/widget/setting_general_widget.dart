import 'package:cupertino_native/components/switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/data/language_data.dart';
import 'package:spend_flow/core/services/language_service.dart';
import 'package:spend_flow/features/setting/currency/currency_view.dart';
import 'package:spend_flow/features/setting/language/language_view.dart';
import 'package:spend_flow/features/setting/notification/notification_viewmodel.dart';
import 'package:spend_flow/features/setting/setting_viewmodel.dart';
import 'package:spend_flow/features/setting/widget/setting_item_widget.dart';
import 'package:spend_flow/main.dart';

class SettingGeneralWidget extends StatefulWidget {
  const SettingGeneralWidget({super.key});

  @override
  State<SettingGeneralWidget> createState() => _SettingGeneralWidgetState();
}

class _SettingGeneralWidgetState extends State<SettingGeneralWidget> {
  final NotificationViewModel _viewModel = NotificationViewModel();
  final SettingViewModel _settingViewModel = SettingViewModel();

  static final List<Map<String, String>> _allLanguages =
      LanguageData.allLanguages;

  static String getNameByCode(String code) {
    try {
      final language = _allLanguages.firstWhere(
        (element) => element['code'] == code,
        orElse: () => _allLanguages.first,
      );
      return language['name'] ?? 'English';
    } catch (e) {
      return 'English';
    }
  }

  @override
  void initState() {
    super.initState();
    _viewModel.loadNotificationState();
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

        ListenableBuilder(
          listenable: _viewModel,
          builder: (context, child) {
            return SettingItem(
              title: l10n.notifications,
              icon: CupertinoIcons.bell_fill,
              iconBgColor: const Color.fromARGB(255, 255, 98, 0),
              trailing: CNSwitch(
                value: _viewModel.isNotificationsEnabled,
                onChanged: (v) => _viewModel.toggleNotification(v, context),
              ),
            );
          },
        ),

        SettingItem(
          title: l10n.dark_mode,
          icon: CupertinoIcons.moon_fill,
          iconBgColor: const Color(0xFF3B82F6),
          trailing: CNSwitch(
            value: isDark,
            onChanged: (v) => themeService.setTheme(v),
          ),
        ),

        SettingItem(
          title: l10n.language,
          icon: CupertinoIcons.globe,
          iconBgColor: Color(0xFF7C3AED),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const LanguageView()),
            );
          },
          trailing: _buildTextTrailing(
            context,
            getNameByCode(LanguageService().currentLanguageName),
          ),
        ),

        ListenableBuilder(
          listenable: _settingViewModel,
          builder: (context, child) {
            return SettingItem(
              title: l10n.currency,
              icon: CupertinoIcons.money_dollar_circle_fill,
              iconBgColor: const Color(0xFF21C55E),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const CurrencyView(),
                  ),
                );
              },
              trailing: _buildTextTrailing(
                context,
                _settingViewModel.currentCurrencyCode,
              ),
            );
          },
        ),

        // _SettingItem(
        //   title: l10n.card,
        //   icon: CupertinoIcons.creditcard,
        //   iconBgColor: Color(0xFFF59E0B),
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       CupertinoPageRoute(builder: (context) => const PaymentView()),
        //     );
        //   },
        //   trailing: _buildTextTrailing(
        //     context,
        //     ''
        //   ),
        // ),
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

