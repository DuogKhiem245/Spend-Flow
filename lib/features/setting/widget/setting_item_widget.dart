import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/config/app_colors.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconBgColor;
  final Widget trailing;
  final VoidCallback? onTap;
  final String? description;

  const SettingItem({
    super.key,
    required this.title,
    required this.icon,
    required this.iconBgColor,
    required this.trailing,
    this.onTap,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      constraints: BoxConstraints(minHeight: 60.h),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadow.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30.r),
          splashColor: onTap == null ? Colors.transparent : null,
          highlightColor: onTap == null ? Colors.transparent : null,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Icon(icon, size: 20.sp, color: Colors.white),
                ),
                SizedBox(width: 14.w),

                Expanded(
                  child: description == null ?  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color,
                    ),
                  ) : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        description!,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color?.withValues(alpha: 0.6),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
