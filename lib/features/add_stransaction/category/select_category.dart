import 'package:cupertino_native/components/button.dart';
import 'package:cupertino_native/style/sf_symbol.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/utils/category_helper.dart';
import 'package:spend_flow/core/utils/vietnamese_utils.dart';
import 'package:spend_flow/features/add_stransaction/category/create_category.dart';
import 'package:spend_flow/features/add_stransaction/model/category_model.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
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
      final nameA = CategoryHelper.getTranslatedName(context, a);
      final nameB = CategoryHelper.getTranslatedName(context, b);

      final sortKeyA = VietnameseUtils.toSortable(nameA);
      final sortKeyB = VietnameseUtils.toSortable(nameB);

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
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
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
        ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: Container(
            decoration: BoxDecoration(
              color: CupertinoTheme.of(context).barBackgroundColor,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isLastItem = index == categories.length - 1;
                final item = categories[index];

                Widget itemContent = Column(
                  children: [
                    Padding(
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
                            CategoryHelper.getTranslatedName(context, item),
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
                    if (!isLastItem)
                      Divider(
                        color: CupertinoColors.systemGrey.withValues(alpha: .3),
                        height: 0.5.h,
                      ),
                  ],
                );

                if (item.isCustom) {
                  return Slidable(
                    key: ValueKey(item.id),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.30,
                      children: [
                        CustomSlidableAction(
                          onPressed: (context) => _onEditCategory(item),
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey.withValues(
                                alpha: 0.2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: CNButton.icon(
                                icon: CNSymbol(
                                  'pencil',
                                  size: 14.sp,
                                  color: CupertinoTheme.of(
                                    context,
                                  ).textTheme.textStyle.color,
                                ),
                                onPressed: () => _onEditCategory(item),
                              ),
                            ),
                          ),
                        ),

                        CustomSlidableAction(
                          onPressed: (context) =>
                              _onDeleteCategory(context, item),
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: AppColors.errorColor.withValues(
                                alpha: 0.2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: CNButton.icon(
                                icon: CNSymbol(
                                  'trash',
                                  size: 14.sp,
                                  color: AppColors.errorColor,
                                ),
                                onPressed: () =>
                                    _onDeleteCategory(context, item),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context, item),
                      child: Container(
                        color: Colors.transparent,
                        child: itemContent,
                      ),
                    ),
                  );
                }

                return GestureDetector(
                  onTap: () => Navigator.pop(context, item),
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity! < -300) {
                      _showSystemItemMessage(context);
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    child: itemContent,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _onEditCategory(CategoryModel category) async {
    await _openAddCategoryModal(context, categoryToEdit: category);
  }

  Future<void> _onDeleteCategory(
    BuildContext context,
    CategoryModel category,
  ) async {
    final l10n = AppLocalizations.of(context)!;

    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(l10n.delete),
        content: Text(l10n.are_you_sure_delete_category(category.name)),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.cancel),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text(l10n.delete),
            onPressed: () async {
              Navigator.pop(ctx);

              await LocalStorageService().deleteCategory(category);

              await _loadData();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _openAddCategoryModal(
    BuildContext context, {
    CategoryModel? categoryToEdit,
  }) async {
    final result = await showModalBottomSheet<CategoryModel>(
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
                  child: AddCategoryPage(categoryToEdit: categoryToEdit),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      final storage = LocalStorageService();

      if (categoryToEdit == null) {
        await storage.addCategory(result);
      } else {
        await storage.updateCategory(result);
      }

      await _loadData();

      if (categoryToEdit == null && context.mounted) {
        Navigator.pop(context, result);
      }
    }

    await _loadData();
  }

  void _showSystemItemMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: Text(l10n.system_category),
          content: Text(l10n.system_category_description),
          actions: [
            CupertinoDialogAction(
              child: Text(l10n.ok),
              onPressed: () {
                Navigator.pop(ctx);
              },
            ),
          ],
        );
      },
    );
  }
}
