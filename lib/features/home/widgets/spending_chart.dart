import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/home/home_model.dart';
import 'package:spend_flow/features/home/home_viewmodel.dart';
import 'package:spend_flow/features/home/widgets/spending_this_month_view.dart';

class SpendingChart extends StatefulWidget {
  final List<SpendingModel> chartData;

  const SpendingChart({super.key, required this.chartData});

  @override
  State<SpendingChart> createState() => _SpendingChartState();
}

class _SpendingChartState extends State<SpendingChart>
    with SingleTickerProviderStateMixin {
  final HomeViewModel _viewModel = HomeViewModel();

  int touchedIndex = -1;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (widget.chartData.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.boxShadow,
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              l10n.spending_this_month,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Icon(
              CupertinoIcons.chart_pie,
              size: 100.w,
              color: CupertinoColors.systemGrey3,
            ),
            SizedBox(height: 10.h),
            Text(
              l10n.no_transactions,
              style: TextStyle(color: CupertinoColors.systemGrey),
            ),
          ],
        ),
      );
    }

    final sections = _viewModel.generateChartSections(
      widget.chartData,
      touchedIndex,
      context,
    );
    final totalSpent = _viewModel.calculateTotalSpent(widget.chartData);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0.w),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadow,
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.spending_this_month,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, 
                    CupertinoPageRoute(
                      builder: (context) => SpendingDetailView()
                    ),
                  );
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
          SizedBox(height: 35.h),
          SizedBox(
            height: 200.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final double startAngle =
                        -90 + (180 * (1 - _animation.value));

                    return PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!
                                      .touchedSectionIndex;
                                });
                              },
                        ),
                        sections: sections,
                        centerSpaceRadius: 80.w,
                        sectionsSpace: 0,
                        startDegreeOffset: startAngle,
                      ),
                      swapAnimationDuration: Duration.zero,
                    );
                  },
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
                    ScaleTransition(
                      scale: _animation,
                      child: Text(
                        "\$${_viewModel.formatCurrency(totalSpent)}",
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            itemCount: widget.chartData.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = widget.chartData[index];
              return Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Row(
                  children: [
                    Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        color: item.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      item.category == "Other" ? l10n.other : item.category,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Spacer(),
                    Text(
                      "\$${_viewModel.formatCurrency(item.amount)}",
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
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
