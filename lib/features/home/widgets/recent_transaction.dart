import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_icons.dart'; 
import 'package:spend_flow/features/add_stransaction/model/transaction_model.dart';
import 'package:spend_flow/features/home/home_viewmodel.dart'; 

class RecentTransaction extends StatelessWidget {
  // 1. Nhận danh sách từ cha
  final List<TransactionModel> transactions;
  final HomeViewModel _viewModel = HomeViewModel(); 

  RecentTransaction({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (transactions.isEmpty) {
      return const SizedBox(); 
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0.w),
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
              Text(
                l10n.recent_transactions,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to All Transactions Page
                },
                child: Text(
                  l10n.view_all,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(
                        fontSize: 14.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final item = transactions[index];

              final isExpense = item.isIncome == false;
              final color = isExpense
                  ? AppColors.errorColor
                  : AppColors.secondaryColor;

              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: item.category.color.withValues(alpha: .15),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            AppIcons.getIcon(item.category.iconKey),
                            size: 24.w,
                            color: item.category.color,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title, 
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              item.category.name, 
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    fontSize: 14.sp,
                                    color: CupertinoColors.systemGrey,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          isExpense
                              ? "-\$${_viewModel.formatCurrency(item.amount.abs())}"
                              : "+\$${_viewModel.formatCurrency(item.amount)}",
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: color,
                              ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          DateFormat('dd/MM/yyyy').format(item.date),
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 12.sp,
                                color: CupertinoColors.systemGrey,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
