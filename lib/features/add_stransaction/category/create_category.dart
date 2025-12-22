import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/model/category_model.dart';

class AddCategoryPage extends StatefulWidget {
  final CategoryModel? categoryToEdit;

  const AddCategoryPage({super.key, this.categoryToEdit});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController _nameController = TextEditingController();

  Color _selectedColor = Colors.orange;
  String _selectedIconKey = 'food';

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  final List<Color> _colors = [
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.pink,
    Colors.red,
    Colors.teal,
    Colors.brown,
    Colors.amber,
    Colors.indigo,
    Colors.grey,
    Colors.black,
  ];

  final List<String> _iconKeys = [
    'food',
    'transport',
    'salary',
    'shopping',
    'game',
    'house',
    'bill',
    'health',
    'education',
    'pet',
    'travel',
    'repair',
    'water',
    'electricity',
    'internet',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.categoryToEdit != null) {
      final item = widget.categoryToEdit!;
      _nameController.text = item.name;
      _selectedColor = item.color;

      if (_iconKeys.contains(item.iconKey)) {
        _selectedIconKey = item.iconKey;
      } else {
        _selectedIconKey = item.iconKey;
      }
    }

    _nameController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final primaryColor = CupertinoTheme.of(context).primaryColor;

    final String pageTitle = widget.categoryToEdit != null
        ? l10n.edit_category
        : l10n.new_category;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(end: 10.w),
        leading: CupertinoNavigationBarBackButton(
          color: primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          pageTitle,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(
            l10n.save,
            style: TextStyle(
              color: primaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            if (_nameController.text.isEmpty) return;

            final newCategory = CategoryModel(
              id: widget.categoryToEdit?.id ?? UniqueKey().toString(),

              name: _nameController.text,
              l10nKey: null,
              iconKey: _pickedImage != null
                  ? '${_nameController.text}_img'
                  : _selectedIconKey,
              color: _selectedColor,
              isCustom: true,
            );

            Navigator.pop(context, newCategory);
          },
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: _selectedColor.withValues(alpha: .2),
                  shape: BoxShape.circle,
                  image: _pickedImage != null
                      ? DecorationImage(
                          image: FileImage(_pickedImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _pickedImage == null
                    ? Icon(
                        AppIcons.getIcon(_selectedIconKey),
                        size: 50.w,
                        color: _selectedColor,
                      )
                    : null,
              ),

              SizedBox(height: 30.h),

              _buildSectionTitle(l10n.category_name),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: CupertinoTextField(
                  controller: _nameController,
                  placeholder: l10n.category_name,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  decoration: null,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: CupertinoColors.label,
                  ),
                  suffix: _nameController.text.isNotEmpty
                      ? CupertinoButton(
                          padding: EdgeInsets.only(right: 12.w),
                          onPressed: () => _nameController.clear(),
                          child: Icon(
                            CupertinoIcons.clear_circled_solid,
                            color: CupertinoColors.systemGrey,
                            size: 20.w,
                          ),
                        )
                      : null,
                ),
              ),

              SizedBox(height: 20.h),

              _buildSectionTitle(l10n.category_color),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Wrap(
                  spacing: 14.w,
                  runSpacing: 14.h,
                  alignment: WrapAlignment.start,
                  children: _colors.map((color) {
                    final isSelected = _selectedColor.value == color.value;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedColor = color),
                      child: Container(
                        width: 44.w,
                        height: 44.w,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(color: color, width: 2.5)
                              : null,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 20.h),

              _buildSectionTitle(l10n.category_icon),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Wrap(
                  spacing: 14.w,
                  runSpacing: 14.h,
                  alignment: WrapAlignment.start,
                  children: [
                    ..._iconKeys.map((key) {
                      final isSelected =
                          _selectedIconKey == key && _pickedImage == null;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIconKey = key;
                            _pickedImage = null;
                          });
                        },
                        child: Container(
                          width: 48.w,
                          height: 48.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor.withValues(alpha: .2)
                                : CupertinoColors.systemGrey6,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            AppIcons.getIcon(key),
                            color: isSelected
                                ? AppColors.primaryColor
                                : CupertinoColors.systemGrey,
                            size: 24.w,
                          ),
                        ),
                      );
                    }),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _pickedImage != null
                              ? AppColors.primaryColor.withValues(alpha: .2)
                              : CupertinoColors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _pickedImage != null
                                ? AppColors.primaryColor
                                : CupertinoColors.systemGrey,
                          ),
                        ),
                        child: Icon(
                          CupertinoIcons.photo_fill_on_rectangle_fill,
                          color: _pickedImage != null
                              ? AppColors.primaryColor
                              : CupertinoColors.systemGrey,
                          size: 24.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, bottom: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: CupertinoTheme.of(
              context,
            ).textTheme.textStyle.color?.withValues(alpha: .7),
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
