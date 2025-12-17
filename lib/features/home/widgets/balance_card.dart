import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/home/home_viewmodel.dart';

class BalanceCard extends StatelessWidget {
  final double income;
  final double expenses;
  final double balance;
  final HomeViewModel _viewModel = HomeViewModel();

  BalanceCard({
    super.key,
    required this.income,
    required this.expenses,
    required this.balance,
  });

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
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: CupertinoTheme.of(
                    context,
                  ).textTheme.textStyle.color?.withValues(alpha: .6),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "\$${_viewModel.formatCurrency(balance)}",
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 32.sp, 
                  fontWeight: FontWeight.w700,
                  color: balance >= 0
                      ? AppColors.secondaryColor
                      : AppColors.errorColor.withValues(alpha: .8),
                ),
              ),
              //SizedBox(height: 8.h),
              // Row(
              //   children: [
              //     Icon(
              //       CupertinoIcons.arrow_up,
              //       color: Colors.green,
              //       size: 14.sp,
              //     ),
              //     SizedBox(width: 4.w),
              //     Text(
              //       "+5.2% vs last month",
              //       style: TextStyle(
              //         color: Colors.green,
              //         fontSize: 14.sp,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ],
              // ),
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
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: CupertinoTheme.of(context).textTheme.textStyle.color?.withValues(alpha: .6),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "\$${_viewModel.formatCurrency(income)}",
                      style: TextStyle(
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
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color?.withValues(alpha: .6),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "\$${_viewModel.formatCurrency(expenses)}",
                      style: TextStyle(
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
  }
}
