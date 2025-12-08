import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/utils/vietnamese_utils.dart';
import 'package:spend_flow/features/add_stransaction/add_stransaction_viewmodel.dart';
import 'package:spend_flow/features/add_stransaction/category/create_category.dart';
import 'package:spend_flow/features/add_stransaction/model/category_model.dart';

class SelectCategory extends StatelessWidget {
  final AddStransactionViewmodel _viewModel = AddStransactionViewmodel();

  SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final sortedSampleCategories = List<CategoryModel>.from(
      CategoryModel.sampleCategories,
    );

    sortedSampleCategories.sort((a, b) {
      final nameA = _viewModel.getTranslatedCategoryName(context, a);
      final nameB = _viewModel.getTranslatedCategoryName(context, b);

      final sortKeyA = VietnameseUtils.toSortable(nameA);
      final sortKeyB = VietnameseUtils.toSortable(nameB);

      return sortKeyA.compareTo(sortKeyB);
    });

    final sortedSuggestedCategories = List<CategoryModel>.from(
      CategoryModel.suggestedCategories,
    );

    sortedSuggestedCategories.sort((a, b) {
      final nameA = _viewModel.getTranslatedCategoryName(context, a);
      final nameB = _viewModel.getTranslatedCategoryName(context, b);

      final sortKeyA = VietnameseUtils.toSortable(nameA);
      final sortKeyB = VietnameseUtils.toSortable(nameB);

      return sortKeyA.compareTo(sortKeyB);
    });

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(end: 10.w),
        leading: CupertinoNavigationBarBackButton(
          color: CupertinoTheme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          l10n.select_category,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: GestureDetector(
          onTap: () async {
            final newCategory = await showModalBottomSheet<CategoryModel>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.90,

                  decoration: BoxDecoration(
                    color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: 40.w,
                          height: 5.h,
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey3,
                            borderRadius: BorderRadius.circular(2.5.r),
                          ),
                        ),
                      ),

                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.r),
                          ),
                          child: const AddCategoryPage(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );

            if (newCategory != null) {
              if (context.mounted) {
                Navigator.pop(context, newCategory);
              }
            }
          },
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   width: double.infinity,
              //   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              //   decoration: BoxDecoration(
              //     color: CupertinoTheme.of(context).barBackgroundColor,
              //     borderRadius: BorderRadius.circular(30.r),
              //     border: Border.all(
              //       color: AppColors.borderColor.withValues(alpha: .5),
              //     ),
              //   ),
              //   child: Row(
              //     children: [
              //       Icon(
              //         CupertinoIcons.search,
              //         size: 20.w,
              //         color: CupertinoColors.systemGrey,
              //       ),
              //       SizedBox(width: 8.w),
              //       Expanded(
              //         child: CupertinoTextField(
              //           controller: _searchController,
              //           placeholder: l10n.search_category,
              //           style: TextStyle(
              //             fontSize: 16.sp,
              //             color: CupertinoColors.label,
              //           ),
              //           decoration: null,
              //           cursorColor: CupertinoTheme.of(
              //             context,
              //           ).textTheme.textStyle.color,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 20.h),
              Text(
                l10n.most_used,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sortedSuggestedCategories.length,
                  itemBuilder: (context, index) {
                    final isLastItem =
                        index == sortedSuggestedCategories.length - 1;
                    final item = sortedSuggestedCategories[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context, item);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.w,
                                  margin: EdgeInsets.only(left: 12.w),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: item.color.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                  child: Icon(
                                    AppIcons.getIcon(item.iconKey),
                                    size: 25.w,
                                    color: item.color,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  item.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: CupertinoTheme.of(
                                      context,
                                    ).textTheme.textStyle.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (!isLastItem)
                          Divider(
                            color: CupertinoColors.systemGrey.withValues(
                              alpha: .3,
                            ),
                            height: 0.5.h,
                          ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                l10n.all_categories,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: CupertinoTheme.of(context).textTheme.textStyle.color,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sortedSampleCategories.length,
                  itemBuilder: (context, index) {
                    final isLastItem =
                        index == sortedSampleCategories.length - 1;
                    final item = sortedSampleCategories[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context, item);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.w,
                                  margin: EdgeInsets.only(left: 12.w),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: item.color.withValues(alpha: .2),
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                  child: Icon(
                                    AppIcons.getIcon(item.iconKey),
                                    size: 25.w,
                                    color: item.color,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  item.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: CupertinoTheme.of(
                                      context,
                                    ).textTheme.textStyle.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (!isLastItem)
                          Divider(
                            color: CupertinoColors.systemGrey.withValues(
                              alpha: .3,
                            ),
                            height: 0.5.h,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
