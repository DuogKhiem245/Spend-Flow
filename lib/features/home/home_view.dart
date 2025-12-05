import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/features/home/widgets/balance_card.dart';
import 'package:spend_flow/features/home/widgets/home_header.dart';
import 'package:spend_flow/features/home/widgets/spending_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {    
    return CupertinoPageScaffold(
      child: SafeArea(
        bottom: false,
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeHeader(),
                SizedBox(height: 24.h),
                BalanceCard(),
                SizedBox(height: 24.h),
                SpendingChart()
              ],
            ),
          ),
        )
      )
    );
  }
}
