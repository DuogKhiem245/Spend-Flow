import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:spend_flow/core/model/category_model.dart';

class AIService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<Map<String, dynamic>> analyzeImage(
    String base64Image,
    List<CategoryModel> categories,
    String language,
  ) async {
    try {
      final simpleCategories = categories
          .map((e) => {'id': e.id, 'name': e.name})
          .toList();

      final result = await _functions
          .httpsCallable('analyzeReceiptImage')
          .call({
            'imageBase64': base64Image,
            'categories': simpleCategories,
            'language': language,
          });

      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> analyzeText(
    String text,
    List<CategoryModel> categories,
    String language,
  ) async {
    try {
      final simpleCategories = categories
          .map((e) => {'id': e.id, 'name': e.name})
          .toList();

      final result = await _functions
          .httpsCallable('analyzeTransactionText')
          .call({
            'text': text,
            'categories': simpleCategories,
            'language': language,
          });

      return Map<String, dynamic>.from(result.data['result']);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> analyzeTextCSVImport(
    String text,
    List<CategoryModel> categories,
    String language,
    List<String> availableWalletIds,
  ) async {
    try {
      final simpleCategories = categories
          .map((e) => {'id': e.id, 'name': e.name})
          .toList();

      final result = await _functions
          .httpsCallable('analyzeTransactionText')
          .call({
            'text': text,
            'categories': simpleCategories,
            'language': language,
          });

      final response = Map<String, dynamic>.from(result.data['result']);
      final data = response['data'] != null
          ? Map<String, dynamic>.from(response['data'])
          : null;

      if (data == null) return null;

      final dynamic aiCategoryId = data['categoryId'];
      final dynamic aiTitle = data['title'];
      final dynamic aiAmount = data['amount'];
      // final dynamic aiWalletId = data['walletId'];

      if (aiCategoryId == null ||
          aiTitle == null ||
          aiAmount == null) {
        debugPrint(
          "Bỏ qua: Thiếu thông tin bắt buộc (Cat: $aiCategoryId, Title: $aiTitle, Amt: $aiAmount",
        );
        return null;
      }

      // if (aiCategoryId == null ||
      //     aiTitle == null ||
      //     aiAmount == null ||
      //     aiWalletId == null) {
      //   debugPrint(
      //     "Bỏ qua: Thiếu thông tin bắt buộc (Cat: $aiCategoryId, Title: $aiTitle, Amt: $aiAmount, Wallet: $aiWalletId)",
      //   );
      //   return null;
      // }

      bool isCategoryValid = categories.any(
        (cat) => cat.id == aiCategoryId.toString(),
      );

      if (!isCategoryValid) {
        debugPrint("Bỏ qua: CategoryId [$aiCategoryId] không tồn tại.");
        return null;
      }

      // bool isWalletValid = availableWalletIds.contains(aiWalletId.toString());

      // if (!isWalletValid) {
      //   debugPrint(
      //     "Bỏ qua: WalletId [$aiWalletId] không tồn tại trong hệ thống.",
      //   );
      //   return null;
      // }

      return response;
    } catch (e) {
      debugPrint("Lỗi khi phân tích dòng CSV: $e");
      return null;
    }
  }
}
