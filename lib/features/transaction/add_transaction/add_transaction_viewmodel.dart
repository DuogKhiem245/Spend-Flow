import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import '../../../core/model/category_model.dart';

class AddTransactionViewmodel extends ChangeNotifier {
  final LocalStorageService _storageService = LocalStorageService();

  String _currencySymbol = '\$';
  String get currencySymbol => _currencySymbol;

  AddTransactionViewmodel() {
    _loadCurrency();
  }

  Future<void> _loadCurrency() async {
    final Map<String, String> currencyData = await _storageService
        .getCurrency();
    _currencySymbol = currencyData['symbol'] ?? '\$';
    notifyListeners();
  }

  Future<String?> _getCurrentWalletId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_wallet_id');
  }

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

    final walletId = await _getCurrentWalletId();

    if (walletId == null) {
      return;
    }

    debugPrint('Adding expense transaction with amount: $value');
    debugPrint('Wallet ID: $walletId');

    final transaction = TransactionModel(
      walletId: walletId, 
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

    final walletId = await _getCurrentWalletId();

    if (walletId == null) {
      return;
    }

    final transaction = TransactionModel(
      walletId: walletId, 
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
