import 'package:cloud_functions/cloud_functions.dart';
import 'package:spend_flow/core/model/category_model.dart';

class AIService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<Map<String, dynamic>> analyzeImage(
    String base64Image,
    List<CategoryModel> categories,
  ) async {
    try {
      final simpleCategories = categories
          .map((e) => {'id': e.id, 'name': e.name})
          .toList();

      final result = await _functions.httpsCallable('analyzeReceiptImage').call(
        {'imageBase64': base64Image, 'categories': simpleCategories},
      );

      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> analyzeText(
    String text,
    List<CategoryModel> categories,
  ) async {
    try {
      final simpleCategories = categories
          .map((e) => {'id': e.id, 'name': e.name})
          .toList();

      final result = await _functions
          .httpsCallable('analyzeTransactionText')
          .call({'text': text, 'categories': simpleCategories});

      return Map<String, dynamic>.from(result.data);
    } catch (e) {
      rethrow;
    }
  }
}
