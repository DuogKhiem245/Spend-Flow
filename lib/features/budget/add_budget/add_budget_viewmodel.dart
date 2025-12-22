import 'package:flutter/material.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/features/budget/budget_model.dart';

class AddBudgetViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();

  Future<void> saveBudget({
    required String amount,
    required CategoryModel category,
    required DateTime date,
    String? idToUpdate, 
  }) async {
    final double parsedAmount = _parseAmount(amount);

    if (idToUpdate != null) {
      final updatedBudget = BudgetModel(
        id: idToUpdate, 
        category: category,
        total: parsedAmount,
        spent: 0, 
        date: date,
      );
      
      await _storage.updateBudget(updatedBudget);

    } else {

      final newBudget = BudgetModel(
        id: UniqueKey().toString(), 
        category: category,
        total: parsedAmount,
        spent: 0,
        date: date,
      );
      
      await _storage.saveBudget(newBudget);
    }
  }

  double _parseAmount(String input) {
    if (input.isEmpty) return 0.0;
    String cleanString = input.replaceAll('.', '');
    cleanString = cleanString.replaceAll(',', '.');
    return double.tryParse(cleanString) ?? 0.0;
  }
}
