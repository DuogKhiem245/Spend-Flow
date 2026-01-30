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
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 14.sp,
            color: CupertinoColors.systemGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color: AppColors.borderColor.withValues(alpha: .5),
              width: 0.5.w,
            ),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
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
                    : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        child: GestureDetector(
                          onTap: onTap,
                          behavior: HitTestBehavior.opaque,
                          child: Text(
                            textValue ?? '',
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: CupertinoTheme.of(
                                    context,
                                  ).textTheme.textStyle.color,
                                ),
                          ),
                        ),
                      ),
              ),
              if (icon != null) ...[
                GestureDetector(
                  onTap: controller == null ? onTap : null,
                  child: Icon(
                    icon,
                    color: CupertinoColors.systemGrey,
                    size: 20.w,
                  ),
                ),
                SizedBox(width: 16.w),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
