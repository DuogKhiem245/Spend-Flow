import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonBudgetView extends StatelessWidget {
  const SkeletonBudgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = CupertinoTheme.of(context).barBackgroundColor;

    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final baseShimmer = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightShimmer = isDark ? Colors.grey[600]! : Colors.grey[100]!;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Shimmer.fromColors(
            baseColor: baseShimmer,
            highlightColor: highlightShimmer,
            child: Column(
              children: [
                _buildRect(100.w, 14.h),
                SizedBox(height: 12.h),
                _buildRect(180.w, 40.h),
                SizedBox(height: 12.h),
                _buildRect(200.w, 14.h),
                SizedBox(height: 20.h),
                _buildRect(double.infinity, 12.h, radius: 6),
                SizedBox(height: 16.h),
                _buildRect(120.w, 14.h),
              ],
            ),
          ),
        ),

        SizedBox(height: 24.h),

        Expanded(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: baseShimmer,
                  highlightColor: highlightShimmer,
                  child: _buildRect(120.w, 22.h),
                ),

                SizedBox(height: 12.h),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:  EdgeInsets.zero, 
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: baseShimmer,
                        highlightColor: highlightShimmer,
                        child: Row(
                          children: [
                            Container(
                              width: 48.w,
                              height: 48.w,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildRect(90.w, 16.h),
                                      SizedBox(height: 6.h),
                                      _buildRect(70.w, 13.h),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      _buildRect(100.w, 14.h),
                                      SizedBox(height: 8.h),
                                      _buildRect(100.w, 6.h, radius: 3),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRect(double width, double height, {double radius = 4}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }
}
