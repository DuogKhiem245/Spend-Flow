import 'dart:io';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/services/ads_service.dart';
import 'package:spend_flow/core/utils/category_helper.dart';
import 'package:spend_flow/core/widgets/skeleton/skeleton_budget_view.dart';
import 'package:spend_flow/core/widgets/verify_passcode/verify_passcode_sheet.dart';
import 'package:spend_flow/main.dart';
import 'package:spend_flow/screen/budget/add_budget/add_budget_view.dart';
import '../../core/model/budget_model.dart';
import 'budget_viewmodel.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  final BudgetViewModel _viewModel = BudgetViewModel();
  final AdsService _adsService = AdsService();
  final _premiumViewModel = premiumViewModel;

  bool _isPremium = false;
  bool _hasBanner = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
     _checkBanner();
    setState(() {
      _isPremium = _premiumViewModel.isPremium;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _viewModel.lockApp();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _viewModel.lockApp();
    }
  }

  Future<void> _checkBanner() async {
    final available = await _adsService.checkBannerAdAvailable();
    if (mounted) {
      setState(() {
        _hasBanner = available;
      });
    }
  }

  Future<void> _navigateToAddBudget() async {
    HapticFeedback.heavyImpact();

    await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const AddBudgetView()),
    );
    _viewModel.refreshData();
  }

  void _showUnlockModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VerifyPasscodeSheet(
        onVerify: (code) => _viewModel.verifyPasscode(code),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return CupertinoPageScaffold(
          child: SafeArea(
            child: _viewModel.isLoading
                ? const SkeletonBudgetView()
                : _viewModel.isLocked
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.lock_shield_fill,
                          size: 80.sp,
                          color: CupertinoTheme.of(context).primaryColor,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          l10n.report_locked,
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.color,
                              ),
                        ),
                        SizedBox(height: 10.h),
                        CupertinoButton(
                          child: Text(
                            l10n.unlock,
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          onPressed: () {
                            _viewModel.authenticateBiometric().then((_) {
                              if (_viewModel.isLocked && context.mounted) {
                                _showUnlockModal(context);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      Column(
                        children: [
                          _buildHeader(l10n),
                          SizedBox(height: 10.h),
                          _buildTotalBudgetCard(l10n),
                          SizedBox(height: 10.h),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.categories,
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .copyWith(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: CupertinoTheme.of(
                                            context,
                                          ).textTheme.textStyle.color,
                                        ),
                                  ),
                                  SizedBox(height: 12.h),

                                  if (_viewModel.isLoading)
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 50.h),
                                        child:
                                            const CupertinoActivityIndicator(),
                                      ),
                                    )
                                  else if (_viewModel.budgets.isEmpty)
                                    _buildEmptyState(l10n)
                                  else
                                    ..._viewModel.budgets.map(
                                      (e) => _buildCategoryCard(e),
                                    ),

                                  SizedBox(height: 80.h),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      Positioned(
                        right: 0.w,
                        bottom: (_isPremium || !_hasBanner)
                            ? 50.h
                            : Platform.isIOS
                            ? 98.h
                            : 108.h,
                        child: CupertinoButton(
                          onPressed: _navigateToAddBudget,
                          child: Container(
                            width: 60.w,
                            height: 60.w,
                            decoration: BoxDecoration(
                              color: CupertinoTheme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              CupertinoIcons.add,
                              color: CupertinoColors.white,
                              size: 30.sp,
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

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100.h),
          Icon(
            CupertinoIcons.creditcard,
            size: 50.sp,
            color: CupertinoColors.systemGrey,
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.no_budgets_yet,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .6),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.create_budget_description,
            textAlign: TextAlign.center,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              fontSize: 14.sp,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalBudgetCard(AppLocalizations l10n) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            l10n.your_monthly_budget,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              fontSize: 14.sp,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color!.withValues(alpha: .6),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _viewModel.formatCurrency(_viewModel.totalBudget),
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              fontSize: 40.sp,
              fontWeight: FontWeight.w800,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          ),
          SizedBox(height: 8.h),
          RichText(
            text: TextSpan(
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                fontSize: 14.sp,
                color: CupertinoTheme.of(context).textTheme.textStyle.color,
              ),
              children: [
                TextSpan(text: l10n.spent),
                TextSpan(
                  text: _viewModel.formatCurrency(_viewModel.totalSpent),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: l10n.out_of),
                TextSpan(
                  text: _viewModel.formatCurrency(_viewModel.totalBudget),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          _buildProgressBar(progress: _viewModel.totalProgress, height: 12.h),

          SizedBox(height: 12.h),
          Text(
            "${_viewModel.formatCurrency(_viewModel.totalRemaining)} ${l10n.left_to_spend}",
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              fontSize: 14.sp,
              color: _viewModel.getProgressBarColor(_viewModel.totalProgress),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BudgetModel budget) {
    final iconData = AppIcons.getIcon(budget.iconKey);
    final File? imageFile = _viewModel.getRealImageFile(budget.iconKey);

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: () => {HapticFeedback.selectionClick(), _onEditBudget(budget)},
        child: Slidable(
          key: ValueKey(budget.id),
          enabled: _viewModel.canEdit,
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.15,
            children: [
              CustomSlidableAction(
                onPressed: (context) => {
                  HapticFeedback.heavyImpact(),
                  _onDeleteBudget(budget, context),
                },
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.errorColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.trash,
                      size: 20.sp,
                      color: AppColors.errorColor,
                    ),
                  ),
                ),
              ),
            ],
          ),

          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.boxShadow,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: budget.color.withValues(alpha: .15),
                    shape: BoxShape.circle,
                  ),
                  child: imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: Image.file(
                            imageFile,
                            width: 24.w,
                            height: 24.w,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(iconData, color: budget.color, size: 24.sp),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CategoryHelper.getTranslatedName(
                              context,
                              budget.category,
                            ),
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: CupertinoTheme.of(
                                    context,
                                  ).textTheme.textStyle.color,
                                ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${_viewModel.formatCurrency(budget.remaining)} left",
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 13.sp,
                                  color: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle
                                      .color!
                                      .withValues(alpha: .6),
                                ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${_viewModel.formatCurrency(budget.spent)} / ${_viewModel.formatCurrency(budget.total)}",
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .textStyle
                                .copyWith(
                                  fontSize: 14.sp,
                                  color: CupertinoTheme.of(context)
                                      .textTheme
                                      .textStyle
                                      .color!
                                      .withValues(alpha: .6),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          SizedBox(height: 6.h),
                          SizedBox(
                            width: 100.w,
                            child: _buildProgressBar(
                              progress: budget.progress,
                              height: 6.h,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onEditBudget(BudgetModel budget) async {
    await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => AddBudgetView(budgetToEdit: budget),
      ),
    );
    _viewModel.refreshData();
  }

  void _onDeleteBudget(BudgetModel budget, BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final String categoryName = CategoryHelper.getTranslatedName(context, budget.category);

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.delete_budget,
      message: l10n.are_you_sure_delete_budget(categoryName),
      icon: 'trash.fill',
      actions: [
        AlertAction(
          title: l10n.cancel,
          style: AlertActionStyle.cancel,
          onPressed: () => {},
        ),
        AlertAction(
          title: l10n.delete,
          style: AlertActionStyle.destructive,
          onPressed: () async {
            await _viewModel.deleteBudget(budget);
          },
        ),
      ],
    );
  }

  Widget _buildProgressBar({required double progress, required double height}) {
    final barColor = _viewModel.getProgressBarColor(progress);

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    final String locale = Localizations.localeOf(context).toString();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildCircleButton(
                icon: CupertinoIcons.chevron_left,
                onTap: _viewModel.previousMonth,
              ),
              SizedBox(width: 15.w),
              SizedBox(
                width: 130.w,
                child: Column(
                  children: [
                    Text(
                      toBeginningOfSentenceCase(
                            DateFormat(
                              'MMMM',
                              locale,
                            ).format(_viewModel.selectedMonth),
                          ) ??
                          '',
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color,
                          ),
                    ),

                    Text(
                      DateFormat(
                        'yyyy',
                        locale,
                      ).format(_viewModel.selectedMonth),
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 12.sp,
                            color: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle.color?.withValues(alpha: .6),
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.w),
              _buildCircleButton(
                icon: CupertinoIcons.chevron_right,
                onTap: _viewModel.nextMonth,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              _showDatePicker(context, l10n);
            },
            child: Icon(
              CupertinoIcons.calendar_today,
              color: CupertinoColors.activeBlue,
              size: 32.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: CupertinoTheme.of(context).textTheme.textStyle.color,
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context, AppLocalizations l10n) {
    DateTime tempDate = _viewModel.selectedMonth;

    showCupertinoModalPopup(
      context: context,
      builder: (ctx) {
        return Container(
          height: 300.h,
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Container(
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    _viewModel.setMonth(tempDate);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    l10n.done,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          color: CupertinoTheme.of(context).primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.monthYear,
                  initialDateTime: _viewModel.selectedMonth,
                  minimumDate: DateTime(2000),
                  onDateTimeChanged: (newDate) {
                    tempDate = newDate;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
