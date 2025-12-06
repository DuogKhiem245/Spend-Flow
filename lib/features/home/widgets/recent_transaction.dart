import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/home/home_viewmodel.dart';

class RecentTransaction extends StatefulWidget {
  const RecentTransaction({super.key});

  @override
  State<RecentTransaction> createState() => _RecentTransactionState();
}

class _RecentTransactionState extends State<RecentTransaction> {
  final HomeViewModel _viewModel = HomeViewModel();
  final isLock = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: isLock
                  ? Row(
                      children: [
                        Icon(
                          CupertinoIcons.lock_fill,
                          size: 16.w,
                          color: AppColors.thirdColor,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          l10n.view_all,
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 14.sp,
                                color: AppColors.thirdColor,
                                fontWeight: FontWeight.w500
                              ),
                        ),
                      ],
                    )
                  : Text(
                      l10n.view_all,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 14.sp,
                            color: AppColors.thirdColor,
                            fontWeight: FontWeight.w500
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
            itemCount: 4,
            itemBuilder: (context, index) {
              final item = _viewModel.getRecentTransactions()[index];
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
                            color: item.isExpense
                                ? AppColors.primaryColor.withValues(alpha: .15)
                                : AppColors.secondaryColor.withValues(alpha: .15),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            item.icon.icon,
                            size: 24.w,
                            color: item.isExpense
                                ? AppColors.primaryColor
                                : AppColors.secondaryColor,
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
                              item.category,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.borderColor,
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
                          item.isExpense
                              ? "- \$${item.amount.toStringAsFixed(2)}"
                              : "+ \$${item.amount.toStringAsFixed(2)}",
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: !item.isExpense
                                    ? CupertinoColors.systemGreen
                                    : null,
                              ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          DateFormat('dd/MM/yyyy').format(item.date),
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 12.sp,
                                color: AppColors.borderColor,
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
