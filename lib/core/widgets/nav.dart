import 'package:flutter/cupertino.dart';
import 'package:spend_flow/features/budget/budget_view.dart';
import 'package:spend_flow/features/home/home_view.dart';
import 'package:spend_flow/features/report/report_view.dart';
import 'package:spend_flow/features/setting/setting_view.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chart_bar)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.money_dollar)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings)),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const HomePage();
          case 1:
            return const ReportPage();
          case 2:
            return const BudgetPage();
          case 3:
            return const SettingPage();
          default:
            return const HomePage();
        }
      },
    );
  }
}
