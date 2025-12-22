import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/config/app_colors.dart';

class ProfileInfoItem extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? textValue;
  final TextInputType? keyboardType;
  final bool isReadOnly;
  final IconData? icon;
  final VoidCallback? onTap;

  const ProfileInfoItem({
    super.key,
    required this.label,
    this.controller,
    this.textValue,
    this.keyboardType,
    this.isReadOnly = false,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 14.sp,
            color: CupertinoColors.systemGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(18.w),
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
          child: Row(
            children: [
              Expanded(
                child: controller != null
                    ? CupertinoTextField(
                        controller: controller,
                        readOnly: isReadOnly,
                        onTap: onTap,
                        keyboardType: keyboardType,
                        decoration: null,
                        padding: EdgeInsets.zero,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: isReadOnly
                              ? CupertinoColors.systemGrey
                              : CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.color,
                        ),
                        cursorColor: CupertinoColors.activeBlue,
                      )
                    : GestureDetector(
                        onTap: onTap,
                        behavior: HitTestBehavior.opaque,
                        child: Text(
                          textValue ?? '',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color,
                          ),
                        ),
                      ),
              ),
              if (icon != null) ...[
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: controller == null ? onTap : null,
                  child: Icon(
                    icon,
                    color: CupertinoColors.systemGrey,
                    size: 20.w,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
