import 'dart:io';
import 'package:cupertino_native/components/popup_menu_button.dart';
import 'package:cupertino_native/style/button_style.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/services/ads_service.dart';
import 'package:spend_flow/core/services/data_service/daily_limit_service.dart';
import 'package:spend_flow/features/premium/premium_view.dart';
import 'package:spend_flow/features/scan_receipt/scran_receipt_view.dart';
import 'package:spend_flow/features/transaction/add_transaction/add_transaction_view.dart';
import 'package:spend_flow/features/home/home_viewmodel.dart';
import 'package:spend_flow/features/home/widgets/balance_card.dart';
import 'package:spend_flow/features/home/widgets/home_header.dart';
import 'package:spend_flow/features/home/widgets/recent_transaction.dart';
import 'package:spend_flow/core/widgets/skeleton/skeleton_home_view.dart';
import 'package:spend_flow/features/home/widgets/spending_chart.dart';
import 'package:spend_flow/features/voice_input/voice_input_view.dart';
import 'package:spend_flow/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final HomeViewModel _viewModel = HomeViewModel();
  final DailyLimitService _limitService = DailyLimitService();
  final AdsService _adsService = AdsService();
  final _premiumViewModel = premiumViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _viewModel.initData();
    _adsService.loadRewardedAd();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _viewModel.lockApp();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _viewModel.lockApp();
    }
  }

  Future<void> _handleMenuSelection(int index) async {
    HapticFeedback.heavyImpact();
    bool? shouldRefresh = false;

    switch (index) {
      case 2:
        shouldRefresh = await Navigator.push<bool>(
          context,
          CupertinoPageRoute(builder: (context) => const AddTransactionPage()),
        );
        break;

      case 1:
        final canUse = await _limitService.canUseVoice();
        if (canUse) {
          if (!mounted) return;
          shouldRefresh = await Navigator.push<bool>(
            context,
            CupertinoPageRoute(builder: (context) => const VoiceInputView()),
          );
        } else {
          if (!mounted) return;
          shouldRefresh = await _showLimitOptions(context, isVoice: true);
        }
        break;

      case 0:
        if (_premiumViewModel.isPremium) {
          shouldRefresh = await Navigator.push<bool>(
            context,
            CupertinoPageRoute(builder: (context) => const ScanReceiptView()),
          );
        } else {
          shouldRefresh = await _showLimitOptions(context, isVoice: false);
        }
        break;
    }

    if (shouldRefresh == true) {
      await _viewModel.reloadData();
    }
  }

  void _handleRewardAdFlow({required bool isVoice}) {
    _adsService.showRewardedAd(
      onRewardEarned: () async {
        await _limitService.grantAdReward();

        if (!mounted) return;

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

        if (mounted) {
          Navigator.pop(context, result);
        }
      },
      onAdFailed: () {
        if (mounted) {
          Navigator.pop(context, false);
          _showAdErrorDialog();
        }
      },
    );
  }

  Future<bool?> _showLimitOptions(
    BuildContext context, {
    required bool isVoice,
  }) {
    final l10n = AppLocalizations.of(context)!;

    return showModalBottomSheet<bool>(
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
              isVoice
                  ? CupertinoIcons.mic_circle
                  : CupertinoIcons.doc_text_viewfinder,
              size: 50.sp,
              color: CupertinoTheme.of(context).primaryColor,
            ),
            SizedBox(height: 12.h),
            Text(
              isVoice ? l10n.limit_reached : l10n.scan_receipt,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              isVoice ? l10n.used_up_daily_limit(5) : l10n.requires_premium,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(height: 24.h),
            _buildCustomOption(
              context,
              icon: CupertinoIcons.play_circle_fill,
              label: isVoice ? l10n.see_ads(5) : l10n.watch_ad_continue,
              color: CupertinoTheme.of(context).primaryColor,
              onTap: () => _handleRewardAdFlow(isVoice: isVoice),
            ),
            SizedBox(height: 12.h),
            _buildCustomOption(
              context,
              icon: CupertinoIcons.star_fill,
              label: l10n.upgrade_premium,
              color: const Color(0xFF9C2CF3),
              isGradient: true,
              onTap: () {
                Navigator.pop(context, false);
                _showPremiumModal(context, isVoice);
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _showPremiumModal(BuildContext context, bool isMaximized) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      builder: (context) => PremiumView(isMaximized: isMaximized),
    );
  }

  void _showAdErrorDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Text(AppLocalizations.of(context)!.ads_loading),
        actions: [
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        if (_viewModel.isLoading) {
          return CupertinoPageScaffold(
            backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
            child: const SkeletonHomeView(),
          );
        }

        return CupertinoPageScaffold(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 10.h,
                      left: 16.w,
                      right: 16.w,
                      bottom: 10.h,
                    ),
                    color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                    child: HomeHeader(viewModel: _viewModel),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 10.h,
                        bottom: 100.h,
                      ),
                      child: Column(
                        children: [
                          BalanceCard(
                            income: _viewModel.income,
                            expenses: _viewModel.expenses,
                            balance: _viewModel.balance,
                            viewModel: _viewModel,
                          ),
                          SizedBox(height: 24.h),
                          SpendingChart(
                            chartData: _viewModel.chartData,
                            viewModel: _viewModel,
                          ),
                          SizedBox(height: 24.h),
                          RecentTransaction(
                            transactions: _viewModel.recentTransactions,
                            viewModel: _viewModel,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 20.w,
                bottom: _premiumViewModel.isPremium ? 100.h : 140.h,
                child: Platform.isIOS
                    ? _buildIOSFloatingButton(l10n)
                    : _buildAndroidFloatingButton(l10n),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIOSFloatingButton(AppLocalizations? l10n) {
    return CNPopupMenuButton.icon(
      buttonIcon: CNSymbol('plus.circle.fill', size: 24.sp),
      buttonStyle: CNButtonStyle.glass,
      size: 60.w,
      items: [
        CNPopupMenuItem(
          label: l10n!.scan_receipt,
          icon: CNSymbol('text.viewfinder', size: 18.sp),
        ),
        CNPopupMenuItem(
          label: l10n.add_via_voice,
          icon: CNSymbol('mic.fill', size: 18.sp),
        ),
        CNPopupMenuItem(
          label: l10n.add_manually,
          icon: CNSymbol('square.and.pencil', size: 18.sp),
        ),
      ],
      onSelected: _handleMenuSelection,
    );
  }

  Widget _buildAndroidFloatingButton(AppLocalizations? l10n) {
    return PullDownButton(
      position: PullDownMenuPosition.automatic,
      itemBuilder: (context) => [
        PullDownMenuItem(
          title: l10n!.add_manually,
          icon: CupertinoIcons.pencil_ellipsis_rectangle,
          iconColor: CupertinoColors.activeBlue,
          onTap: () => _handleMenuSelection(2),
        ),
        const PullDownMenuDivider.large(),
        PullDownMenuItem(
          title: l10n.add_via_voice,
          icon: CupertinoIcons.mic_fill,
          iconColor: CupertinoColors.activeBlue,
          onTap: () => _handleMenuSelection(1),
        ),
        PullDownMenuItem(
          title: l10n.scan_receipt,
          icon: CupertinoIcons.doc_text_viewfinder,
          iconColor: CupertinoColors.activeBlue,
          onTap: () => _handleMenuSelection(0),
        ),
      ],
      buttonBuilder: (context, showMenu) => GestureDetector(
        onTap: showMenu,
        child: Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: .4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            CupertinoIcons.add,
            color: CupertinoColors.white,
            size: 30.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isGradient = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          gradient: isGradient
              ? const LinearGradient(
                  colors: [Color(0xFF9C2CF3), Color(0xFF3A49F9)],
                )
              : null,
          color: isGradient ? null : color.withValues(alpha: 0.1),
        ),
        child: Row(
          children: [
            Icon(icon, color: isGradient ? Colors.white : color, size: 24.sp),
            SizedBox(width: 16.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isGradient ? Colors.white : color,
              ),
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.chevron_right,
              size: 16.sp,
              color: isGradient ? Colors.white70 : color.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
