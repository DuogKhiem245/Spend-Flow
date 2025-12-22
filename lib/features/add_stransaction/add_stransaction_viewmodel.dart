import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import '../../core/model/category_model.dart';

class AddStransactionViewmodel {
  final LocalStorageService _storageService = LocalStorageService();

  Future<void> addExpenseTransaction(
    String amount,
    String name,
    CategoryModel? selectedCategory,
    DateTime? transactionDate,
    String note,
  ) async {
    if (selectedCategory == null) return;

    final double value = _parseAmount(amount);
    if (value == 0) return;

    final transaction = TransactionModel(
      amount: value.abs(),
      title: name.isEmpty ? selectedCategory.name : name,
      category: selectedCategory,
      date: transactionDate ?? DateTime.now(),
      note: note,
      isIncome: false,
    );

    await _storageService.addTransaction(transaction);
  }

  Future<void> addIncomeTransaction(
    String amount,
    String name,
    CategoryModel? selectedCategory,
    DateTime? transactionDate,
    String note,
  ) async {
    if (selectedCategory == null) return;

    final double value = _parseAmount(amount);
    if (value == 0) return;

    final transaction = TransactionModel(
      amount: value.abs(),
      title: name.isEmpty ? selectedCategory.name : name,
      category: selectedCategory,
      date: transactionDate ?? DateTime.now(),
      note: note,
      isIncome: true,
    );

    await _storageService.addTransaction(transaction);
  }

  double _parseAmount(String input) {
    if (input.isEmpty) return 0.0;

    String cleanString = input.replaceAll('.', '');

    cleanString = cleanString.replaceAll(',', '.');

    return double.tryParse(cleanString) ?? 0.0;
  }
}
