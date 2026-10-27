import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/languages/app_localizations.dart';
import 'package:spend_flow/core/services/ads_service.dart';
import 'package:spend_flow/core/services/data_service/daily_limit_service.dart';
import 'package:spend_flow/core/widgets/custom_option/custom_option_widget.dart';
import 'package:spend_flow/screen/premium/premium_view.dart';
import 'package:spend_flow/screen/scan_receipt/scran_receipt_view.dart';
import 'package:spend_flow/screen/transaction/add_transaction/add_transaction_view.dart';
import 'package:spend_flow/screen/voice_input/voice_input_view.dart';

class TransactionActionHelper {
  static final DailyLimitService _limitService = DailyLimitService();
  static final AdsService _adsService = AdsService();

  static Future<void> handleMenuSelection(BuildContext context, int index) async {
    HapticFeedback.heavyImpact();

    switch (index) {
      case 0:
        final canUse = await _limitService.canUseScan();
        if (canUse) {
          if (!context.mounted) return;
          await Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => const ScanReceiptView()),
          );
        } else {
          if (!context.mounted) return;
          await _showLimitOptions(context, isVoice: false);
        }
        break;

      case 1:
        final canUse = await _limitService.canUseVoice();
        if (canUse) {
          if (!context.mounted) return;
          await Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => const VoiceInputView()),
          );
        } else {
          if (!context.mounted) return;
          await _showLimitOptions(context, isVoice: true);
        }
        break;

      case 2:
        await Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const AddTransactionPage()),
        );
        break;
    }
  }

  static Future<bool?> _showLimitOptions(
    BuildContext context, {
    required bool isVoice,
  }) {
    final l10n = AppLocalizations.of(context)!;

    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      builder: (sheetContext) => Container(
        padding: EdgeInsets.fromLTRB(24.w, 4.h, 24.w, 24.h),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(sheetContext).scaffoldBackgroundColor,
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
                  color: CupertinoTheme.of(sheetContext).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Icon(
              isVoice
                  ? CupertinoIcons.mic_circle
                  : CupertinoIcons.doc_text_viewfinder,
              size: 50.sp,
              color: CupertinoTheme.of(sheetContext).primaryColor,
            ),
            SizedBox(height: 12.h),
            Text(
              isVoice ? l10n.limit_reached : l10n.scan_receipt,
              style: CupertinoTheme.of(sheetContext).textTheme.textStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              isVoice ? l10n.used_up_daily_limit("5") : l10n.requires_premium,
              textAlign: TextAlign.center,
              style: CupertinoTheme.of(sheetContext).textTheme.textStyle.copyWith(
                fontSize: 14.sp,
                color: CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(height: 24.h),
            CustomOptionWidget(
              context: sheetContext,
              icon: CupertinoIcons.play_circle_fill,
              label: isVoice ? l10n.see_ads("5") : l10n.watch_ad_continue,
              color: CupertinoTheme.of(sheetContext).primaryColor,
              onTap: () => _handleRewardAdFlow(sheetContext, isVoice: isVoice),
            ),
            SizedBox(height: 12.h),
            CustomOptionWidget(
              context: sheetContext,
              icon: CupertinoIcons.star_fill,
              label: l10n.upgrade_premium,
              color: const Color(0xFF9C2CF3),
              isGradient: true,
              onTap: () {
                Navigator.pop(sheetContext, false);
                _showPremiumModal(context, isVoice);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  static void _showPremiumModal(BuildContext context, bool isMaximized) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      builder: (context) => PremiumView(isMaximized: isMaximized),
    );
  }

  static void _handleRewardAdFlow(BuildContext context, {required bool isVoice}) {
    _adsService.showRewardedAd(
      type: isVoice ? RewardedAdType.voiceInput : RewardedAdType.scanReceipt,
      onRewardEarned: () async {
        await _limitService.grantAdReward(isVoice);

        if (!context.mounted) return;

        bool? result = false;
        if (isVoice) {
          result = await Navigator.push<bool>(
            context,
            CupertinoPageRoute(builder: (context) => const VoiceInputView()),
          );
        } else {
          result = await Navigator.push<bool>(
            context,
            CupertinoPageRoute(builder: (context) => const ScanReceiptView()),
          );
        }

        if (context.mounted) {
          Navigator.pop(context, result);
        }
      },
      onAdFailed: () {
        if (context.mounted) {
          _showAdErrorDialog(context);
        }
      },
    );
  }

  static void _showAdErrorDialog(BuildContext context) {
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
}
