import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spend_flow/assets/languages/app_localizations.dart';
import 'package:spend_flow/core/services/ads_service.dart';

class AdDialogHelper {
  /// Hiển thị popup loading Cupertino với hiệu ứng spinner dots wave
  static Future<void> showLoadingDialog(
    BuildContext context, {
    required String message,
  }) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            margin: EdgeInsets.symmetric(horizontal: 40.w),
            decoration: BoxDecoration(
              color: CupertinoTheme.of(dialogContext).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingAnimationWidget.staggeredDotsWave(
                  color: CupertinoTheme.of(dialogContext).primaryColor,
                  size: 32.w,
                ),
                SizedBox(height: 16.h),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: CupertinoTheme.of(dialogContext).textTheme.textStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Hiển thị hộp thoại lỗi quảng cáo với thông tin chi tiết và chính xác
  static void showAdErrorDialog(
    BuildContext context,
    AdFailure failure, {
    VoidCallback? onUpgradePremium,
  }) {
    final l10n = AppLocalizations.of(context)!;

    String title;
    String message;
    String icon;
    bool showPremiumButton = false;

    switch (failure.reason) {
      case AdFailureReason.noFill:
        title = l10n.ad_no_fill_title;
        message = l10n.ad_no_fill_message;
        icon = 'tv.slash';
        showPremiumButton = onUpgradePremium != null;
        break;

      case AdFailureReason.networkError:
        title = l10n.ad_network_error_title;
        message = l10n.ad_network_error_message;
        icon = 'wifi.slash';
        break;

      case AdFailureReason.timeout:
        title = l10n.ad_load_failed_title;
        message = l10n.ad_loading_timeout_message;
        icon = 'clock.badge.exclamationmark';
        break;

      case AdFailureReason.failedToShow:
        title = l10n.ad_show_failed_title;
        message = l10n.ad_show_failed_message;
        icon = 'exclamationmark.triangle';
        break;

      case AdFailureReason.notReady:
      case AdFailureReason.loadFailed:
        title = l10n.ad_load_failed_title;
        message = l10n.ad_load_failed_message;
        icon = 'exclamationmark.triangle';
        break;
    }

    AdaptiveAlertDialog.show(
      context: context,
      title: title,
      message: message,
      icon: icon,
      actions: [
        if (showPremiumButton)
          AlertAction(
            title: l10n.upgrade_premium,
            style: AlertActionStyle.primary,
            onPressed: () {
              onUpgradePremium?.call();
            },
          ),
        AlertAction(
          title: showPremiumButton ? l10n.close : "OK",
          style: showPremiumButton
              ? AlertActionStyle.cancel
              : AlertActionStyle.primary,
          onPressed: () {},
        ),
      ],
    );
  }

  /// Xử lý quy trình hiển thị quảng cáo nhận thưởng có hỗ trợ dialog chờ
  static Future<void> showRewardedAdWithWaiting({
    required BuildContext context,
    required RewardedAdType type,
    required VoidCallback onRewardEarned,
    VoidCallback? onUpgradePremium,
  }) async {
    final adsService = AdsService();
    final l10n = AppLocalizations.of(context)!;

    // 1. Nếu quảng cáo đã nạp sẵn vào RAM -> phát ngay lập tức
    if (adsService.isRewardedAdLoaded(type)) {
      adsService.showRewardedAd(
        type: type,
        onRewardEarned: onRewardEarned,
        onAdFailed: (failure) {
          if (context.mounted) {
            showAdErrorDialog(
              context,
              failure,
              onUpgradePremium: onUpgradePremium,
            );
          }
        },
      );
      return;
    }

    // 2. Nếu quảng cáo chưa sẵn sàng -> hiển thị dialog loading và đợi tối đa 6 giây
    bool isDialogShowing = true;
    showLoadingDialog(
      context,
      message: l10n.ad_preparing,
    ).then((_) {
      isDialogShowing = false;
    });

    final loaded = await adsService.waitForRewardedAd(
      type,
      timeout: const Duration(seconds: 6),
    );

    // Đóng dialog loading nếu vẫn đang hiển thị
    if (isDialogShowing && context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      isDialogShowing = false;
    }

    if (!context.mounted) return;

    if (loaded) {
      adsService.showRewardedAd(
        type: type,
        onRewardEarned: onRewardEarned,
        onAdFailed: (failure) {
          if (context.mounted) {
            showAdErrorDialog(
              context,
              failure,
              onUpgradePremium: onUpgradePremium,
            );
          }
        },
      );
    } else {
      final failure = adsService.getLastRewardedError(type) ??
          const AdFailure(reason: AdFailureReason.loadFailed);
      showAdErrorDialog(
        context,
        failure,
        onUpgradePremium: onUpgradePremium,
      );
    }
  }
}

