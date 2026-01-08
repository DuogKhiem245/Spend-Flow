import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'transaction_detail_viewmodel.dart'; // Nhớ import file ViewModel

class TransactionDetailView extends StatefulWidget {
  final TransactionModel transaction;
  const TransactionDetailView({super.key, required this.transaction});

  @override
  State<TransactionDetailView> createState() => _TransactionDetailViewState();
}

class _TransactionDetailViewState extends State<TransactionDetailView> {
  late TransactionDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TransactionDetailViewModel(transaction: widget.transaction);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _viewModel.loadTrendData(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            padding: EdgeInsetsDirectional.zero,
            backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
            border: null,
            middle: Text(
              l10n.transaction_details,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp),
            ),
            leading: CupertinoNavigationBarBackButton(
              color: CupertinoTheme.of(context).primaryColor,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                children: [
                  _buildMainCard(context, _viewModel),
                  SizedBox(height: 20.h),
                  if (_viewModel.hasNote) ...[
                    _buildNoteSection(context, _viewModel),
                    SizedBox(height: 20.h),
                  ],
                  _buildSpendingTrendSection(context, _viewModel),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainCard(BuildContext context, TransactionDetailViewModel vm) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: vm.categoryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: vm.isCustomImage
                ? ClipOval(
                    child: Image.file(
                      vm.customImageFile!,
                      fit: BoxFit.cover,
                      width: 80.w,
                      height: 80.w,
                    ),
                  )
                : Center(
                    child: Icon(
                      AppIcons.getIcon(vm.iconKey),
                      size: 40.sp,
                      color: vm.categoryColor,
                    ),
                  ),
          ),

          SizedBox(height: 12.h),

          Text(
            vm.name,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8.h),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: vm.categoryColor.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              vm.categoryName,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: vm.categoryColor,
              ),
            ),
          ),

          SizedBox(height: 10.h),
          Text(
            vm.amountString,
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            vm.getDateString(context),
            style: TextStyle(
              fontSize: 14.sp,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteSection(
    BuildContext context,
    TransactionDetailViewModel vm,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.note_2,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.systemGrey,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            vm.note,
            style: TextStyle(
              fontSize: 16.sp,
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingTrendSection(
    BuildContext context,
    TransactionDetailViewModel vm,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.spending_trend.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color!.withValues(alpha: .6),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    vm.categoryName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    vm.totalSpending7DaysString,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: CupertinoTheme.of(
                        context,
                      ).textTheme.textStyle.color,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.spending_last_7_days,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20.h),

          SizedBox(
            height: 150.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: vm.spendingTrendData.map((data) {
                return _buildBar(
                  context,
                  data.label,
                  data.percent,
                  data.isActive,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(
    BuildContext context,
    String day,
    double percent,
    bool isActive,
  ) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 25.w,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF4ADE80)
                      : CupertinoColors.systemGrey5,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.r),
                    topRight: Radius.circular(4.r),
                  ),
                ),
                height: 150.h * percent,
              ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          day,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: isActive
                ? const Color(0xFF4ADE80)
                : CupertinoColors.systemGrey,
          ),
        ),
      ],
    );
  }
}
