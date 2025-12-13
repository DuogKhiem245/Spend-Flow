import 'package:cupertino_native/components/tab_bar.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

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
                  label: l10n.home,
                  icon: CNSymbol('square.grid.2x2'),
                ),
                CNTabBarItem(label: l10n.reports, icon: CNSymbol('chart.bar')),
                CNTabBarItem(label: l10n.budgets, icon: CNSymbol('creditcard')),
                CNTabBarItem(
                  label: l10n.settings,
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
