import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:spend_flow/core/model/category_model.dart';

class AIService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  List<Map<String, String>> _formatCategories(List<CategoryModel> categories) {
    return categories.map((e) => {'id': e.id, 'name': e.name}).toList();
  }

  Future<Map<String, dynamic>> analyzeImage(
    String base64Image,
    List<CategoryModel> categories,
    String language,
  ) async {
    try { 
      final result = await _functions
          .httpsCallable('analyzeReceiptImage')
          .call({
            'imageBase64': base64Image,
            'categories': _formatCategories(categories),
            'language': language,
          });
      return Map<String, dynamic>.from(result.data['result']);
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
      final result = await _functions
          .httpsCallable('analyzeTransactionText')
          .call({
            'text': text,
            'categories': _formatCategories(categories),
            'language': language,
          });

      return Map<String, dynamic>.from(result.data['result']);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> analyzeTextCSVImport(
    String text,
    List<CategoryModel> categories,
    String language,
  ) async {
    try {
      final result = await _functions
          .httpsCallable('analyzeTransactionText')
          .call({
            'text': text,
            'categories': _formatCategories(categories),
            'language': language,
          });

      final response = Map<String, dynamic>.from(result.data['result']);
      final List resultsRaw = response['results'] ?? [];

      List<Map<String, dynamic>> validResults = [];

      for (var item in resultsRaw) {
        final Map<String, dynamic> itemMap = Map<String, dynamic>.from(
          item as Map,
        );

        if (itemMap['actionType'] == "TRANSACTION") {
          final dataRaw = itemMap['data'];
          if (dataRaw != null) {
            final data = Map<String, dynamic>.from(
              dataRaw as Map,
            ); 

            if (data['categoryId'] != null && data['amount'] != null) {
              bool isCategoryValid = categories.any(
                (cat) => cat.id == data['categoryId'].toString(),
              );
              if (isCategoryValid) {
                validResults.add(itemMap);
              }
            }
          }
        }
      }
      return validResults;
    } catch (e) {
      debugPrint("Lỗi khi phân tích dòng CSV: $e");
      return [];
    }
  }
}
