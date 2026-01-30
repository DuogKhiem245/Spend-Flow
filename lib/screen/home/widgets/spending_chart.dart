import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/utils/category_helper.dart';
import 'package:spend_flow/core/widgets/verify_passcode/verify_passcode_sheet.dart';
import 'package:spend_flow/screen/home/home_model.dart';
import 'package:spend_flow/screen/home/home_viewmodel.dart';
import 'package:spend_flow/screen/home/widgets/spending_detail_view.dart';

class SpendingChart extends StatefulWidget {
  final List<SpendingModel> chartData;
  final HomeViewModel viewModel;

  const SpendingChart({
    super.key,
    required this.chartData,
    required this.viewModel,
  });

  @override
  State<SpendingChart> createState() => _SpendingChartState();
}

class _SpendingChartState extends State<SpendingChart>
    with SingleTickerProviderStateMixin {
  int touchedIndex = -1;
  late AnimationController _animationController;
  late Animation<double> _animation;

  Future<bool> _handleUnlock() async {
    bool success = false;

    if (widget.viewModel.isFaceIdAvailable) {
      success = await widget.viewModel.authenticateBiometric();
    }

    if (!success && mounted && widget.viewModel.isLocked) {
      _showUnlockModal(context);
    }

    return success;
  }

  void _showUnlockModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VerifyPasscodeSheet(
        onVerify: (code) => widget.viewModel.verifyPasscode(code),
      ),
    );
  }

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

    final sections = widget.viewModel.generateChartSections(
      widget.chartData,
      touchedIndex,
      context,
    );
    final totalSpent = widget.viewModel.calculateTotalSpent(widget.chartData);

    final symbol = widget.viewModel.currencySymbol;

    if (widget.chartData.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
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
          children: [
            Text(
              l10n.spending_this_month,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
            ),
            SizedBox(height: 20.h),
            Icon(
              CupertinoIcons.chart_pie,
              size: 120.w,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .5),
            ),
            SizedBox(height: 10.h),
            Text(
              l10n.no_transactions,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                color: CupertinoTheme.of(
                  context,
                ).textTheme.textStyle.color?.withValues(alpha: .6),
              ),
            ),
          ],
        ),
      );
    }

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  l10n.spending_this_month,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (widget.viewModel.isLocked) {
                    final unlocked = await _handleUnlock();
                    if (unlocked && context.mounted) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              SpendingDetailView(viewModel: widget.viewModel),
                        ),
                      );
                    }
                  } else {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            SpendingDetailView(viewModel: widget.viewModel),
                      ),
                    );
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.viewModel.hasSecurity) ...[
                      Icon(
                        widget.viewModel.isLocked
                            ? CupertinoIcons.lock_fill
                            : null,
                        size: 14.sp,
                      ),
                      SizedBox(width: 8.w),
                    ],
                    Text(
                      l10n.view_all,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 14.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
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
                      duration: Duration.zero,
                    );
                  },
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.total_spent,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            color: CupertinoColors.systemGrey,
                            fontSize: 14.sp,
                          ),
                    ),
                    SizedBox(height: 4.h),
                    ScaleTransition(
                      scale: _animation,
                      child: Text(
                        "$symbol ${widget.viewModel.formatCompactCurrency(totalSpent)}",
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
          Stack(
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: widget.viewModel.isLocked ? 7.0 : 0.0,
                  sigmaY: widget.viewModel.isLocked ? 7.0 : 0.0,
                ),
                child: ListView.builder(
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
                            item.originalCategory != null
                                ? CategoryHelper.getTranslatedName(
                                    context,
                                    item.originalCategory!,
                                  )
                                : (item.category.toLowerCase() == "other"
                                      ? l10n.other
                                      : item.category),

                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),

                          Spacer(),
                          Text(
                            "$symbol ${widget.viewModel.formatCurrency(item.amount)}",
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
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
              ),
              if (widget.viewModel.isLocked)
                Positioned.fill(
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: CupertinoButton(
                      onPressed: _handleUnlock,
                      color: CupertinoTheme.of(
                        context,
                      ).barBackgroundColor.withValues(alpha: .8),
                      borderRadius: BorderRadius.circular(50.r),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.eye_slash_fill, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            l10n.click_to_unlock,
                            style: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
