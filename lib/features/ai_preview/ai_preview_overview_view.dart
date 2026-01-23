import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/utils/category_helper.dart';
import 'package:spend_flow/features/ai_preview/ai_preview_overview_viewmodel.dart';
import 'package:spend_flow/features/category/category_viewmodel.dart';
import 'package:spend_flow/features/transaction/add_transaction/add_transaction_view.dart';

class AIPreviewOverviewView extends StatefulWidget {
  final List<TransactionModel>? transactions;

  const AIPreviewOverviewView({super.key, this.transactions});

  @override
  State<AIPreviewOverviewView> createState() => _AIPreviewOverviewViewState();
}

class _AIPreviewOverviewViewState extends State<AIPreviewOverviewView> {
  final CategoryViewModel _viewModel = CategoryViewModel();
  final AIPreviewOverviewViewmodel _aiPreviewViewModel =
      AIPreviewOverviewViewmodel();

  final Set<int> _selectedTransactionIndices = {};

  late List<TransactionModel> _localTransactions;

  @override
  void initState() {
    super.initState();

    _localTransactions = List.from(widget.transactions ?? []);

    _aiPreviewViewModel.initData();

    if (_localTransactions.isNotEmpty) {
      _selectedTransactionIndices.addAll(
        Iterable.generate(_localTransactions.length),
      );
    }
  }

  void _handleConfirm() async {
    final List<TransactionModel> transactionsToSave =
        _selectedTransactionIndices
            .map((index) => _localTransactions[index])
            .toList();

    if (transactionsToSave.isEmpty) return;

    final bool success = await _aiPreviewViewModel.saveBatchTransactions(
      transactionsToSave,
    );

    if (success) {
      HapticFeedback.heavyImpact();
      if (!mounted) return;
      Navigator.pop(context, true);
    } else {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      _showErrorDialog(context, l10n.fail_to_save_transactions);
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    final l10n = AppLocalizations.of(context)!;
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(l10n.error),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(end: 10.w),
        border: null,
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoTheme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          l10n.preview_results,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFFD1E4FF),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.sparkles,
                size: 14.sp,
                color: CupertinoTheme.of(context).primaryColor,
              ),
              SizedBox(width: 4.w),
              Text(
                l10n.ai_powered,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: CupertinoTheme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              _buildHeader(l10n),

              if (_localTransactions.isNotEmpty) ...[
                ..._localTransactions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final transaction = entry.value;
                  return _buildReviewCard(
                    index: index,
                    model: transaction,
                    title: transaction.title,
                    category: CategoryHelper.getTranslatedName(
                      context,
                      transaction.category,
                    ),
                    amount: transaction.amount,
                    date: transaction.date,
                    icon: transaction.category.iconKey,
                    color: transaction.category.color,
                    isIncome: transaction.isIncome,
                    isSelected: _selectedTransactionIndices.contains(index),
                    onToggle: () {
                      setState(() {
                        if (_selectedTransactionIndices.contains(index)) {
                          _selectedTransactionIndices.remove(index);
                        } else {
                          _selectedTransactionIndices.add(index);
                        }
                      });
                    },
                  );
                }),
              ],

              SizedBox(height: 100.h),
            ],
          ),

          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              color: const Color(0xFF007AFF),
              borderRadius: BorderRadius.circular(30.r),
              onPressed: _selectedTransactionIndices.isNotEmpty ? () => _handleConfirm() : null,
              child: Text(
                "${l10n.confirm_selected_entries} (${_selectedTransactionIndices.length})",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: CupertinoColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard({
    required int index,
    required dynamic model,
    required String title,
    required String category,
    required double amount,
    required DateTime date,
    required String icon,
    required bool isSelected,
    required Color color,
    required bool isIncome,
    required VoidCallback onToggle,
  }) {
    final File? imageFile = _viewModel.getRealImageFile(icon);
    final bool hasImage = imageFile != null;
    final String prefix = isIncome ? "+" : "-";

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).barBackgroundColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(30.r),
              image: hasImage
                  ? DecorationImage(
                      image: FileImage(imageFile),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: hasImage
                ? null
                : Icon(AppIcons.getIcon(icon), size: 24.w, color: color),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "$category • ${DateFormat('dd MMM yyyy').format(date)}",
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: CupertinoTheme.of(
                      context,
                    ).textTheme.textStyle.color?.withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      "$prefix ${_aiPreviewViewModel.formatCurrency(amount)}",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: isIncome
                            ? AppColors.secondaryColor
                            : AppColors.errorColor,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        final updatedData =
                            await Navigator.push<TransactionModel>(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => AddTransactionPage(
                                  transactionData: model,
                                  isFromAI: true,
                                ),
                              ),
                            );

                        if (updatedData != null && mounted) {
                          setState(() {
                            _localTransactions[index] = updatedData;
                          });
                        }
                      },
                      child: Icon(
                        CupertinoIcons.pencil,
                        size: 24.sp,
                        color: CupertinoTheme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          CupertinoButton(
            padding: EdgeInsets.only(left: 8.w),
            onPressed: onToggle,
            child: Icon(
              isSelected
                  ? CupertinoIcons.checkmark_alt_circle_fill
                  : CupertinoIcons.add_circled,
              color: isSelected
                  ? AppColors.secondaryColor
                  : CupertinoTheme.of(
                      context,
                    ).textTheme.textStyle.color?.withValues(alpha: 0.3),
              size: 32.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    int total = _localTransactions.length;

    bool isAllSelected =
        _selectedTransactionIndices.length == total && total > 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$total ${l10n.entries_pending}",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.systemGrey,
          ),
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(
            isAllSelected ? l10n.clear_all : l10n.select_all,
            style: TextStyle(
              fontSize: 14.sp,
              color: CupertinoTheme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            setState(() {
              if (isAllSelected) {
                _selectedTransactionIndices.clear();
              } else {
                _selectedTransactionIndices.addAll(Iterable.generate(total));
              }
            });
          },
        ),
      ],
    );
  }
}
