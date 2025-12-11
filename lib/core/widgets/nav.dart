import 'package:cupertino_native/components/tab_bar.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/features/budget/budget_view.dart';
import 'package:spend_flow/features/home/home_view.dart';
import 'package:spend_flow/features/report/report_view.dart';
import 'package:spend_flow/features/setting/setting_view.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ReportPage(),
    BudgetPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            left: 0.w,
            right: 0.w,
            bottom: 0.h,
            child: CNTabBar(
              items: [
                CNTabBarItem(
                  label: 'Dashboard',
                  icon: CNSymbol('square.grid.2x2'),
                ),
                CNTabBarItem(label: 'Reports', icon: CNSymbol('chart.bar')),
                CNTabBarItem(label: 'Budgets', icon: CNSymbol('creditcard')),
                CNTabBarItem(
                  label: 'Settings',
                  icon: CNSymbol('gearshape.fill'),
                ),
              ],
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              backgroundColor: CupertinoColors.transparent,
              // backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
