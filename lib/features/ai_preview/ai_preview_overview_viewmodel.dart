import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/features/transaction/add_transaction/add_transaction_viewmodel.dart';

class AIPreviewOverviewViewmodel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final AddTransactionViewmodel _addTransactionViewmodel = AddTransactionViewmodel();

  String _currencySymbol = '\$';
  String get currencySymbol => _currencySymbol;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> initData() async {
    await Future.wait([_loadCurrency()]);
  }

  Future<void> _loadCurrency() async {
    final Map<String, String> currencyData = await _storage.getCurrency();
    final String symbol = currencyData['symbol'] ?? '\$';
    _currencySymbol = symbol;
    notifyListeners();
  }
  String formatCurrency(double amount) {
    final format = NumberFormat("#,##0", "en_US");
    return "$_currencySymbol${format.format(amount)}";
  }

  Future<bool> saveBatchTransactions(
    List<TransactionModel> transactions,
  ) async {
    try {
      _isLoading = true;
      notifyListeners();

      for (var transaction in transactions) {
        if (transaction.isIncome) {
          await _addTransactionViewmodel.addIncomeTransaction(
            transaction.amount.toString(),
            transaction.title ,
            transaction.category,
            transaction.date,
            transaction.note,
            transaction.location,
          );
        } else {
          await _addTransactionViewmodel.addExpenseTransaction(
            transaction.amount.toString(),
            transaction.title,
            transaction.category,
            transaction.date,
            transaction.note,
            transaction.location,
          );
        }
      }

      return true; 
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
