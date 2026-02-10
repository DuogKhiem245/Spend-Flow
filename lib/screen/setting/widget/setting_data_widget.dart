import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/ads_service.dart';
import 'package:spend_flow/core/services/sync_service/sync_service.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';
import 'package:spend_flow/core/widgets/custom_option/custom_option_widget.dart';
import 'package:spend_flow/main.dart';
import 'package:spend_flow/screen/premium/premium_view.dart';
import 'package:spend_flow/screen/setting/data_management/export/export_view.dart';
import 'package:spend_flow/screen/setting/data_management/import/import_view.dart';
import 'package:spend_flow/screen/setting/widget/setting_item_widget.dart';

class SettingDataWidget extends StatefulWidget {
  final String lastSyncText;
  final VoidCallback onSyncSuccess;

  const SettingDataWidget({
    super.key,
    required this.lastSyncText,
    required this.onSyncSuccess,
  });

  @override
  State<SettingDataWidget> createState() => _SettingDataWidgetState();
}

class _SettingDataWidgetState extends State<SettingDataWidget> {
  final AdsService _adsService = AdsService();
  final _premiumViewModel = premiumViewModel;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _adsService.loadRewardedAd();
  }

  void _showPremiumModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      builder: (context) => const PremiumView(),
    );
  }

  void _showAdErrorDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.error,
      message: l10n.ads_loading,
      icon: 'antennas.bubble.left.fill',
      actions: [
        AlertAction(
          title: "OK",
          style: AlertActionStyle.primary,
          onPressed: () {},
        ),
      ],
    );
  }

  void _handleSyncData() async {
    final bool isLogin = FirebaseAuth.instance.currentUser != null;

    if (!isLogin) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;

      AdaptiveAlertDialog.show(
        context: context,
        title: l10n.not_logined,
        message: l10n.please_login_to_sync_data,
        icon: 'person.crop.circle.badge.exclam',
        actions: [
          AlertAction(
            title: l10n.ok,
            style: AlertActionStyle.primary,
            onPressed: () => {},
          ),
        ],
      );
      return;
    }

    final bool isPremium = _premiumViewModel.isPremium;

    if (isPremium) {
      _startSyncFlow(isAds: false);
    } else {
      if (!mounted) return;
      _showLimitOptions();
    }
  }

  Future<void> _startSyncFlow({bool isAds = false}) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);

    try {
      final String? result = await SyncService().syncData(isAds: isAds);

      if (result == null) {
        widget.onSyncSuccess();
      } else {
        if (mounted) {
          _showSyncMessage(result, l10n);
        }
      }
    } catch (e) {
      if (mounted) {
        _showSyncMessage("error", l10n);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSyncMessage(String code, AppLocalizations l10n) {
    String title = l10n.error;
    String description = l10n.have_error_occurred;

    if (code == "sync_in_progress") {
      description = l10n.sync_in_progress;
    } else if (code.startsWith("cooldown")) {
      final seconds = code.split(":")[1];
      description = l10n.cooldown(seconds);
    } else if (code.startsWith("error")) {
      final errorMessage = code.replaceFirst("error:", "");
      description = l10n.sync_error(errorMessage);
    }

    CheckValidWidget.showIncompleteDetailsSheet(
      context: context,
      title: title,
      description: description,
      buttonText: "OK",
    );
  }

  void _showLimitOptions() {
    final l10n = AppLocalizations.of(context)!;

    showModalBottomSheet(
      context: context,
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      builder: (context) => Container(
        padding: EdgeInsets.fromLTRB(24.w, 4.h, 24.w, 24.h),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 40.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Icon(
              CupertinoIcons.arrow_2_circlepath,
              size: 50.sp,
              color: CupertinoTheme.of(context).primaryColor,
            ),
            SizedBox(height: 12.h),
            Text(
              l10n.sync_data,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              l10n.require_premium_to_sync,
              textAlign: TextAlign.center,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 14.sp,
                color: CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(height: 24.h),
            CustomOptionWidget(
              context: context,
              icon: CupertinoIcons.play_circle_fill,
              label: l10n.watch_ad_continue,
              color: CupertinoTheme.of(context).primaryColor,
              onTap: () => {_handleRewardAdFlow()},
            ),
            SizedBox(height: 12.h),
            CustomOptionWidget(
              context: context,
              icon: CupertinoIcons.star_fill,
              label: l10n.upgrade_premium,
              color: const Color(0xFF9C2CF3),
              isGradient: true,
              onTap: () {
                Navigator.pop(context, false);
                _showPremiumModal(context);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _handleRewardAdFlow() {
    Navigator.pop(context, false);
    _adsService.showRewardedAd(
      onRewardEarned: () async {
        await _startSyncFlow(isAds: true);
      },
      onAdFailed: () {
        if (mounted) {
          _showAdErrorDialog(context);
        }
      },
    );
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
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
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
          onTap: () => _handleSyncData(),
          trailing: Text(
            _isLoading ? l10n.syncing : l10n.sync_data_now,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              fontSize: 14.sp,
              color: CupertinoColors.systemBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SettingItem(
          title: l10n.export_data,
          icon: CupertinoIcons.cloud_download_fill,
          iconBgColor: Color.fromRGBO(77, 85, 98, 1),
          onTap: () {
            if (_premiumViewModel.isPremium) {
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
          onTap: () {
            if (_premiumViewModel.isPremium) {
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
