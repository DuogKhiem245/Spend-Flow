import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/config/app_colors.dart';
import 'package:spend_flow/config/app_icons.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/services/ads_service.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';
import 'package:spend_flow/main.dart';

class AddCategoryView extends StatefulWidget {
  final CategoryModel? categoryToEdit;

  const AddCategoryView({super.key, this.categoryToEdit});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  final TextEditingController _nameController = TextEditingController();

  final AdsService _adsService = AdsService();
  final _premiumViewModel = premiumViewModel;

  Color _selectedColor = Colors.orange;
  String _selectedIconKey = 'food';

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  final List<Color> _colors = CategoryData.colors;
  final List<String> _iconKeys = CategoryData.iconKeys;

  @override
  void initState() {
    super.initState();
    _initData();

    _adsService.loadInterstitialAd();

    _nameController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _initData() async {
    if (widget.categoryToEdit != null) {
      final item = widget.categoryToEdit!;
      _nameController.text = item.name;
      _selectedColor = item.color;

      if (item.isCustom) {
        final directory = await getApplicationDocumentsDirectory();

        final fileName = item.iconKey.split('/').last;
        final fullPath = '${directory.path}/$fileName';
        final file = File(fullPath);

        if (await file.exists()) {
          setState(() {
            _pickedImage = file;
            _selectedIconKey = '';
          });
        } else {
          setState(() {
            _selectedIconKey = item.iconKey;
            _pickedImage = null;
          });
        }
      } else {
        setState(() {
          _selectedIconKey = item.iconKey;
          _pickedImage = null;
        });
      }
    }
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
          onPressed: () async {
            List<String> missingFields = [];

            if (_nameController.text.isEmpty) {
              missingFields.add(l10n.category_name);
            }
            if (missingFields.isNotEmpty) {
              CheckValidWidget.showIncompleteDetailsSheet(
                context: context,
                title: l10n.incomplete_details,
                description: l10n.please_fill_required_fields,
                missingFields: missingFields,
                buttonText: "OK",
              );
              return;
            }

            final newCategory = CategoryModel(
              id: widget.categoryToEdit?.id ?? UniqueKey().toString(),
              name: _nameController.text,
              l10nKey: null,
              iconKey: _pickedImage != null ? '' : _selectedIconKey,
              color: _selectedColor,
              isCustom: true,
            );
            if (_pickedImage != null) {
              if (_premiumViewModel.isPremium) {
                Navigator.pop(context, {
                  'category': newCategory,
                  'imageFile': _pickedImage,
                });
              } else {
                await _adsService.showInterstitialWithFrequency(
                  () {},
                  isPremium: _premiumViewModel.isPremium,
                  onAdClosed: () {
                    Navigator.pop(context, {
                      'category': newCategory,
                      'imageFile': _pickedImage,
                    });
                  },
                );
              }
            } else {
              Navigator.pop(context, {
                'category': newCategory,
                'imageFile': null,
              });
            }
            
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
              _buildColorPicker(),

              SizedBox(height: 20.h),
              _buildSectionTitle(l10n.category_icon),
              _buildIconPicker(),
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

  Widget _buildColorPicker() {
    return Container(
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
          final isSelected = _selectedColor == color;
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
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildIconPicker() {
    return Container(
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
            final isSelected = _selectedIconKey == key && _pickedImage == null;
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
    );
  }
}
