import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/features/add_stransaction/add_stransaction.dart';
import 'package:spend_flow/features/home/widgets/balance_card.dart';
import 'package:spend_flow/features/home/widgets/home_header.dart';
import 'package:spend_flow/features/home/widgets/recent_transaction.dart';
import 'package:spend_flow/features/home/widgets/spending_chart.dart';
import 'package:cupertino_native/components/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                      BalanceCard(),
                      SizedBox(height: 24.h),
                      SpendingChart(),
                      SizedBox(height: 24.h),
                      RecentTransaction(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            right: 20.w, 
            bottom: 90.h, 
            child: CNButton.icon(
              icon: CNSymbol('plus.circle.fill', size: 20.sp),
              size: 60.w,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AddTransactionPage(),
                  ),
                );
              },
            )
          ),
        ],
      ),
    );
  }
}
