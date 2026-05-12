import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/screen/premium/premium_viewmodel.dart';
import 'package:spend_flow/main.dart';

class PremiumView extends StatelessWidget {
  final bool isMaximized;
  const PremiumView({super.key, this.isMaximized = false});

  void _showAdaptiveDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String icon,
    bool isSuccess = false,
  }) {
    AdaptiveAlertDialog.show(
      context: context,
      title: title,
      message: message,
      icon: icon,
      actions: [
        AlertAction(
          title: "OK",
          style: AlertActionStyle.primary,
          onPressed: () {
            premiumViewModel.clearStatus();
            if (isSuccess && context.mounted) Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final viewModel = premiumViewModel;

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        if (viewModel.errorMessage != null) {
          final msg = viewModel.errorMessage!;
          final isCancelled = msg == l10n.cancel_purchase;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showAdaptiveDialog(
              context,
              title: isCancelled ? l10n.cancel : l10n.error,
              message: msg,
              icon: isCancelled
                  ? 'info.circle.fill'
                  : 'exclamationmark.octagon.fill',
            );
          });
        }

        if (viewModel.showSuccessDialog) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showAdaptiveDialog(
              context,
              title: l10n.congratulations,
              message: l10n.successfully_purchased,
              icon: 'checkmark.seal.fill',
              isSuccess: true,
            );
          });
        }

        if (viewModel.showRestoreSuccessDialog) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showAdaptiveDialog(
              context,
              title: l10n.restore_successful,
              message: l10n.successfully_purchased,
              icon: 'arrow.clockwise.icloud.fill',
              isSuccess: true,
            );
          });
        }

        return PopScope(
          canPop: !viewModel.isLoading,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            ),
            child: Column(
              children: [
                _buildStickyHeader(context, viewModel, l10n),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        _buildMainContent(l10n, context, viewModel),
                        SizedBox(height: 12.h),
                        Text(
                          l10n.premium_sync_account,
                          textAlign: TextAlign.center,
                          style: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.copyWith(fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                ),

                _buildBottomAction(viewModel, context, l10n),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStickyHeader(
    BuildContext context,
    PremiumViewModel viewModel,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!viewModel.isLoading) ...[
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: CupertinoTheme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            SizedBox(height: 10.h),
          ] else
            SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!viewModel.isLoading)
                _buildCloseButton(context)
              else
                SizedBox(height: 36.h),
              const Spacer(),

              if (!viewModel.isLoading)
                _buildRestoreButton(viewModel, l10n, context)
              else
                SizedBox(height: 36.h),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(
    AppLocalizations l10n,
    BuildContext context,
    PremiumViewModel viewModel,
  ) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: .2),
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
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: Icon(Icons.star, color: Colors.white, size: 16.sp),
            ),
          ],
        ),

        SizedBox(height: 24.h),

        Text(
          l10n.unlock_untilimited_access,
          textAlign: TextAlign.center,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 28.sp,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          l10n.unlock_untilimited_access_description,
          textAlign: TextAlign.center,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
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
                  border: Border.all(color: const Color(0xFFFFEDD5)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.daily_input_cap_reached,
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            l10n.daily_input_cap_reached_description,
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
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

        isMaximized ? SizedBox(height: 30.h) : const SizedBox.shrink(),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            l10n.feature_comparison,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
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
          "5/${l10n.day}",
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

        _buildComparisonRow(l10n.sync_data, "ads", "check", context: context),

        Divider(height: 24.h),

        _buildComparisonRow(l10n.no_ads, "ads", "check", context: context),

        // Divider(height: 24.h),

        // _buildComparisonRow(
        //   l10n.transaction_locking,
        //   "ads",
        //   "check",
        //   context: context,
        // ),

        Divider(height: 24.h),

        _buildComparisonRow(
          l10n.import_export_data,
          "ads",
          "check",
          context: context,
        ),

        SizedBox(height: 24.h),
        _buildPlanSelection(viewModel, l10n, context),
      ],
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
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color,
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
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
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
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color,
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
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color,
                      ),
                ),
        ),
      ],
    );
  }

  Widget _buildBottomAction(
    PremiumViewModel viewModel,
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 6.h, 20.w, 40.h),
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
          SizedBox(height: 6.h),
          ElevatedButton(
            onPressed: viewModel.isLoading
                ? null
                : () async {
                    await viewModel.purchasePremium(l10n);
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
                        "${l10n.continue_with(viewModel.planPrice(viewModel.selectedPlan))} ${viewModel.selectedPlan == PremiumPlan.monthly
                            ? "/ ${l10n.month}"
                            : viewModel.selectedPlan == PremiumPlan.yearly
                            ? "/ ${l10n.year}"
                            : ""}",
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(CupertinoIcons.arrow_right, size: 18.sp),
                    ],
                  ),
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.subscription_auto_renews,
            textAlign: TextAlign.center,
            style: CupertinoTheme.of(
              context,
            ).textTheme.textStyle.copyWith(fontSize: 11.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanSelection(
    PremiumViewModel viewModel,
    AppLocalizations l10n,
    BuildContext context,
  ) {
    return Column(
      children: [
        _buildPlanCard(
          context: context,
          title: l10n.monthly_plan,
          price: "${viewModel.planPrice(PremiumPlan.monthly)} / ${l10n.month}",
          isSelected: viewModel.selectedPlan == PremiumPlan.monthly,
          onTap: () => viewModel.selectPlan(PremiumPlan.monthly),
        ),
        SizedBox(height: 12.h),
        _buildPlanCard(
          context: context,
          title: l10n.yearly_plan,
          price: "${viewModel.planPrice(PremiumPlan.yearly)} / ${l10n.year}",
          description: l10n.yearly_discount,
          isSelected: viewModel.selectedPlan == PremiumPlan.yearly,
          tag: "-20%",
          onTap: () => viewModel.selectPlan(PremiumPlan.yearly),
        ),
        SizedBox(height: 12.h),
        _buildPlanCard(
          context: context,
          title: l10n.lifetime_plan,
          price: viewModel.planPrice(PremiumPlan.lifetime),
          description: l10n.pay_once_enjoy_forever,
          tag: l10n.best_value,
          isSelected: viewModel.selectedPlan == PremiumPlan.lifetime,
          onTap: () => viewModel.selectPlan(PremiumPlan.lifetime),
        ),
      ],
    );
  }

  Widget _buildPlanCard({
    required BuildContext context,
    required String title,
    required String price,
    required bool isSelected,
    required VoidCallback onTap,
    String? description,
    String? tag,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // 1. Thân Card chính
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryColor.withValues(alpha: .05)
                  : CupertinoTheme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : Colors.grey.withValues(alpha: .2),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? CupertinoIcons.checkmark_alt_circle_fill
                      : CupertinoIcons.circle,
                  color: isSelected ? AppColors.primaryColor : Colors.grey,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                            ),
                      ),
                      if (description != null) ...[
                        SizedBox(height: 4.h), // Thêm khoảng cách nhỏ cho đẹp
                        Text(
                          description,
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  price,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(fontWeight: FontWeight.w800, fontSize: 16.sp),
                ),
              ],
            ),
          ),

          if (tag != null)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18.r),
                    bottomLeft: Radius.circular(10.r), 
                  ),
                ),
                child: Text(
                  tag,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRestoreButton(
    PremiumViewModel viewModel,
    AppLocalizations l10n,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        viewModel.restorePurchase(l10n);
      },
      child: Text(
        l10n.restore,
        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
          fontSize: 15.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return GestureDetector(
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
    );
  }
}
