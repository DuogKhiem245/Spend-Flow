import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/model/budget_model.dart';

class BudgetViewModel extends ChangeNotifier {
  final LocalStorageService _storageService = LocalStorageService();
  final LocalAuthentication _auth = LocalAuthentication();

  List<BudgetModel> budgets = [];

  DateTime selectedMonth = DateTime.now();

  String? _appDocumentsPath;

  String _currencySymbol = '\$';
  String get currencySymbol => _currencySymbol;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isLocked = true;
  bool get isLocked => _isLocked;

  bool _isFaceIdAvailable = false;
  bool get isFaceIdAvailable => _isFaceIdAvailable;

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
    _checkSecurity();
    _initData();
  }

  Future<void> _checkSecurity() async {
    final hasPasscode = await _storageService.hasPasscode();
    final faceEnabled = await _storageService.isFaceIdEnabled();

    _isFaceIdAvailable = faceEnabled && hasPasscode;

    if (!hasPasscode) {
      _isLocked = false;
    } else {
      _isLocked = true;
    }

    notifyListeners();

    if (_isLocked && _isFaceIdAvailable) {
      authenticateBiometric();
    }
  }

  Future<void> authenticateBiometric() async {
    if (!_isFaceIdAvailable) return;

    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Xác thực để xem báo cáo',
        biometricOnly: true,
        sensitiveTransaction: true,
      );

      if (didAuthenticate) {
        _isLocked = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error FaceID: $e");
    }
  }

  Future<bool> verifyPasscode(String inputCode) async {
    final savedCode = await _storageService.getPasscode();
    if (savedCode == inputCode) {
      _isLocked = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  void lockApp() {
    _storageService.hasPasscode().then((has) {
      if (has && !_isLocked) {
        _isLocked = true;
        notifyListeners();
      }
    });
  }

  Future<void> _initData() async {
    _isLoading = true;
    notifyListeners();

    final directory = await getApplicationDocumentsDirectory();
    _appDocumentsPath = directory.path;

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

  Future<String?> _getCurrentWalletId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_wallet_id');
  }

  Future<void> _fetchBudgetsFromStorage() async {
    _isLoading = true;
    notifyListeners();

    try {
      final walletId = await _getCurrentWalletId();

      if (walletId != null) {
        budgets = await _storageService.getBudgetsForMonth(
          selectedMonth,
          walletId,
        );
      } else {
        budgets = [];
        debugPrint("Warning: No wallet selected");
      }
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

  File? getRealImageFile(String iconKey) {
    if (_appDocumentsPath == null || iconKey.isEmpty) return null;

    if (!iconKey.contains('/')) {
      final file = File('$_appDocumentsPath/$iconKey');
      return file.existsSync() ? file : null;
    }

    final fileName = iconKey.split('/').last;
    final fixedFile = File('$_appDocumentsPath/$fileName');

    return fixedFile.existsSync() ? fixedFile : null;
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
