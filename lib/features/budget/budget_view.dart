import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:cupertino_native/components/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/utils/category_helper.dart';
import 'package:spend_flow/features/budget/add_budget/add_budget_view.dart';
import 'budget_model.dart';
import 'budget_viewmodel.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final BudgetViewModel _viewModel = BudgetViewModel();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return CupertinoPageScaffold(
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildTotalBudgetCard(l10n),
                    SizedBox(height: 24.h),

                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 10.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.categories,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.color,
                              ),
                            ),
                            SizedBox(height: 12.h),

                            if (_viewModel.isLoading)
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 50.h),
                                  child: const CupertinoActivityIndicator(),
                                ),
                              )
                            else if (_viewModel.budgets.isEmpty)
                              _buildEmptyState(l10n)
                            else
                              ..._viewModel.budgets.map(
                                (e) => _buildCategoryCard(e),
                              ),

                            SizedBox(height: 80.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Positioned(
                  right: 20.w,
                  bottom: 65.h,
                  child: CNButton.icon(
                    icon: CNSymbol(
                      'plus.circle.fill',
                      size: 24.sp,
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color,
                    ),
                    size: 60.w,
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const AddBudgetView(),
                        ),
                      );
                      _viewModel.refreshData();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100.h),
          Icon(
            CupertinoIcons.creditcard,
            size: 50.sp,
            color: CupertinoColors.systemGrey,
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.no_budgets_yet,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .6),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.create_budget_description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalBudgetCard(AppLocalizations l10n) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            l10n.your_monthly_budget,
            style: TextStyle(
              fontSize: 14.sp,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color!.withValues(alpha: .6),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _viewModel.formatCurrency(_viewModel.totalBudget),
            style: TextStyle(
              fontSize: 40.sp,
              fontWeight: FontWeight.w800,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
              children: [
                TextSpan(text: l10n.spent),
                TextSpan(
                  text: _viewModel.formatCurrency(_viewModel.totalSpent),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: l10n.out_of),
                TextSpan(
                  text: _viewModel.formatCurrency(_viewModel.totalBudget),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          _buildProgressBar(
            progress: _viewModel.totalProgress,
            height: 12.h,
          ),

          SizedBox(height: 12.h),
          Text(
            "${_viewModel.formatCurrency(_viewModel.totalRemaining)} ${l10n.left_to_spend}",
            style: TextStyle(
              fontSize: 14.sp,
              color: _viewModel.getProgressBarColor(_viewModel.totalProgress),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BudgetModel budget) {
    final iconData = AppIcons.getIcon(budget.iconKey);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: budget.color.withValues(alpha: .15),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: budget.color, size: 24.sp),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      CategoryHelper.getTranslatedName(
                        context,
                        budget.category,
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "${_viewModel.formatCurrency(budget.remaining)} left",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color!.withValues(alpha: .6),
                      ),
                    ),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${_viewModel.formatCurrency(budget.spent)} / ${_viewModel.formatCurrency(budget.total)}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color!.withValues(alpha: .6),

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    SizedBox(
                      width: 100.w,
                      child: _buildProgressBar(
                        progress: budget.progress,
                        height: 6.h,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar({
    required double progress,
    required double height,
  }) {
    final barColor = _viewModel.getProgressBarColor(progress);
    
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
