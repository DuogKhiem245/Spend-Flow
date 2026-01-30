import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/utils/category_helper.dart';
import 'package:spend_flow/core/utils/date_helper.dart';
import 'package:spend_flow/screen/category/category_view.dart';
import 'package:spend_flow/core/model/category_model.dart';

class SuggestCategoryWidget extends StatefulWidget {
  final CategoryModel? selectedCategory;
  final DateTime? transactionDate;
  final Color? baseColor;
  final bool isMonthPicker;
  final bool setMinDate;

  final ValueChanged<CategoryModel> onCategoryChanged;
  final ValueChanged<DateTime> onDateChanged;

  const SuggestCategoryWidget({
    super.key,
    required this.selectedCategory,
    required this.baseColor,
    required this.transactionDate,
    required this.onCategoryChanged,
    required this.onDateChanged,
    this.setMinDate = false,
    this.isMonthPicker = false,
  });

  @override
  State<SuggestCategoryWidget> createState() => _SuggestCategoryWidgetState();
}

class _SuggestCategoryWidgetState extends State<SuggestCategoryWidget> {
  List<CategoryModel> _displayCategories = [];

  @override
  void initState() {
    super.initState();
    _loadSuggestionsCategory();
  }

  Future<void> _loadSuggestionsCategory() async {
    final suggestions = LocalStorageService().getDefaultSuggestions();

    if (mounted) {
      setState(() {
        _displayCategories = suggestions;
      });
    }
  }

  void _showDatePicker(BuildContext context, DateTime initialDate) {
    if (widget.isMonthPicker) {
      final now = DateTime.now();

      DateTime? minDate = widget.setMinDate ? now : null;
      DateTime? maxDate = widget.setMinDate ? null : now;

      DateTime validInitialDate = initialDate;

      if (minDate != null && validInitialDate.isBefore(minDate)) {
        validInitialDate = minDate;
      }

      if (maxDate != null && validInitialDate.isAfter(maxDate)) {
        validInitialDate = maxDate;
      }

      showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
          height: 300.h,
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Container(
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    AppLocalizations.of(context)!.done,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(
                          color: CupertinoTheme.of(context).primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 250.h,
                child: CupertinoDatePicker(
                  initialDateTime: validInitialDate,
                  mode: CupertinoDatePickerMode.monthYear,
                  use24hFormat: true,
                  minimumDate: minDate,
                  maximumDate: maxDate,
                  onDateTimeChanged: (newDate) {
                    widget.onDateChanged(newDate);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      DateHelper.showDatePicker(
        context,
        initialDate: initialDate,
        onDateChanged: widget.onDateChanged,
      );
    }
  }

  String _getDateText(DateTime date, AppLocalizations l10n) {
    if (widget.isMonthPicker) {
      return DateFormat.yMMMM(l10n.localeName).format(date);
    }
    return DateHelper.getDateText(date, l10n);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final displayDate = widget.transactionDate ?? DateTime.now();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.suggested_category,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: .7),
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              ..._displayCategories.map((category) {
                final isSelected = widget.selectedCategory?.id == category.id;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.onCategoryChanged(category);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.boxShadow,
                          blurRadius: 10.r,
                          offset: Offset(0, 4.h),
                        ),
                      ],
                      color: isSelected
                          ? CupertinoTheme.of(context).primaryColor
                          : CupertinoTheme.of(context).barBackgroundColor,
                    ),
                    child: Text(
                      CategoryHelper.getTranslatedName(context, category),
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            color: isSelected
                                ? CupertinoColors.white
                                : CupertinoTheme.of(
                                    context,
                                  ).textTheme.textStyle.color,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                );
              }),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.boxShadow,
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.w,
                          margin: EdgeInsets.only(left: 16.w, right: 12.w),
                          decoration: BoxDecoration(
                            color: CupertinoTheme.of(
                              context,
                            ).primaryColor.withValues(alpha: .15),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Icon(
                            CupertinoIcons.tag_fill,
                            size: 25.w,
                            color: CupertinoTheme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          l10n.category,
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: widget.baseColor,
                              ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16.w),
                      child: GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CategoryView(),
                            ),
                          );
                          if (result != null && result is CategoryModel) {
                            widget.onCategoryChanged(result);
                          }
                        },
                        child: Row(
                          children: [
                            if (widget.selectedCategory != null)
                              Text(
                                CategoryHelper.getTranslatedName(
                                  context,
                                  widget.selectedCategory!,
                                ),
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: widget.baseColor,
                                    ),
                              ),
                            if (widget.selectedCategory == null)
                              Text(
                                l10n.select_category,
                                style: CupertinoTheme.of(context)
                                    .textTheme
                                    .textStyle
                                    .copyWith(
                                      fontSize: 16.sp,
                                      color: widget.baseColor?.withValues(
                                        alpha: .7,
                                      ),
                                    ),
                              ),
                            SizedBox(width: 8.w),
                            Icon(
                              CupertinoIcons.chevron_right,
                              size: 20.w,
                              color: widget.selectedCategory != null
                                  ? widget.baseColor
                                  : widget.baseColor?.withValues(alpha: .7),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),

                Divider(color: AppColors.borderColor, thickness: 0.2.h),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.w,
                          margin: EdgeInsets.only(left: 16.w, right: 12.w),
                          decoration: BoxDecoration(
                            color: CupertinoTheme.of(
                              context,
                            ).primaryColor.withValues(alpha: .15),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Icon(
                            widget.isMonthPicker
                                ? CupertinoIcons.calendar_today
                                : CupertinoIcons.calendar,
                            size: 25.w,
                            color: CupertinoTheme.of(context).primaryColor,
                          ),
                        ),
                        Text(
                          widget.isMonthPicker ? l10n.month : l10n.date,
                          style: CupertinoTheme.of(context).textTheme.textStyle
                              .copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: widget.baseColor,
                              ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16.w),
                      child: GestureDetector(
                        onTap: () {
                          _showDatePicker(context, displayDate);
                        },
                        child: Row(
                          children: [
                            Text(
                              _getDateText(displayDate, l10n),
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(
                                    fontSize: 16.sp,
                                    color: widget.baseColor,
                                  ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              CupertinoIcons.chevron_right,
                              size: 20.w,
                              color: widget.baseColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
