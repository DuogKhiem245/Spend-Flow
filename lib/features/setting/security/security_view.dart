import 'package:cupertino_native/components/switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';

class SecurityView extends StatefulWidget {
  const SecurityView({super.key});

  @override
  State<SecurityView> createState() => _SecurityViewState();
}

class _SecurityViewState extends State<SecurityView> {
  bool _isFaceIdEnabled = true;
  bool _isPasscodeEnabled = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: null,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoTheme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          'Passcode & Face ID',
          style: TextStyle(
            color: CupertinoTheme.of(context).textTheme.textStyle.color,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader("PASSCODE"),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  borderRadius: BorderRadius.circular(16.r),
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
                      children: [
                        Row(
                          children: [
                            _buildIconBox(
                              CupertinoIcons.lock_fill,
                              const Color(0xFF6366F1),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              "Passcode",
                              style: TextStyle(
                                color: CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.color,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        CNSwitch(
                          value: _isPasscodeEnabled,
                          onChanged: (value) {
                            setState(() {
                              _isPasscodeEnabled = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      l10n.pass_code_description,
                      style: TextStyle(
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color?.withValues(alpha: 0.7),

                        fontSize: 13.sp,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildInnerButton(
                      label: "Change Passcode",
                      icon: CupertinoIcons.padlock,
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              _buildSectionHeader(l10n.biometric_authentication.toUpperCase()),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  borderRadius: BorderRadius.circular(16.r),
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
                      children: [
                        Row(
                          children: [
                            _buildIconBox(
                              CupertinoIcons.smiley,
                              const Color(0xFFEF4444),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              "Face ID",
                              style: TextStyle(
                                color: CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.color,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        CNSwitch(
                          value: _isFaceIdEnabled,
                          onChanged: (value) {
                            setState(() {
                              _isFaceIdEnabled = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      l10n.face_id_description,
                      style: TextStyle(
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color?.withValues(alpha: 0.7),
                        fontSize: 13.sp,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF9CA3AF),
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildIconBox(IconData icon, Color color) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Icon(icon, color: Colors.white, size: 20.sp),
    );
  }

  Widget _buildInnerButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: CupertinoColors.white, size: 16.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
