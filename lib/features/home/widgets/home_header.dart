import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/features/home/home_viewmodel.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({super.key});

  final HomeViewModel _viewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    final greetingMessage = _viewModel.getGreetingMessage(context);

    final User? user = _viewModel.currentUser;
    final String? photoUrl = user?.photoURL;

    final String displayName =
        (user?.displayName != null && user!.displayName!.isNotEmpty)
        ? user.displayName!
        : '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 54.w,
              height: 54.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.borderColor,
              ),
              child: ClipOval(
                child: photoUrl != null
                    ? Image.network(
                        photoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'lib/assets/images/avatar.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'lib/assets/images/avatar.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greetingMessage,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                if (displayName.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          fontSize: 16.sp,
                          color: CupertinoColors.systemGrey,
                        ),
                  ),
                ],
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 46.w,
            height: 46.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.bell_fill,
              size: 22.w,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
