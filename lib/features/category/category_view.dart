import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/utils/category_helper.dart';
import 'package:spend_flow/features/category/add_category.dart';
import 'package:spend_flow/features/category/category_viewmodel.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  final CategoryViewModel _viewModel = CategoryViewModel();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        final sortedAll = _viewModel.sortCategories(
          context,
          _viewModel.allCategories,
        );
        final sortedSuggested = _viewModel.sortCategories(
          context,
          _viewModel.suggestedCategories,
        );

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
          child: _viewModel.isLoading
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
      },
    );
  }

  Future<void> _openAddCategoryModal(
    BuildContext context, {
    CategoryModel? categoryToEdit,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
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
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  child: AddCategoryView(categoryToEdit: categoryToEdit),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      final category = result['category'] as CategoryModel;
      final imageFile = result['imageFile'] as File?;

      if (categoryToEdit == null) {
        await _viewModel.addCategory(category, imageFile: imageFile);
      } else {
        await _viewModel.updateCategory(category, imageFile: imageFile);
      }
    }
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

                return _buildCategoryItem(context, item, isLastItem);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    CategoryModel item,
    bool isLastItem,
  ) {
    final File? imageFile = _viewModel.getRealImageFile(item.iconKey);
    final bool hasImage = imageFile != null;

    Widget rowContent = Container(
      color: Colors.transparent,
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
              color: item.color.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(30.r),
              image: hasImage
                  ? DecorationImage(
                      image: FileImage(File(item.iconKey)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: hasImage
                ? null
                : Icon(
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
              color: CupertinoTheme.of(context).textTheme.textStyle.color,
            ),
          ),
        ],
      ),
    );

    Widget interactiveWidget;

    if (item.isCustom) {
      interactiveWidget = Slidable(
        key: ValueKey(item.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.30,
          children: [
            CustomSlidableAction(
              onPressed: (context) =>
                  _openAddCategoryModal(context, categoryToEdit: item),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    CupertinoIcons.pencil,
                    size: 20.sp,
                    color: CupertinoTheme.of(context).textTheme.textStyle.color,
                  ),
                ),
              ),
            ),
            CustomSlidableAction(
              onPressed: (context) => _onDeleteCategory(context, item),
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
                    size: 14.sp,
                    color: AppColors.errorColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () => Navigator.pop(context, item),
          child: rowContent,
        ),
      );
    } else {
      interactiveWidget = GestureDetector(
        onTap: () => Navigator.pop(context, item),
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < -300) {
            _showSystemItemMessage(context);
          }
        },
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: rowContent,
        ),
      );
    }

    return Column(
      children: [
        interactiveWidget,
        if (!isLastItem)
          Divider(
            color: CupertinoColors.systemGrey.withValues(alpha: .3),
            height: 0.5.h,
          ),
      ],
    );
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
              await _viewModel.deleteCategory(category);
            },
          ),
        ],
      ),
    );
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
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        );
      },
    );
  }
}
