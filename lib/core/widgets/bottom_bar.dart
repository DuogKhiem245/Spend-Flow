import 'dart:io';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foldable/foldable.dart';
import 'package:spend_flow/assets/languages/app_localizations.dart';
import 'package:spend_flow/core/services/ads_service.dart';
import 'package:spend_flow/core/widgets/banner_ads_widget.dart';
import 'package:spend_flow/core/helpers/transaction_action_helper.dart';
import 'package:spend_flow/screen/budget/budget_view.dart';
import 'package:spend_flow/screen/home/home_view.dart';
import 'package:spend_flow/screen/report/report_view.dart';
import 'package:spend_flow/screen/setting/setting_view.dart';
import 'package:spend_flow/main.dart';

class BottomNavbar extends StatefulWidget {
  final int currentIndex;

  const BottomNavbar({super.key, this.currentIndex = 0});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  late int _currentIndex = widget.currentIndex;

  final viewModel = premiumViewModel;

  final List<Widget> _pages = const [
    HomePage(),
    ReportPage(),
    BudgetPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final HingeStatus status = DuoMediaQuery.statusOf(context);

    return AdaptiveScaffold(
      appBar: _currentIndex == 0 && status == HingeStatus.closed
          ? AdaptiveAppBar(
              useNativeToolbar: true,
              actions: [
                AdaptiveAppBarAction(
                  icon: CupertinoIcons.doc_text_viewfinder,
                  onPressed: () =>
                      TransactionActionHelper.handleMenuSelection(context, 0),
                ),
                AdaptiveAppBarAction(
                  icon: CupertinoIcons.mic,
                  onPressed: () =>
                      TransactionActionHelper.handleMenuSelection(context, 1),
                ),
                AdaptiveAppBarAction(
                  icon: CupertinoIcons.pencil_outline,
                  onPressed: () =>
                      TransactionActionHelper.handleMenuSelection(context, 2),
                ),
              ],
            )
          : null,
      minimizeBehavior: TabBarMinimizeBehavior.never,
      bottomNavigationBar: AdaptiveBottomNavigationBar(
        useNativeBottomBar: true,
        selectedIndex: _currentIndex,
        onTap: (i) => setState(() {
          _currentIndex = i;
          HapticFeedback.heavyImpact();
        }),
        items: [
          AdaptiveNavigationDestination(
            label: l10n.home,
            icon: 'square.grid.2x2',
          ),
          AdaptiveNavigationDestination(
            label: l10n.transaction,
            icon: 'chart.bar',
          ),
          AdaptiveNavigationDestination(
            label: l10n.budgets,
            icon: 'creditcard',
          ),
          AdaptiveNavigationDestination(
            label: l10n.settings,
            icon: 'gearshape.fill',
          ),
        ],
      ),
      body: Stack(
        children: [
          _pages[_currentIndex],
          if (Platform.isAndroid ||
              status != HingeStatus.unknown ||
              status != HingeStatus.closed) ...[
            Positioned(
              left: 0,
              right: 0,
              bottom: 90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListenableBuilder(
                    listenable: viewModel,
                    builder: (context, child) {
                      if (viewModel.isPremium) {
                        return const SizedBox.shrink();
                      }
                      return BannerAdWidget(
                        adUnitId: AdsService().bannerAdUnitId,
                      );
                    },
                  ),
                ],
              ),
            ),
          ] else ...[
            Positioned(
              left: 0,
              right: 0,
              bottom: 10.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListenableBuilder(
                    listenable: viewModel,
                    builder: (context, child) {
                      if (viewModel.isPremium) {
                        return const SizedBox.shrink();
                      }
                      return BannerAdWidget(
                        adUnitId: AdsService().bannerAdUnitId,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
