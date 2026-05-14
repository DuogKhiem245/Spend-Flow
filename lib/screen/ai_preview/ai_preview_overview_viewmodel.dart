import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/screen/transaction/add_transaction/add_transaction_viewmodel.dart';

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
        final String cleanAmount = transaction.amount.toStringAsFixed(0);
        if (transaction.isIncome) {
          await _addTransactionViewmodel.addIncomeTransaction(
            cleanAmount,
            transaction.title ,
            transaction.category,
            transaction.date,
            transaction.note,
            transaction.location,
          );
        } else {
          await _addTransactionViewmodel.addExpenseTransaction(
            cleanAmount,
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
