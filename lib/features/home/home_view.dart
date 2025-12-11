import 'package:cupertino_native/components/popup_menu_button.dart';
import 'package:cupertino_native/style/button_style.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spend_flow/features/add_stransaction/add_stransaction_view.dart';
import 'package:spend_flow/features/add_stransaction/model/transaction_model.dart';
import 'package:spend_flow/features/home/home_model.dart';
import 'package:spend_flow/features/home/home_viewmodel.dart';
import 'package:spend_flow/features/home/widgets/balance_card.dart';
import 'package:spend_flow/features/home/widgets/home_header.dart';
import 'package:spend_flow/features/home/widgets/recent_transaction.dart';
import 'package:spend_flow/features/home/widgets/spending_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = HomeViewModel();

  double _income = 0;
  double _expenses = 0;
  double _balance = 0;
  bool _isLoading = true;

  List<SpendingModel> _chartData = [];

  List<TransactionModel> _recentTransactions = [];

  final items = [
    CNPopupMenuItem(
      label: 'Nhập giọng nói',
      icon: CNSymbol('mic.fill', size: 18.sp), 
    ),

    CNPopupMenuItem(
      label: 'Quét hóa đơn',
      icon: CNSymbol(
        'text.viewfinder',
        size: 18.sp,
      ), 
    ),

    CNPopupMenuItem(
      label: 'Thêm thủ công',
      icon: CNSymbol(
        'square.and.pencil',
        size: 18.sp,
      ), 
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadHomeData();
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: _isLoading
          ? LoadingAnimationWidget.staggeredDotsWave(
              color: CupertinoTheme.of(context).primaryColor,
              size: 30.w,
            )
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
                            RecentTransaction(
                              transactions: _recentTransactions,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Positioned(
                  right: 20.w,
                  bottom: 95.h,
                  child: CNPopupMenuButton.icon(
                    buttonIcon: CNSymbol(
                      'plus.circle.fill',
                      size: 24.sp,
                    ),
                    buttonStyle: CNButtonStyle.glass,
                    size: 60.w,
                    items: items,
                    onSelected: (index) {
                      if(index == 2) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const AddTransactionPage(),
                          ),
                        );
                      }

                    },
                  ),
                  // child: CNButton.icon(
                  //   icon: CNSymbol(
                  //     'plus.circle.fill',
                  //     size: 24.sp,
                  //     color: CupertinoTheme.of(context).primaryColor,
                  //   ),
                  //   size: 60.w,
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       CupertinoPageRoute(
                  //         builder: (context) => const AddTransactionPage(),
                  //       ),
                  //     );
                  //   },
                  // ),
                ),
              ],
            ),
    );
  }
}
