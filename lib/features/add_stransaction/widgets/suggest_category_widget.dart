import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/core/utils/date_helper.dart';
import 'package:spend_flow/features/add_stransaction/add_stransaction_viewmodel.dart';
import 'package:spend_flow/features/add_stransaction/category/select_category.dart';
import 'package:spend_flow/features/add_stransaction/model/category_model.dart';

class SuggestCategoryWidget extends StatefulWidget {
  final CategoryModel? selectedCategory;
  final DateTime? transactionDate;
  final AddStransactionViewmodel viewModel;
  final Color? baseColor;

  final ValueChanged<CategoryModel> onCategoryChanged;
  final ValueChanged<DateTime> onDateChanged;

  const SuggestCategoryWidget({
    super.key,
    required this.selectedCategory,
    required this.viewModel,
    required this.baseColor,
    required this.transactionDate,
    required this.onCategoryChanged,
    required this.onDateChanged,
  });

  @override
  State<SuggestCategoryWidget> createState() => _SuggestCategoryWidgetState();
}

class _SuggestCategoryWidgetState extends State<SuggestCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.suggested_category,
          style: TextStyle(
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
            ...CategoryModel.suggestedCategories.map((category) {
              final isSelected = widget.selectedCategory == category;
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
                    color: isSelected
                        ? CupertinoTheme.of(context).primaryColor
                        : CupertinoTheme.of(context).barBackgroundColor,
                  ),
                  child: Text(
                    widget.viewModel.getTranslatedCategoryName(
                      context,
                      category,
                    ),
                    style: TextStyle(
                      color: isSelected
                          ? CupertinoColors.white
                          : CupertinoTheme.of(context)
                              .textTheme
                              .textStyle
                              .color,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
        SizedBox(height: 20.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            borderRadius: BorderRadius.circular(30.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h),
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
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Icon(
                          CupertinoIcons.tag_fill,
                          size: 25.w,
                          color: CupertinoTheme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        l10n.category,
                        style: TextStyle(
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
                            builder: (context) =>
                                SelectCategory(), 
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
                              widget.viewModel.getTranslatedCategoryName(
                                context,
                                widget.selectedCategory!,
                              ),
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: widget.baseColor,
                              ),
                            ),
                          if (widget.selectedCategory == null)
                            Text(
                              l10n.select_category,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: widget.baseColor?.withValues(alpha: .7),
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

              Divider(color: AppColors.borderColor, thickness: 0.5.h),
              SizedBox(height: 5.h),
              DateHelper(
                l10n: l10n,
                baseColor: widget.baseColor,
                onDateChanged: (DateTime newDate) {
                  widget.onDateChanged(newDate);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
