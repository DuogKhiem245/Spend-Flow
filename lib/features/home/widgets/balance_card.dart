import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/home/home_viewmodel.dart';

class BalanceCard extends StatelessWidget {
  BalanceCard({super.key});

  final HomeViewModel _viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final balance = _viewModel.getBalance();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(
                opacity: 0.6,
                child: Text(
                  l10n.income,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                "\$${_viewModel.income}",
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(
                opacity: 0.6,
                child: Text(
                  l10n.expenses,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                "\$${_viewModel.expenses}",
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: CupertinoColors.systemGrey),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(
                opacity: 0.6,
                child: Text(
                  l10n.balance,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                "\$$balance",
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: (balance >= 0)
                      ? AppColors.secondaryColor
                      : AppColors.errorColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}