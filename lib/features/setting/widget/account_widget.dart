import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/auth/view/login_view.dart';
import 'package:spend_flow/features/setting/profile/profile_view.dart';

class AccountWidget extends StatelessWidget {
  final bool isLoggedIn;
  final bool isHaveProfile;

  const AccountWidget({
    super.key,
    required this.isLoggedIn,
    this.isHaveProfile = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
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
      child: isLoggedIn
          ? _buildUserView(l10n, context)
          : _buildGuestView(l10n, context),
    );
  }

  Widget _buildUserView(AppLocalizations l10n, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const ProfileView()),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              isHaveProfile
                  ? Container(
                      width: 60.r,
                      height: 60.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.borderColor,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.r),
                        child: Image.asset(
                          'lib/assets/images/avatar.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: 60.r,
                      height: 60.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.borderColor,
                      ),
                      child: Icon(
                        CupertinoIcons.person_fill,
                        size: 36.r,
                        color: AppColors.lightCard,
                      ),
                    ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'john.doe@example.com',
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color!.withValues(alpha: .6),
                        ),
                  ),
                ],
              ),
            ],
          ),
          Icon(
            CupertinoIcons.chevron_right,
            size: 24.r,
            color: CupertinoTheme.of(context).textTheme.textStyle.color,
          ),
        ],
      ),
    );
  }

  Widget _buildGuestView(AppLocalizations l10n, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 60.r,
                  height: 60.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.borderColor.withValues(alpha: .2),
                  ),
                  child: Icon(
                    CupertinoIcons.person_crop_circle,
                    size: 30.r,
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.sign_in_now,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        l10n.settings_description,
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: CupertinoTheme.of(
                                context,
                              ).textTheme.textStyle.color,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Icon(
              CupertinoIcons.chevron_right,
              size: 24.r,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          ),
        ],
      ),
    );
  }
}
