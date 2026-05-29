import 'dart:io';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/ads_service.dart';
import 'package:spend_flow/core/services/data_service/daily_limit_service.dart';
import 'package:spend_flow/core/widgets/custom_option/custom_option_widget.dart';
import 'package:spend_flow/screen/premium/premium_view.dart';
import 'package:spend_flow/screen/scan_receipt/scran_receipt_view.dart';
import 'package:spend_flow/screen/transaction/add_transaction/add_transaction_view.dart';
import 'package:spend_flow/screen/home/home_viewmodel.dart';
import 'package:spend_flow/screen/home/widgets/balance_card.dart';
import 'package:spend_flow/screen/home/widgets/home_header.dart';
import 'package:spend_flow/screen/home/widgets/recent_transaction.dart';
import 'package:spend_flow/core/widgets/skeleton/skeleton_home_view.dart';
import 'package:spend_flow/screen/home/widgets/spending_chart.dart';
import 'package:spend_flow/screen/voice_input/voice_input_view.dart';
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

  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _viewModel.initData();
    _adsService.loadRewardedAd(RewardedAdType.scanReceipt);
    _adsService.loadRewardedAd(RewardedAdType.voiceInput);
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
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return FocusDetector(
      onFocusGained: () async {
        if (mounted) {
          await _viewModel.reloadData();
        }
      },
      child: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) {
          return CupertinoPageScaffold(
            child: _viewModel.isLoading
                ? const SkeletonHomeView()
                : Stack(
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
                            color: CupertinoTheme.of(
                              context,
                            ).scaffoldBackgroundColor,
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
                                  SizedBox(height: 15.h),
                                  // StreakCard(),
                                  // SizedBox(height: 15.h),
                                  SpendingChart(
                                    chartData: _viewModel.chartData,
                                    viewModel: _viewModel,
                                  ),
                                  SizedBox(height: 15.h),
                                  RecentTransaction(
                                    transactions: _viewModel.recentTransactions,
                                    viewModel: _viewModel,
                                  ),
                                  SizedBox(
                                    height: _premiumViewModel.isPremium == false
                                        ? 120.h
                                        : 80.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 20.w,
                        bottom: _premiumViewModel.isPremium
                            ? Platform.isIOS
                                  ? 100.h
                                  : 95.h
                            : Platform.isIOS
                            ? 150.h
                            : 150.h, 
                        child: _buildFloatingButton(l10n),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Future<void> _handleMenuSelection(int index) async {
    HapticFeedback.heavyImpact();

    switch (index) {
      case 0:
        final canUse = await _limitService.canUseScan();
        if (canUse) {
          if (!mounted) return;
          await Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => const ScanReceiptView()),
          );
        } else {
          if (!mounted) return;
          await _showLimitOptions(context, isVoice: false);
        }
        break;

      case 1:
        final canUse = await _limitService.canUseVoice();
        if (canUse) {
          if (!mounted) return;
          await Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => const VoiceInputView()),
          );
        } else {
          if (!mounted) return;
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

  void _handleRewardAdFlow({required bool isVoice}) {
    _adsService.showRewardedAd(
      type: isVoice ? RewardedAdType.voiceInput : RewardedAdType.scanReceipt,
      onRewardEarned: () async {
        await _limitService.grantAdReward(isVoice);

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
          _showAdErrorDialog(context);
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
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              isVoice ? l10n.used_up_daily_limit(5) : l10n.requires_premium,
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
              label: isVoice ? l10n.see_ads(5) : l10n.watch_ad_continue,
              color: CupertinoTheme.of(context).primaryColor,
              onTap: () => _handleRewardAdFlow(isVoice: isVoice),
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

  Widget _buildFloatingButton(AppLocalizations? l10n) {
    final primaryColor = CupertinoTheme.of(context).primaryColor;
    final textColor = CupertinoTheme.of(context).textTheme.textStyle.color;
    final barColor = CupertinoTheme.of(context).barBackgroundColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: _isMenuOpen ? 180.h : 0,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                _buildSubMenuButton(
                  icon: CupertinoIcons.pencil_outline,
                  label: l10n!.add_manually,
                  textColor: textColor,
                  backgroundColor: barColor,
                  onTap: () => _handleMenuSelection(2),
                ),
                SizedBox(height: 12.h),
                _buildSubMenuButton(
                  icon: CupertinoIcons.mic,
                  label: l10n.add_via_voice,
                  textColor: textColor,
                  backgroundColor: barColor,
                  onTap: () => _handleMenuSelection(1),
                ),
                SizedBox(height: 12.h),
                _buildSubMenuButton(
                  icon: CupertinoIcons.doc_text_viewfinder,
                  label: l10n.scan_receipt,
                  textColor: textColor,
                  backgroundColor: barColor,
                  onTap: () => _handleMenuSelection(0),
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),

        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => setState(() => _isMenuOpen = !_isMenuOpen),
          child: Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: _isMenuOpen
                  ? 0.375
                  : 0, // Xoay đúng 135 độ để biến thành dấu x
              child: Icon(
                CupertinoIcons.add,
                color: CupertinoColors.white,
                size: 30.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget con cấu trúc các nút nhỏ khi xòe ra
  Widget _buildSubMenuButton({
    required IconData icon,
    required String label,
    required Color? textColor,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() => _isMenuOpen = false); // Tự đóng menu lại sau khi chọn
        onTap();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4),
              ],
            ),
            child: Text(
              label,
              style: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.copyWith(fontSize: 14.sp, color: textColor),
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            width: 45.w,
            height: 45.w,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 4),
              ],
            ),
            child: Icon(
              icon,
              color: CupertinoTheme.of(context).primaryColor,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}
