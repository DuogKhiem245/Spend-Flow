import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/features/budget/budget_model.dart';

class BudgetViewModel extends ChangeNotifier {
  final LocalStorageService _storageService = LocalStorageService();

  List<BudgetModel> budgets = [];
  bool isLoading = true; 
  DateTime currentMonth = DateTime.now(); 

  BudgetViewModel() {
    loadBudgets();
  }

  Future<void> loadBudgets() async {
    isLoading = true;
    notifyListeners();

    try {
      budgets = await _storageService.getBudgetsForMonth(currentMonth);
    } catch (e) {
      debugPrint("Error loading budgets: $e");
      budgets = [];
    } finally {
      isLoading = false;
      notifyListeners(); 
    }
  }

  double get totalBudget => budgets.fold(0, (sum, item) => sum + item.total);
  double get totalSpent => budgets.fold(0, (sum, item) => sum + item.spent);

  double get totalRemaining {
    final remaining = totalBudget - totalSpent;
    return remaining < 0 ? 0 : remaining; 
  }

  double get totalProgress {
    if (totalBudget == 0) return 0.0;
    return (totalSpent / totalBudget).clamp(0.0, 1.0);
  }

  String formatCurrency(double amount) {
    final format = NumberFormat("#,##0", "en_US");
    return "\$${format.format(amount)}";
  }

  void refreshData() {
    loadBudgets();
  }
}
