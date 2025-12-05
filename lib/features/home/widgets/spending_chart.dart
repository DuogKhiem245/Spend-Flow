import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/home/home_viewmodel.dart';

class SpendingChart extends StatelessWidget {
  SpendingChart({super.key});

  final HomeViewModel _viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final sections = _viewModel.getChartSections();
    final totalSpent = _viewModel.getTotalSpent();

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
              Text(
                l10n.spending_this_month,
                style: CupertinoTheme.of(context).textTheme.textStyle
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
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
          SizedBox(
            height: 200.h, 
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 80.w, 
                    sectionsSpace: 0, 
                    startDegreeOffset: -90, 
                    borderData: FlBorderData(show: false),
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.total_spent,
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "\$${totalSpent.toStringAsFixed(0)}", 
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
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
}
