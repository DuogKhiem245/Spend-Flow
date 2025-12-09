import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/utils/vietnamese_utils.dart';
import 'package:spend_flow/features/add_stransaction/add_stransaction_viewmodel.dart';
import 'package:spend_flow/features/add_stransaction/category/create_category.dart';
import 'package:spend_flow/features/add_stransaction/model/category_model.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  final AddStransactionViewmodel _viewModel = AddStransactionViewmodel();

  List<CategoryModel> _allCategories = [];
  List<CategoryModel> _suggestedCategories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final storage = LocalStorageService();

    final all = await storage.getAllCategories();

    final suggested = await storage.getSmartSuggestions();

    if (mounted) {
      setState(() {
        _allCategories = all;
        _suggestedCategories = suggested;
        _isLoading = false;
      });
    }
  }

  List<CategoryModel> _sortCategories(
    BuildContext context,
    List<CategoryModel> inputList,
  ) {
    final sortedList = List<CategoryModel>.from(inputList);

    sortedList.sort((a, b) {
      final nameA = _viewModel.getTranslatedCategoryName(context, a);
      final nameB = _viewModel.getTranslatedCategoryName(context, b);

      final sortKeyA = VietnameseUtils.toSortable(nameA ?? a.name);
      final sortKeyB = VietnameseUtils.toSortable(nameB ?? b.name);

      return sortKeyA.compareTo(sortKeyB);
    });

    return sortedList;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final sortedAll = _sortCategories(context, _allCategories);
    final sortedSuggested = _sortCategories(context, _suggestedCategories);

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
          onTap: () => _openAddCategoryModal(context),
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: _isLoading
          ? const Center(child: CupertinoActivityIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategoryGroup(
                      context,
                      title: l10n.suggested_category, 
                      categories: sortedSuggested,
                    ),

                    SizedBox(height: 20.h),

                    _buildCategoryGroup(
                      context,
                      title: l10n.all_categories,
                      categories: sortedAll,
                    ),

                    SizedBox(height: 20.h), 
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildCategoryGroup(
    BuildContext context, {
    required String title,
    required List<CategoryModel> categories,
  }) {
    if (categories.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final isLastItem = index == categories.length - 1;
              final item = categories[index];

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
                            _viewModel.getTranslatedCategoryName(
                                  context,
                                  item,
                                ) ??
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
                      color: CupertinoColors.systemGrey.withValues(alpha: .3),
                      height: 0.5.h,
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _openAddCategoryModal(BuildContext context) async {
    final newCategory = await showModalBottomSheet<CategoryModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.90,
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
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
      await LocalStorageService().addCategory(newCategory);

      if (context.mounted) {
        Navigator.pop(context, newCategory);
      }
    }
  }
}
