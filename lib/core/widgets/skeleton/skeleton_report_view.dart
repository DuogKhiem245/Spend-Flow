import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonReportView extends StatelessWidget {
  const SkeletonReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildCirclePlaceholder(32.w), 
                      SizedBox(width: 15.w),
                      Column(
                        children: [
                          _buildRectPlaceholder(100.w, 20.h), 
                          SizedBox(height: 5.h),
                          _buildRectPlaceholder(60.w, 12.h),
                        ],
                      ),
                      SizedBox(width: 15.w),
                      _buildCirclePlaceholder(32.w),
                    ],
                  ),
                  _buildRectPlaceholder(24.w, 24.w), 
                ],
              ),
            ),
          ),

          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  3,
                  (index) => Column(
                    children: [
                      _buildRectPlaceholder(50.w, 12.h), 
                      SizedBox(height: 6.h),
                      _buildRectPlaceholder(80.w, 16.h), 
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10.h),

          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: 4, // Giả lập 4 nhóm ngày
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: _buildRectPlaceholder(150.w, 18.h),
                    ),

                    ...List.generate(
                      2,
                      (i) => Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48.w,
                              height: 48.w,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 14.w),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildRectPlaceholder(100.w, 16.h),
                                  SizedBox(height: 6.h),
                                  _buildRectPlaceholder(60.w, 12.h),
                                ],
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildRectPlaceholder(80.w, 16.h),
                                SizedBox(height: 6.h),
                                _buildRectPlaceholder(40.w, 12.h),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRectPlaceholder(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  Widget _buildCirclePlaceholder(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
