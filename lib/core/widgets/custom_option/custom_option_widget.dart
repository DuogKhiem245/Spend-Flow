import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOptionWidget extends StatelessWidget {
  final BuildContext context;
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isGradient;

  const CustomOptionWidget({
    super.key,
    required this.context,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.isGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          gradient: isGradient
              ? const LinearGradient(
                  colors: [Color(0xFF9C2CF3), Color(0xFF3A49F9)],
                )
              : null,
          color: isGradient ? null : color.withValues(alpha: 0.1),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isGradient ? CupertinoColors.white : color,
              size: 24.sp,
            ),
            SizedBox(width: 16.w),
            Text(
              label,
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isGradient ? CupertinoColors.white : color,
              ),
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.chevron_right,
              size: 16.sp,
              color: isGradient
                  ? CupertinoColors.white.withValues(alpha: .7)
                  : color.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
