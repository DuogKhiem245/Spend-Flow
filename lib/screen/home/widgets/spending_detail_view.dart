import 'dart:io';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/utils/category_helper.dart';
import 'package:spend_flow/screen/home/home_model.dart';
import 'package:spend_flow/screen/home/home_viewmodel.dart';
import 'package:spend_flow/screen/transaction/view_transaction/transaction_detail_view.dart';

class SpendingDetailView extends StatefulWidget {
  final HomeViewModel viewModel;

  const SpendingDetailView({super.key, required this.viewModel});

  @override
  State<SpendingDetailView> createState() => _SpendingDetailViewState();
}

class _SpendingDetailViewState extends State<SpendingDetailView>
    with WidgetsBindingObserver {
  List<SpendingModel> _chartData = [];

  List<TransactionModel> _allTransactions = [];
  String? _selectedCategory;

  bool _isLoading = true;
  int touchedIndex = -1;
  double _percentChange = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadData();
    widget.viewModel.initializeImage();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.viewModel.lockApp();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      widget.viewModel.lockApp();
      Navigator.pop(context);
    }
  }

  Future<void> _loadData() async {
    final chartDataFuture = widget.viewModel.getAllChartData();
    final transactionsFuture = widget.viewModel
        .getTransactionsForCurrentMonth();
    final change = await widget.viewModel.calculateSpendingChange();
    final results = await Future.wait([chartDataFuture, transactionsFuture]);

    if (mounted) {
      setState(() {
        _chartData = results[0] as List<SpendingModel>;
        _allTransactions = results[1] as List<TransactionModel>;
        _isLoading = false;
        _percentChange = change;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final sections = widget.viewModel.generateChartSections(
      _chartData,
      touchedIndex,
      context,
    );

    final totalSpent = widget.viewModel.calculateTotalSpent(_chartData);

    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: null,
          backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoTheme.of(context).primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
          middle: Text(
            l10n.spending_this_month,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: CupertinoTheme.of(context).barBackgroundColor,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.boxShadow,
                          blurRadius: 10.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.total_spent,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    color: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .color!
                                        .withValues(alpha: .6),
                                    fontSize: 14.sp,
                                  ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: _percentChange > 0
                                    ? AppColors.errorColor.withValues(
                                        alpha: .15,
                                      )
                                    : AppColors.primaryColor.withValues(
                                        alpha: .15,
                                      ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _percentChange > 0
                                        ? CupertinoIcons.arrow_up_right
                                        : CupertinoIcons.arrow_down_right,
                                    size: 14.sp,
                                    color: _percentChange > 0
                                        ? AppColors.errorColor
                                        : AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "${_percentChange > 0 ? '+' : ''}${_percentChange.toStringAsFixed(1)}% ${l10n.vs_last_month}",
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: _percentChange > 0
                                              ? AppColors.errorColor
                                              : AppColors.primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Text(
                          "${widget.viewModel.currencySymbol} ${widget.viewModel.formatCurrency(totalSpent)}",
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                color: CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.color,
                              ),
                        ),

                        if (_isLoading)
                          SizedBox(
                            height: 250.h,
                            child: Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                color: CupertinoTheme.of(context).primaryColor,
                                size: 30.w,
                              ),
                            ),
                          )
                        else if (_chartData.isEmpty)
                          SizedBox(
                            height: 250.h,
                            child: Center(
                              child: Text(
                                l10n.no_transactions,
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
                                      color: CupertinoColors.systemGrey,
                                      fontSize: 14.sp,
                                    ),
                              ),
                            ),
                          )
                        else
                          SizedBox(
                            height: 250.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(
                                      touchCallback:
                                          (
                                            FlTouchEvent event,
                                            pieTouchResponse,
                                          ) {
                                            setState(() {
                                              if (!event
                                                      .isInterestedForInteractions ||
                                                  pieTouchResponse == null ||
                                                  pieTouchResponse
                                                          .touchedSection ==
                                                      null) {
                                                touchedIndex = -1;
                                                return;
                                              }
                                              touchedIndex = pieTouchResponse
                                                  .touchedSection!
                                                  .touchedSectionIndex;
                                            });
                                          },
                                    ),
                                    sections: sections,
                                    centerSpaceRadius: 80.w,
                                    sectionsSpace: 0,
                                    startDegreeOffset: -90,
                                  ),
                                ),

                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      l10n.categories,
                                      style: CupertinoTheme.of(context)
                                          .textTheme
                                          .textStyle
                                          .copyWith(
                                            color: CupertinoTheme.of(context)
                                                .textTheme
                                                .textStyle
                                                .color!
                                                .withValues(alpha: .6),
                                            fontSize: 12.sp,
                                          ),
                                    ),
                                    Text(
                                      "${_chartData.length}",
                                      style: CupertinoTheme.of(context)
                                          .textTheme
                                          .textStyle
                                          .copyWith(
                                            fontSize: 24.sp,
                                            fontWeight: FontWeight.bold,
                                            color: CupertinoTheme.of(
                                              context,
                                            ).textTheme.textStyle.color,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        SizedBox(height: 20.h),

                        Center(
                          child: Wrap(
                            spacing: 15.w,
                            runSpacing: 10.h,
                            alignment: WrapAlignment.center,
                            children: _chartData.map((item) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 10.w,
                                    height: 10.w,
                                    decoration: BoxDecoration(
                                      color: item.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    item.originalCategory != null
                                        ? CategoryHelper.getTranslatedName(
                                            context,
                                            item.originalCategory!,
                                          )
                                        : (item.category.toLowerCase() ==
                                                  "other"
                                              ? l10n.other
                                              : item.category),

                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .copyWith(
                                          fontSize: 12.sp,
                                          color: CupertinoColors.systemGrey,
                                        ),
                                  ),
                                  Text(
                                    "(${(item.amount / totalSpent * 100).toStringAsFixed(0)}%)",
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                        .copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: CupertinoColors.systemGrey,
                                        ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                  _buildFilterTabs(l10n),
                  SizedBox(height: 20.h),
                  _buildTransactionList(l10n, widget.viewModel),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs(AppLocalizations l10n) {
    final Set<String> categories = {l10n.all};
    for (var tx in _allTransactions) {
      if (!tx.isIncome) {
        categories.add(CategoryHelper.getTranslatedName(context, tx.category));
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: categories.map((categoryName) {
          final bool isAllTab = categoryName == l10n.all;
          final bool isSelected = isAllTab
              ? _selectedCategory == null
              : _selectedCategory == categoryName;

          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = isAllTab ? null : categoryName;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : CupertinoTheme.of(context).barBackgroundColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: isSelected
                      ? null
                      : Border.all(
                          color: CupertinoColors.systemGrey.withValues(
                            alpha: .2,
                          ),
                        ),
                ),
                child: Text(
                  categoryName,
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(
                        color: isSelected
                            ? Colors.white
                            : CupertinoTheme.of(
                                context,
                              ).textTheme.textStyle.color,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransactionList(AppLocalizations l10n, HomeViewModel viewModel) {
    final filteredList = _allTransactions.where((t) {
      if (t.isIncome) return false;

      if (_selectedCategory != null &&
          CategoryHelper.getTranslatedName(context, t.category) !=
              _selectedCategory) {
        return false;
      }

      return true;
    }).toList();

    filteredList.sort((a, b) => b.date.compareTo(a.date));

    final groupedData = viewModel.groupTransactionsByDate(
      filteredList,
      context,
    );

    if (groupedData.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Text(
          l10n.no_transactions,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            color: CupertinoColors.systemGrey,
            fontSize: 14.sp,
          ),
        ),
      );
    }

    return Column(
      children: groupedData.entries.map((entry) {
        final dateKey = entry.key;
        final transactions = entry.value;

        double dailyTotal = 0;
        for (var t in transactions) {
          if (t.isIncome == false) dailyTotal += t.amount;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateKey,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color,
                        ),
                  ),
                  Text(
                    "${widget.viewModel.currencySymbol} ${widget.viewModel.formatCurrency(dailyTotal.abs())}",
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          color: CupertinoColors.systemGrey,
                          fontSize: 14.sp,
                        ),
                  ),
                ],
              ),
            ),

            ...transactions.map(
              (tx) => _buildTransactionItem(tx, widget.viewModel),
            ),

            SizedBox(height: 10.h),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTransactionItem(TransactionModel item, HomeViewModel viewModel) {
    final isIncome = item.isIncome;
    final amountColor = isIncome
        ? AppColors.primaryColor
        : CupertinoTheme.of(context).textTheme.textStyle.color;

    final File? imageFile = widget.viewModel.getRealImageFile(
      item.category.iconKey,
    );

    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => TransactionDetailView(transaction: item),
          ),
        ),
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.boxShadow.withValues(alpha: .05),
              blurRadius: 5.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: item.category.color.withValues(alpha: .15),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: imageFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(30.r),
                      child: Image.file(
                        imageFile,
                        width: 44.w,
                        height: 44.w,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      AppIcons.getIcon(item.category.iconKey),
                      color: item.category.color,
                      size: 20.sp,
                    ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: CupertinoTheme.of(
                            context,
                          ).textTheme.textStyle.color,
                        ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${CategoryHelper.getTranslatedName(context, item.category)} • ${widget.viewModel.formatHours(item.date)}",
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          color: CupertinoColors.systemGrey,
                          fontSize: 13.sp,
                        ),
                  ),
                ],
              ),
            ),
            Text(
              "${viewModel.currencySymbol} ${viewModel.formatCurrency(item.amount)}",
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                color: amountColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
