import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/main.dart';

class PremiumView extends StatelessWidget {
  final bool isMaximized;
  const PremiumView({super.key, this.isMaximized = false});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final viewModel = premiumViewModel;

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return PopScope(
          canPop: !viewModel.isLoading,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.92,
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(20.w, 70.h, 20.w, 0),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 100.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor.withValues(
                                      alpha: .2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    CupertinoIcons.lock_fill,
                                    size: 50.sp,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 16.sp,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            Text(
                              l10n.unlock_untilimited_access,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              l10n.unlock_untilimited_access_description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.grey.shade600,
                                height: 1.4,
                              ),
                            ),

                            SizedBox(height: 24.h),

                            isMaximized
                                ? Container(
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF7ED),
                                      borderRadius: BorderRadius.circular(30.r),
                                      border: Border.all(
                                        color: const Color(0xFFFFEDD5),
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6.w),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFFDBA74),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            CupertinoIcons.exclamationmark,
                                            color: Colors.white,
                                            size: 16.sp,
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                l10n.daily_input_cap_reached,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.sp,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                l10n.daily_input_cap_reached_description,
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Colors.black54,
                                                  height: 1.4,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),

                            isMaximized
                                ? SizedBox(height: 30.h)
                                : const SizedBox.shrink(),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                l10n.feature_comparison,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),

                            _buildComparisonRow(
                              l10n.feature,
                              l10n.free,
                              l10n.premium,
                              isHeader: true,
                              context: context,
                            ),

                            Divider(height: 24.h),

                            _buildComparisonRow(
                              l10n.unlimited_voice_entries,
                              "10/${l10n.day}",
                              "check",
                              context: context,
                            ),

                            Divider(height: 24.h),

                            _buildComparisonRow(
                              l10n.unlimited_scans,
                              "ads",
                              "check",
                              context: context,
                            ),

                            Divider(height: 24.h),

                            _buildComparisonRow(
                              l10n.sync_data,
                              "ads",
                              "check",
                              context: context,
                            ),

                            Divider(height: 24.h),

                            _buildComparisonRow(
                              l10n.no_ads,
                              "ads",
                              "check",
                              context: context,
                            ),

                            Divider(height: 24.h),

                            _buildComparisonRow(
                              l10n.transaction_locking,
                              "ads",
                              "check",
                              context: context,
                            ),

                            Divider(height: 24.h),

                            _buildComparisonRow(
                              l10n.import_export_data,
                              "ads",
                              "check",
                              context: context,
                            ),

                            SizedBox(height: 30.h),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 40.h),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .05),
                            blurRadius: 10,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: viewModel.isLoading
                                ? null
                                : () async {
                                    await viewModel.debugFakePurchase(
                                      shouldNotify: false,
                                    );

                                    if (context.mounted) {
                                      Navigator.of(context).pop();

                                      Future.delayed(
                                        const Duration(milliseconds: 300),
                                        () {
                                          viewModel.refreshPremiumStatus();
                                        },
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B82F6),
                              foregroundColor: Colors.white,
                              minimumSize: Size(double.infinity, 50.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              elevation: 0,
                            ),
                            child: viewModel.isLoading
                                ? LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.white,
                                    size: 24.sp,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        l10n.continue_with(
                                          viewModel.priceString,
                                        ),
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Icon(
                                        CupertinoIcons.arrow_right,
                                        size: 18.sp,
                                      ),
                                    ],
                                  ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            l10n.accept_terms_conditions,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (!viewModel.isLoading)
                  Positioned(
                    top: 20.h,
                    left: 16.w,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color?.withValues(alpha: .1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          CupertinoIcons.xmark,
                          size: 20.sp,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color?.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ),

                if (!viewModel.isLoading)
                  Positioned(
                    top: 30.h,
                    right: 20.w,
                    child: GestureDetector(
                      onTap: () {
                        viewModel.restorePurchase();
                      },
                      child: Text(
                        l10n.restore,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildComparisonRow(
    String feature,
    String free,
    String premium, {
    bool isHeader = false,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: isHeader
              ? Text(
                  feature,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                )
              : Row(
                  children: [
                    if (!isHeader)
                      Icon(
                        CupertinoIcons.viewfinder,
                        size: 16.sp,
                        color: const Color(0xFF3B82F6),
                      ),
                    if (!isHeader) SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        Expanded(
          flex: 2,
          child: free == "ads"
              ? Icon(
                  CupertinoIcons.nosign,
                  color: AppColors.errorColor,
                  size: 20.sp,
                )
              : Text(
                  free,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
        ),
        Expanded(
          flex: 2,
          child: premium == "check"
              ? Icon(
                  CupertinoIcons.checkmark_alt,
                  color: AppColors.primaryColor,
                  size: 20.sp,
                )
              : Text(
                  premium,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
        ),
      ],
    );
  }
}
