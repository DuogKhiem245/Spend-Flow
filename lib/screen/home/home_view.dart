import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:foldable/foldable.dart';
import 'package:spend_flow/assets/languages/app_localizations.dart';
import 'package:spend_flow/core/helpers/transaction_action_helper.dart';
import 'package:spend_flow/core/services/ads_service.dart';
import 'package:spend_flow/screen/home/home_viewmodel.dart';
import 'package:spend_flow/screen/home/widgets/balance_card.dart';
import 'package:spend_flow/screen/home/widgets/home_header.dart';
import 'package:spend_flow/screen/home/widgets/recent_transaction.dart';
import 'package:spend_flow/core/widgets/skeleton/skeleton_home_view.dart';
import 'package:spend_flow/screen/home/widgets/spending_chart.dart';
import 'package:spend_flow/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final HomeViewModel _viewModel = HomeViewModel();
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

    final mediaQuery = MediaQuery.of(context);
    final double width = mediaQuery.size.width;

    final bool isTablet = width >= 600;

    final HingeStatus status = DuoMediaQuery.statusOf(context);

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
            child: SafeArea(
              bottom: false,
              child: _viewModel.isLoading
                  ? const SkeletonHomeView()
                  : Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: 10.h,
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
                                      transactions:
                                          _viewModel.recentTransactions,
                                      viewModel: _viewModel,
                                    ),
                                    SizedBox(
                                      height:
                                          _premiumViewModel.isPremium == false
                                          ? 120.h
                                          : 80.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        if (Platform.isAndroid)
                          Positioned(
                            right: isTablet ? 30.w : 20.w,
                            bottom:
                                (_premiumViewModel.isPremium ||
                                    !_viewModel.hasBanner)
                                ? 40.h
                                : 100.h,
                            child: _buildFloatingButton(l10n, isTablet),
                          )
                        else if (status != HingeStatus.closed) ...[
                          Positioned(
                            right: isTablet ? 30.w : 20.w,
                            bottom:
                                (_premiumViewModel.isPremium ||
                                    !_viewModel.hasBanner)
                                ? 100.h
                                : 150.h,
                            child: _buildFloatingButton(l10n, isTablet),
                          ),
                        ],
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Future<void> handleMenuSelection(int index) async {
    await TransactionActionHelper.handleMenuSelection(context, index);
  }

  Widget _buildFloatingButton(AppLocalizations? l10n, bool isTablet) {
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
          height: _isMenuOpen
              ? isTablet
                    ? 260.h
                    : 180
              : 0,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                _buildSubMenuButton(
                  icon: CupertinoIcons.pencil_outline,
                  label: l10n!.add_manually,
                  textColor: textColor,
                  backgroundColor: barColor,
                  onTap: () => handleMenuSelection(2),
                ),
                SizedBox(height: 12.h),
                _buildSubMenuButton(
                  icon: CupertinoIcons.mic,
                  label: l10n.add_via_voice,
                  textColor: textColor,
                  backgroundColor: barColor,
                  onTap: () => handleMenuSelection(1),
                ),
                SizedBox(height: 12.h),
                _buildSubMenuButton(
                  icon: CupertinoIcons.doc_text_viewfinder,
                  label: l10n.scan_receipt,
                  textColor: textColor,
                  backgroundColor: barColor,
                  onTap: () => handleMenuSelection(0),
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
            width: 60,
            height: 60,
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
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
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
