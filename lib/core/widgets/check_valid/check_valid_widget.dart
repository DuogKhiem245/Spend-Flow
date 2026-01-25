import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckValidWidget {
  static void showIncompleteDetailsSheet({
    required BuildContext context,
    required String title,
    required String description,
    List<String>? missingFields,
    String buttonText = "OK",
    bool haveAction = false,
    VoidCallback? onButtonPressed,
    String? subtitle_1,
    String? subtitle_2,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              Row(
                children: [
                  Icon(
                    CupertinoIcons.exclamationmark_triangle_fill,
                    color: CupertinoColors.systemRed.resolveFrom(context),
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    title,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color,
                        ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              Text(
                description,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 15.sp,
                  height: 1.4,
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                ),
              ),

              SizedBox(height: 10.h),

              if (missingFields != null && missingFields.isNotEmpty) ...[
                ...missingFields.map(
                  (field) => _buildMissingFieldItem(context, field),
                ),
              ],

              if (haveAction && subtitle_1 != null && subtitle_2 != null) ...[
                Row(
                  children: [
                    Text(
                      subtitle_1,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 14.sp,
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color,
                          ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      onPressed: onButtonPressed,
                      child: Text(
                        subtitle_2,
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: CupertinoTheme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
              ],

              SizedBox(height: 16.h),

              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: CupertinoTheme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(30.r),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    buttonText,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildMissingFieldItem(BuildContext context, String fieldName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: CupertinoColors.systemRed.resolveFrom(context),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            fieldName,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: CupertinoColors.label.resolveFrom(context),
            ),
          ),
        ],
      ),
    );
  }
}
