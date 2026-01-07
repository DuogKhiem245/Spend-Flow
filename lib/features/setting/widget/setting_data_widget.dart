import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/features/setting/currency/currency_view.dart';
import 'package:spend_flow/features/setting/widget/setting_item_widget.dart';

class SettingDataWidget extends StatefulWidget {
  const SettingDataWidget({super.key});

  @override
  State<SettingDataWidget> createState() => _SettingDataWidgetState();
}

class _SettingDataWidgetState extends State<SettingDataWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            l10n.data_management,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .6),
            ),
          ),
        ),
        SettingItem(
          title: l10n.export_data,
          icon: CupertinoIcons.doc_on_doc_fill,
          iconBgColor: const Color(0xFF21C55E),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const CurrencyView()),
            );
          },
          trailing: Icon(
            CupertinoIcons.chevron_right,
            size: 18.sp,
            color: CupertinoColors.systemGrey3,
          ),
        ),
        SettingItem(
          title: l10n.import_data,
          icon: CupertinoIcons.cloud_download_fill,
          iconBgColor: const Color(0xFF2563EB),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => const CurrencyView()),
            );
          },
          trailing: Icon(
            CupertinoIcons.chevron_right,
            size: 18.sp,
            color: CupertinoColors.systemGrey3,
          ),
        ),
      ],
    );
  }
}
