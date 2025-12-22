import 'dart:io';
import 'package:cupertino_native/components/tab_bar.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/features/budget/budget_view.dart';
import 'package:spend_flow/features/home/home_view.dart';
import 'package:spend_flow/features/report/report_view.dart';
import 'package:spend_flow/features/setting/setting_view.dart';

class BottomNavbar extends StatefulWidget {
  final int currentIndex;

  const BottomNavbar({super.key, this.currentIndex = 0});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  late int _currentIndex = widget.currentIndex;

  final List<Widget> _pages = const [
    HomePage(),
    ReportPage(),
    BudgetPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: Stack(
        children: [
          _pages[_currentIndex],

          Positioned(
            left: 0.w,
            right: 0.w,
            bottom: 0.h,
            child: Platform.isIOS
                ? _buildIOSTabBar(context)
                : _buildAndroidTabBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildIOSTabBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CNTabBar(
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
      items: [
        CNTabBarItem(label: l10n.home, icon: CNSymbol('square.grid.2x2')),
        CNTabBarItem(label: l10n.reports, icon: CNSymbol('chart.bar')),
        CNTabBarItem(label: l10n.budgets, icon: CNSymbol('creditcard')),
        CNTabBarItem(label: l10n.settings, icon: CNSymbol('gearshape.fill')),
      ],
    );
  }

  Widget _buildAndroidTabBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      color: CupertinoTheme.of(
        context,
      ).barBackgroundColor.withValues(alpha: .9),
      child: SafeArea(
        top: false,
        child: CupertinoTabBar(
          backgroundColor: Colors.transparent,
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          activeColor: CupertinoColors.activeBlue,
          inactiveColor: CupertinoColors.systemGrey,
          border: const Border(
            top: BorderSide(color: Colors.black12, width: 0.5),
          ),
          items: [
            BottomNavigationBarItem(
              label: l10n.home,
              icon: Icon(CupertinoIcons.square_grid_2x2, size: 24.sp),
              activeIcon: Icon(
                CupertinoIcons.square_grid_2x2_fill,
                size: 24.sp,
              ),
            ),
            BottomNavigationBarItem(
              label: l10n.reports,
              icon: Icon(CupertinoIcons.chart_bar, size: 24.sp),
              activeIcon: Icon(CupertinoIcons.chart_bar_fill, size: 24.sp),
            ),
            BottomNavigationBarItem(
              label: l10n.budgets,
              icon: Icon(CupertinoIcons.creditcard, size: 24.sp),
              activeIcon: Icon(CupertinoIcons.creditcard_fill, size: 24.sp),
            ),
            BottomNavigationBarItem(
              label: l10n.settings,
              icon: Icon(CupertinoIcons.gear_alt, size: 24.sp),
              activeIcon: Icon(CupertinoIcons.gear_alt_fill, size: 24.sp),
            ),
          ],
        ),
      ),
    );
  }
}
