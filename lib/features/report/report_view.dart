import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/widgets/skeleton/skeleton_report_view.dart';
import 'package:spend_flow/core/widgets/verify_passcode/verify_passcode_sheet.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/features/report/report_viewmodel.dart';
import 'package:spend_flow/features/transaction/view_transaction/transaction_detail_view.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final ReportViewModel _viewModel = ReportViewModel();
  bool get _isLoading => _viewModel.isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final String locale = Localizations.localeOf(context).toString();

    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, child) {
            if (_isLoading) {
              return const SkeletonReportView();
            }

            if (_viewModel.isLocked) {
              return Center(
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
                      style: TextStyle(
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
                        style: TextStyle(
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
              );
            }

            final groupedData = _viewModel.getGroupedTransactions();
            final stats = _viewModel.getSummaryStats();

            return Column(
              children: [
                _buildHeader(l10n),

                _buildSummary(l10n, stats),

                SizedBox(height: 10.h),

                Expanded(
                  child: groupedData.isEmpty
                      ? _buildNoDataView(l10n)
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: groupedData.length,
                          itemBuilder: (context, index) {
                            final group = groupedData[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  child: Text(
                                    _viewModel.formatDateHeader(
                                      group.date,
                                      l10n,
                                      locale,
                                    ),
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: CupertinoTheme.of(
                                        context,
                                      ).textTheme.textStyle.color,
                                    ),
                                  ),
                                ),
                                ...group.transactions.map(
                                  (tx) => _buildTransactionItem(tx),
                                ),
                              ],
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNoDataView(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              CupertinoIcons.doc_text_search,
              size: 50.sp,
              color: CupertinoColors.systemGrey.withValues(alpha: .5),
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            l10n.no_transactions,
            style: TextStyle(
              fontSize: 16.sp,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
                      style: TextStyle(
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
                      style: TextStyle(
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
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(AppLocalizations l10n, Map<String, double> stats) {
    final symbol = _viewModel.currencySymbol;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem(
            l10n.expenses,
            "-$symbol ${_viewModel.formatCurrency(stats['expense']!)}",
            CupertinoTheme.of(context).textTheme.textStyle.color!,
          ),
          _buildStatItem(
            l10n.income,
            "+$symbol ${_viewModel.formatCurrency(stats['income']!)}",
            CupertinoTheme.of(context).textTheme.textStyle.color!,
          ),
          _buildStatItem(
            l10n.balance,
            "${stats['balance']! < 0 ? '-' : ''}$symbol ${_viewModel.formatCurrency(stats['balance']!.abs())}",
            stats['balance']! >= 0
                ? AppColors.secondaryColor
                : AppColors.errorColor,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: CupertinoTheme.of(
              context,
            ).textTheme.textStyle.color?.withValues(alpha: .6),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(TransactionModel tx) {
    final amountColor = tx.isIncome
        ? CupertinoColors.activeGreen
        : CupertinoTheme.of(context).textTheme.textStyle.color!;
    final prefix = tx.isIncome ? "+" : "-";
    final symbol = _viewModel.currencySymbol;
    final iconData = AppIcons.getIcon(tx.category.iconKey);
    final File? imageFile = _viewModel.getRealImageFile(tx.category.iconKey);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => TransactionDetailView(transaction: tx),
            ),
          ),
        },
        child: Slidable(
          key: ValueKey(tx.id),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.15,
            children: [
              // CustomSlidableAction(
              //   onPressed: (context) => _onEditTransaction(tx),
              //   backgroundColor: Colors.transparent,
              //   foregroundColor: Colors.transparent,
              //   padding: EdgeInsets.zero,
              //   child: Container(
              //     width: 40.w,
              //     height: 40.w,
              //     decoration: BoxDecoration(
              //       color: CupertinoColors.systemGrey.withValues(alpha: 0.2),
              //       shape: BoxShape.circle,
              //     ),
              //     child: Center(
              //       child: Icon(
              //         CupertinoIcons.pencil,
              //         size: 20.sp,
              //         color: CupertinoTheme.of(context).textTheme.textStyle.color,
              //       ),
              //     ),
              //   ),
              // ),
              CustomSlidableAction(
                onPressed: (context) => {
                  HapticFeedback.heavyImpact(),
                  _onDeleteTransaction(tx),
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
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: tx.category.color.withValues(alpha: 0.15),
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
                      : Icon(iconData, color: tx.category.color, size: 24.sp),
                ),
                SizedBox(width: 14.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        tx.category.name,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "$prefix$symbol ${_viewModel.formatCurrency(tx.amount)}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: amountColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _viewModel.formatTime(tx.date),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.color?.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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

  void _onDeleteTransaction(TransactionModel tx) {
    final l10n = AppLocalizations.of(context)!;
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(l10n.delete_transaction),
        content: Text(l10n.delete_transaction_confirmation),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.cancel),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(ctx);
              await _viewModel.deleteTransaction(tx.id);
            },
            child: Text(l10n.delete),
          ),
        ],
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
                    style: TextStyle(
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
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime.now(),
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
}
