import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';

class StreakCard extends StatelessWidget {
  const StreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final int day = 7;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8C00), Color(0xFFFF4500)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF4500).withValues(alpha: .3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.flame_fill,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n!.keep_your_streak_day(day as String),
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                Text(
                  l10n.tap_to_check_in,
                  style: CupertinoTheme.of(
                    context,
                  ).textTheme.textStyle.copyWith(fontSize: 12.sp),
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.chevron_right,
            color: CupertinoTheme.of(context).textTheme.textStyle.color,
            size: 18,
          ),
        ],
      ),
    );
  }
}
