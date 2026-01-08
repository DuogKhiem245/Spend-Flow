import 'dart:io';
import 'package:cupertino_native/components/popup_menu_button.dart';
import 'package:cupertino_native/style/button_style.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/services/daily_limit_service.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/services/notification_service.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = HomeViewModel();

  final notificationService = NotificationService();
  final DailyLimitService _limitService = DailyLimitService();

  @override
  void initState() {
    super.initState();
    _viewModel.initData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPermissionStatus();
    });
  }

  void _showPremiumModal(BuildContext context, bool limitReached) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      builder: (context) => PremiumView(isMaximized:limitReached),
    );
  }

  Future<void> _checkPermissionStatus() async {
    final isUserEnabled = await LocalStorageService().getNotificationStatus();
    if (isUserEnabled) {
      await notificationService.requestPermissions();
      if (!mounted) return;
      await notificationService.scheduleDailyNotification(context);
    }
  }

  Future<void> _handleMenuSelection(int index) async {
    if (index == 1) {
      final canUse = await _limitService.canUseVoice();
      if (canUse) {
        if (!mounted) return;
        await Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const VoiceInputView()),
        );
      } else {
        if (!mounted) return;
        _showPremiumModal(context, true);
      }
    } else if (index == 2) {
      await Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => const AddTransactionPage()),
      );
    } else if (index == 0) {
      final bool isPremium = await LocalStorageService().getPremiumStatus();

      if (!mounted) return;

      if (isPremium) {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const ScanReceiptView()),
        );
      } else {
        _showPremiumModal(context, false);
      }
    }

    await _viewModel.reloadData();
  }

  // void _showLimitAlert(AppLocalizations l10n, String featureName, int limit) {
  //   showCupertinoDialog(
  //     context: context,
  //     builder: (context) => CupertinoAlertDialog(
  //       title: Text(l10n.limit_reached),
  //       content: Text(l10n.limit_reached_description(featureName, limit)),
  //       actions: [
  //         CupertinoDialogAction(
  //           child: const Text("OK"),
  //           onPressed: () => Navigator.pop(context),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
                          ),
                          SizedBox(height: 24.h),
                          SpendingChart(chartData: _viewModel.chartData),
                          SizedBox(height: 24.h),
                          RecentTransaction(
                            transactions: _viewModel.recentTransactions,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 20.w,
                bottom: 100.h,
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
          title: l10n!.add_via_voice,
          icon: CupertinoIcons.mic_fill,
          iconColor: CupertinoColors.activeBlue,
          onTap: () => _handleMenuSelection(0),
        ),
        PullDownMenuItem(
          title: l10n.scan_receipt,
          icon: CupertinoIcons.doc_text_viewfinder,
          iconColor: CupertinoColors.activeBlue,
          onTap: () => _handleMenuSelection(1),
        ),
        const PullDownMenuDivider.large(),
        PullDownMenuItem(
          title: l10n.add_manually,
          icon: CupertinoIcons.pencil_ellipsis_rectangle,
          iconColor: CupertinoColors.activeBlue,
          onTap: () => _handleMenuSelection(2),
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
}
