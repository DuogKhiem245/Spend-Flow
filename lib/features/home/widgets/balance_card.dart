import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/home/home_viewmodel.dart';

class BalanceCard extends StatelessWidget {
  final double income;
  final double expenses;
  final double balance;
  final HomeViewModel _viewModel;

  const BalanceCard({
    super.key,
    required this.income,
    required this.expenses,
    required this.balance,
    required HomeViewModel viewModel,
  }) : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final boxDecoration = BoxDecoration(
      color: CupertinoTheme.of(context).barBackgroundColor,
      borderRadius: BorderRadius.circular(30.r),
      boxShadow: [
        BoxShadow(
          color: AppColors.boxShadow,
          blurRadius: 10.r,
          offset: Offset(0, 4.h),
        ),
      ],
    );

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        final symbol = _viewModel.currencySymbol;
        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: boxDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.total_balance,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color?.withValues(alpha: .6),
                        ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "$symbol ${_viewModel.formatCurrency(balance)}",
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          letterSpacing: 2,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                          color: balance >= 0
                              ? AppColors.secondaryColor
                              : AppColors.errorColor.withValues(alpha: .8),
                        ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: boxDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor.withAlpha(30),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                CupertinoIcons.arrow_up,
                                color: AppColors.secondaryColor,
                                size: 16.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              l10n.income,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .color
                                        ?.withValues(alpha: .6),
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "$symbol ${_viewModel.formatCompactCurrency(income)}",
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 24.sp,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                color: CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.color,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 16.w),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: boxDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColors.errorColor.withAlpha(30),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                CupertinoIcons.arrow_down,
                                color: AppColors.errorColor,
                                size: 16.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              l10n.expenses,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .color
                                        ?.withValues(alpha: .6),
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "$symbol ${_viewModel.formatCompactCurrency(expenses)}",
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 24.sp,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                                color: CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.color,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
