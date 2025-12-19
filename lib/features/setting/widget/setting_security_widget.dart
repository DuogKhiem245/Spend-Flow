import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/setting/security/security_view.dart';
import 'package:spend_flow/features/setting/setting_viewmodel.dart';

class SettingSecurityWidget extends StatefulWidget {
  const SettingSecurityWidget({super.key});

  @override
  State<SettingSecurityWidget> createState() => _SettingSecurityWidgetState();
}

class _SettingSecurityWidgetState extends State<SettingSecurityWidget> {
  final SettingViewmodel _viewModel = SettingViewmodel();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            l10n.security,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .6),
            ),
          ),
        ),

        FutureBuilder<String>(
          future: _viewModel.checkBiometricSupport(l10n),
          builder: (context, snapshot) {
            final String bioType = snapshot.data ?? "";
            final String title = bioType.isEmpty
                ? "Passcode"
                : "Passcode & $bioType";

            return _SecurityItem(
              title: title,
              icon: CupertinoIcons.lock_fill,
              iconBgColor: const Color(0xFF71717A),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const SecurityView(),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _SecurityItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconBgColor;
  final VoidCallback onTap;

  const _SecurityItem({
    required this.title,
    required this.icon,
    required this.iconBgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
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
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(icon, size: 20.sp, color: Colors.white),
                    ),
                    SizedBox(width: 14.w),

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
                  ],
                ),

                Icon(
                  CupertinoIcons.chevron_right,
                  size: 18.sp,
                  color: CupertinoColors.systemGrey3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
