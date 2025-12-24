import 'dart:io';
import 'package:cupertino_native/components/popup_menu_button.dart';
import 'package:cupertino_native/style/button_style.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/services/daily_limit_service.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/services/notification_service.dart';
import 'package:spend_flow/features/add_stransaction/add_stransaction_view.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/features/home/home_model.dart';
import 'package:spend_flow/features/home/home_viewmodel.dart';
import 'package:spend_flow/features/home/widgets/balance_card.dart';
import 'package:spend_flow/features/home/widgets/home_header.dart';
import 'package:spend_flow/features/home/widgets/recent_transaction.dart';
import 'package:spend_flow/core/widgets/skeleton/skeleton_home_view.dart';
import 'package:spend_flow/features/home/widgets/spending_chart.dart';
import 'package:spend_flow/features/scan_receipt/scran_receipt_view.dart';
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

  double _income = 0;
  double _expenses = 0;
  double _balance = 0;
  bool _isLoading = true;

  List<SpendingModel> _chartData = [];

  List<TransactionModel> _recentTransactions = [];

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _loadHomeData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkPermissionStatus();
    });
  }

  Future<void> _checkPermissionStatus() async {
    final isUserEnabled = await LocalStorageService().getNotificationStatus();

    if (isUserEnabled) {
      await notificationService.requestPermissions();
      await notificationService.scheduleDailyNotification();
    }
  }

  Future<void> _loadHomeData() async {
    final stats = await _viewModel.getCurrentMonthStats();
    final chartData = await _viewModel.getChartData();
    final recentTransactions = await _viewModel.getRecentTransactionsList();

    if (mounted) {
      setState(() {
        _income = stats['income'] ?? 0;
        _expenses = stats['expenses'] ?? 0;
        _balance = stats['balance'] ?? 0;

        _chartData = chartData;

        _recentTransactions = recentTransactions;
        
        _isLoading = false;
      });
    }
  }

  Future<void> _handleMenuSelection(int index) async {
    final l10n = AppLocalizations.of(context)!;

    if (index == 0) {
      final canUse = await _limitService.canUseVoice();
      if (canUse) {
        if (!mounted) return;
        await Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const VoiceInputView()),
        );
      } else {
        _showLimitAlert(l10n, "Voice Input", 5);
      }
    } else if (index == 1) {
      final canUse = await _limitService.canUseScan();
      if (canUse) {
        if (!mounted) return;
        await Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const ScanReceiptView()),
        );
      } else {
        _showLimitAlert(l10n, "Scan Receipt", 3);
      }
    } else if (index == 2) {
      await Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => const AddTransactionPage()),
      );
    }

    _loadHomeData();
  }

  void _showLimitAlert(AppLocalizations l10n, String featureName, int limit) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Limit Reached"),
        content: Text(
          "You have used $featureName $limit times today.\nPlease come back tomorrow or upgrade to Premium.",
        ),
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

    if (_isLoading) {
      return CupertinoPageScaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        child: const SkeletonHomeView(),
      );
    }

    return CupertinoPageScaffold(
      // child: _isLoading
      //     ? LoadingAnimationWidget.staggeredDotsWave(
      //         color: CupertinoTheme.of(context).primaryColor,
      //         size: 30.w,
      //       )
      //     :
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
                child: HomeHeader(),
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
                        income: _income,
                        expenses: _expenses,
                        balance: _balance,
                      ),
                      SizedBox(height: 24.h),
                      SpendingChart(chartData: _chartData),
                      SizedBox(height: 24.h),
                      RecentTransaction(transactions: _recentTransactions),
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
  }

  Widget _buildIOSFloatingButton(AppLocalizations? l10n) {
    return CNPopupMenuButton.icon(
      buttonIcon: CNSymbol('plus.circle.fill', size: 24.sp),
      buttonStyle: CNButtonStyle.glass,
      size: 60.w,
      items: [
        CNPopupMenuItem(
          label: l10n!.add_via_voice,
          icon: CNSymbol('mic.fill', size: 18.sp),
        ),
        CNPopupMenuItem(
          label: l10n.scan_receipt,
          icon: CNSymbol('text.viewfinder', size: 18.sp),
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
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            title: Text(l10n!.add_transaction),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  _handleMenuSelection(0);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.mic_fill,
                      color: CupertinoColors.activeBlue,
                    ),
                    SizedBox(width: 10.w),
                    Text(l10n.add_via_voice),
                  ],
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  _handleMenuSelection(1);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.doc_text_viewfinder,
                      color: CupertinoColors.activeBlue,
                    ),
                    SizedBox(width: 10.w),
                    Text(l10n.scan_receipt),
                  ],
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  _handleMenuSelection(2);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.pencil_ellipsis_rectangle,
                      color: CupertinoColors.activeBlue,
                    ),
                    SizedBox(width: 10.w),
                    Text(l10n.add_manually),
                  ],
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              isDestructiveAction: true,
              child: Text(l10n.cancel),
            ),
          ),
        );
      },
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.boxShadow,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          CupertinoIcons.add,
          color: CupertinoColors.white,
          size: 30.sp,
        ),
      ),
    );
  }
}
