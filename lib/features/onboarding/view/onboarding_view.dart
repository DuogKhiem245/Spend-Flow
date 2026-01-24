import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import '../model/onboarding_model.dart';
import '../view_model/onboarding_viewmodel.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = OnboardingViewModel();
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  void _handlePageChanged(int index) {
    setState(() {
      _vm.onPageChanged(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final List<OnboardingModel> pages = _vm.getPages(l10n);

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _vm.pageController,
                itemCount: pages.length,
                onPageChanged: _handlePageChanged,
                itemBuilder: (context, index) {
                  final item = pages[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: Image.asset(
                            item.image,
                            height: 350.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 35.h),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            item.desc,
                            textAlign: TextAlign.center,
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 16.sp,
                                  height: 1.4,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  width: _vm.currentPage == index ? 22.w : 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: _vm.currentPage == index
                        ? CupertinoTheme.of(context).primaryColor
                        : AppColors.disabledColor.resolveFrom(context),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(
                      l10n.skip,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () => _vm.skip(context),
                  ),

                  CupertinoButton.filled(
                    borderRadius: BorderRadius.circular(30.r),
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: 80.w,
                      ), 
                      alignment: Alignment
                          .center,
                      child: Text(
                        _vm.currentPage == pages.length - 1
                            ? l10n.start
                            : l10n.next,
                        textAlign: TextAlign
                            .center, 
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                    onPressed: () => _vm.next(context, pages.length),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
