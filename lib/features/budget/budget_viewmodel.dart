import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/features/budget/budget_model.dart';

class BudgetViewModel extends ChangeNotifier {
  final LocalStorageService _storageService = LocalStorageService();

  List<BudgetModel> budgets = [];

  DateTime selectedMonth = DateTime.now();

  String _currencySymbol = '\$';
  String get currencySymbol => _currencySymbol;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool get canEdit {
    final now = DateTime.now();
    final currentMonthStart = DateTime(now.year, now.month);
    final selectedMonthStart = DateTime(
      selectedMonth.year,
      selectedMonth.month,
    );

    return !selectedMonthStart.isBefore(currentMonthStart);
  }

  BudgetViewModel() {
    _initData();
  }

  Future<void> _initData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 300));

    try {
      await Future.wait([_loadCurrency(), _fetchBudgetsFromStorage()]);
    } catch (e) {
      debugPrint("Error initializing budget data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadCurrency() async {
    final Map<String, String> currencyData = await _storageService
        .getCurrency();
    _currencySymbol = currencyData['symbol'] ?? '\$';
  }

  Future<void> _fetchBudgetsFromStorage() async {
    _isLoading = true;
    notifyListeners();

    try {
      budgets = await _storageService.getBudgetsForMonth(selectedMonth);
    } catch (e) {
      debugPrint("Error loading budgets: $e");
      budgets = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBudget(BudgetModel budget) async {
    if (!canEdit) return;

    await _storageService.deleteBudget(budget.id);
    await _fetchBudgetsFromStorage();
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
    return "$_currencySymbol${format.format(amount)}";
  }

  Color getProgressBarColor(double progress) {
    if (progress >= 1.0) return Colors.red;
    if (progress >= 0.8) return Colors.orange;
    if (progress >= 0.5) return Colors.amber;
    return Colors.green;
  }

  void refreshData() {
    _fetchBudgetsFromStorage();
  }

  void nextMonth() {
    selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);
    _fetchBudgetsFromStorage();
  }

  void previousMonth() {
    selectedMonth = DateTime(selectedMonth.year, selectedMonth.month - 1);
    _fetchBudgetsFromStorage();
  }

  void setMonth(DateTime date) {
    selectedMonth = DateTime(date.year, date.month, 1);
    _fetchBudgetsFromStorage();
  }
}
