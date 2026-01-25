import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/services/sync_service/sync_service.dart';
import 'package:spend_flow/features/premium/premium_view.dart';
import 'package:spend_flow/features/setting/data_management/export/export_view.dart';
import 'package:spend_flow/features/setting/data_management/import/import_view.dart';
import 'package:spend_flow/features/setting/widget/setting_item_widget.dart';

class SettingDataWidget extends StatefulWidget {
  final String lastSyncText;
  final VoidCallback onSyncSuccess;
  const SettingDataWidget({super.key, required this.lastSyncText, required this.onSyncSuccess});

  @override
  State<SettingDataWidget> createState() => _SettingDataWidgetState();
}

class _SettingDataWidgetState extends State<SettingDataWidget> {
  bool _isLoading = false;

  void _showPremiumModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      builder: (context) => const PremiumView(),
    );
  }

  Future<void> _onTap() async {
    final bool isPremium = await LocalStorageService().getPremiumStatus();

    if (!mounted) return;

    if (!isPremium) {
      _showPremiumModal(context);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await SyncService().syncData(force: true);
      widget.onSyncSuccess();
    } catch (e) {
      debugPrint("Sync Error: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
          title: l10n.sync_data,
          description: l10n.last_synced(widget.lastSyncText),
          icon: CupertinoIcons.arrow_2_circlepath,
          iconBgColor: CupertinoColors.activeOrange,
          onTap: () {},
          trailing: GestureDetector(
            onTap: _onTap,
            child: Text(
              _isLoading ? l10n.syncing : l10n.sync_data_now,
              style: TextStyle(
                fontSize: 14.sp,
                color: CupertinoColors.systemBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SettingItem(
          title: l10n.export_data,
          icon: CupertinoIcons.cloud_download_fill,
          iconBgColor: Color.fromRGBO(77, 85, 98, 1),
          onTap: () async {
            final bool isPremium = await LocalStorageService()
                .getPremiumStatus();

            if (!context.mounted) return;

            if (isPremium) {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const ExportView()),
              );
            } else {
              _showPremiumModal(context);
            }
          },
          trailing: Icon(
            CupertinoIcons.chevron_right,
            size: 18.sp,
            color: CupertinoColors.systemGrey3,
          ),
        ),
        SettingItem(
          title: l10n.import_data,
          icon: CupertinoIcons.cloud_upload_fill,
          iconBgColor: Color.fromRGBO(85, 181, 166, 1),
          onTap: () async {
            final bool isPremium = await LocalStorageService()
                .getPremiumStatus();

            if (!context.mounted) return;

            if (isPremium) {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const ImportView()),
              );
            } else {
              _showPremiumModal(context);
            }
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
