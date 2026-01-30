import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/screen/home/home_viewmodel.dart';

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

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        final symbol = _viewModel.currencySymbol;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.boxShadow.withValues(alpha: 0.05),
                blurRadius: 20.r,
                offset: Offset(0, 10.h),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildBalanceRow(
                context,
                label: l10n.income,
                amount: "${_viewModel.formatCurrency(income)} $symbol",
                isTotal: false,
              ),

              SizedBox(height: 10.h),

              _buildBalanceRow(
                context,
                label: l10n.expenses,
                amount: "${_viewModel.formatCurrency(expenses)} $symbol",
                isTotal: false,
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Divider(
                  height: 1,
                  color: CupertinoColors.systemGrey.withValues(alpha: 0.2),
                ),
              ),

              _buildBalanceRow(
                context,
                label: l10n.total_balance,
                amount: "${_viewModel.formatCurrency(balance)} $symbol",
                isTotal: true,
                amountColor: balance >= 0
                    ? AppColors.secondaryColor
                    : AppColors.errorColor,
              ),
              _buildStreakArea(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBalanceRow(
    BuildContext context, {
    required String label,
    required String amount,
    required bool isTotal,
    Color? amountColor,
  }) {
    final baseStyle = CupertinoTheme.of(context).textTheme.textStyle;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: baseStyle.copyWith(
            fontSize: isTotal ? 17.sp : 15.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: baseStyle.color?.withValues(alpha: isTotal ? 0.9 : 0.6),
          ),
        ),
        Text(
          amount,
          style: baseStyle.copyWith(
            fontSize: isTotal ? 22.sp : 18.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: amountColor ?? baseStyle.color,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakArea(BuildContext context) {
    return const SizedBox.shrink();
  }
}
