import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/utils/category_helper.dart';
import 'package:spend_flow/core/utils/vietnamese_utils.dart';

class CategoryViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();

  List<CategoryModel> _allCategories = [];
  List<CategoryModel> _suggestedCategories = [];
  bool _isLoading = true;

  String? _appDocumentsPath;

  List<CategoryModel> get allCategories => _allCategories;
  List<CategoryModel> get suggestedCategories => _suggestedCategories;
  bool get isLoading => _isLoading;

  CategoryViewModel() {
    loadData();
  }

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final directory = await getApplicationDocumentsDirectory();
      _appDocumentsPath = directory.path;

      final all = await _storage.getAllCategories();
      final suggested = await _storage.getSmartSuggestions();

      _allCategories = all;
      _suggestedCategories = suggested;
    } catch (e) {
      debugPrint("Error loading categories: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  File? getRealImageFile(String iconKey) {
    if (_appDocumentsPath == null || iconKey.isEmpty) return null;

    if (!iconKey.contains('/')) {
      final file = File('$_appDocumentsPath/$iconKey');
      return file.existsSync() ? file : null;
    }

    final fileName = iconKey.split('/').last; 
    final fixedFile = File('$_appDocumentsPath/$fileName');

    return fixedFile.existsSync() ? fixedFile : null;
  }

  Future<String> _saveImagePermanently(File imageFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'cat_${DateTime.now().millisecondsSinceEpoch}.png';
      final String newPath = '${directory.path}/$fileName';

      await imageFile.copy(newPath);

      return fileName;
    } catch (e) {
      debugPrint("Error saving image: $e");
      return imageFile.path.split('/').last;
    }
  }

  Future<void> addCategory(CategoryModel category, {File? imageFile}) async {
    CategoryModel finalCategory = category;

    if (imageFile != null) {
      final savedFileName = await _saveImagePermanently(imageFile);
      finalCategory = category.copyWith(iconKey: savedFileName);
    }

    await _storage.addCategory(finalCategory);
    await loadData();
  }

  Future<void> updateCategory(CategoryModel category, {File? imageFile}) async {
    CategoryModel finalCategory = category;

    if (imageFile != null) {
      final savedFileName = await _saveImagePermanently(imageFile);
      finalCategory = category.copyWith(iconKey: savedFileName);
    }

    await _storage.updateCategory(finalCategory);
    await loadData();
  }

    Future<void> deleteCategory(CategoryModel category) async {
    await _storage.deleteCategory(category);
    await loadData();
  }

  List<CategoryModel> sortCategories(
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
}
