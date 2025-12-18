import 'package:flutter/material.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/features/add_stransaction/model/category_model.dart';
import 'package:spend_flow/features/budget/budget_model.dart';

class AddBudgetViewModel extends ChangeNotifier {
  final LocalStorageService _storageService = LocalStorageService();

  Future<void> saveBudget(String amountStr, CategoryModel? category) async {
    if (category == null) return;

    final double amount = _parseAmount(amountStr);
    if (amount <= 0) return;

    final newBudget = BudgetModel(category: category, total: amount, spent: 0);

    await _storageService.saveBudget(newBudget);
  }

  double _parseAmount(String input) {
    if (input.isEmpty) return 0.0;
    String cleanString = input.replaceAll('.', '');
    cleanString = cleanString.replaceAll(',', '.');
    return double.tryParse(cleanString) ?? 0.0;
  }
}
