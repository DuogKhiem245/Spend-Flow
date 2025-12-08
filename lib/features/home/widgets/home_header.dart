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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 54.w,
              height: 54.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/avatar.png'),
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
                SizedBox(height: 4.h),
                Text(
                  'John Doe',
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(
                        fontSize: 16.sp,
                        color: CupertinoColors.systemGrey,
                      ),
                ),
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
