import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';

class TransactionDetailViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  TransactionModel _transaction;
  TransactionModel get transaction => _transaction;

  String? _appDocumentsPath;
  String _currencySymbol = '\$';

  List<BarChartData> _spendingTrendData = [];
  List<BarChartData> get spendingTrendData => _spendingTrendData;

  bool _isLoadingChart = true;
  bool get isLoadingChart => _isLoadingChart;

  double _totalSpending7Days = 0;

  TransactionDetailViewModel({required TransactionModel transaction})
    : _transaction = transaction {
    _initPath();
    _loadCurrencySymbol();
  }

  void updateTransaction(TransactionModel updated, BuildContext context) {
    _transaction = updated;
    loadTrendData(context);
    notifyListeners();
  }

  File? get customImageFile {
    if (!_transaction.category.isCustom) return null;
    return getRealImageFile(_transaction.category.iconKey);
  }

  String get iconKey => _transaction.category.iconKey;

  bool get isCustomImage =>
      _transaction.category.isCustom && customImageFile != null;

  Color get categoryColor => _transaction.category.color;

  String get name => _transaction.title;
  String get categoryName => _transaction.category.name;
  String get note => _transaction.note;
  bool get hasNote => _transaction.note.isNotEmpty;

  bool get hasLocation =>
      _transaction.location.address != null &&
      _transaction.location.address!.isNotEmpty;

  String get locationAddress => _transaction.location.address ?? '';

  double get latitude => _transaction.location.latitude ?? 0.0;
  double get longitude => _transaction.location.longitude ?? 0.0;

  Color get amountColor =>
      _transaction.isIncome ? CupertinoColors.activeGreen : Colors.black;

  String getDateString(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    final now = DateTime.now();
    final date = _transaction.date;
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;

    final timeStr = DateFormat('h:mm a', locale).format(date);

    if (isToday) {
      return "${l10n.today}, $timeStr";
    }

    return DateFormat('MMM d, yyyy - h:mm a', locale).format(date);
  }

  Future<void> _initPath() async {
    final directory = await getApplicationDocumentsDirectory();
    _appDocumentsPath = directory.path;
    notifyListeners();
  }

  Future<void> _loadCurrencySymbol() async {
    final Map<String, String> currencyData = await _storage.getCurrency();
    _currencySymbol = currencyData['symbol'] ?? '\$';
    notifyListeners();
  }

  Future<String> loadCurrency() async {
    final Map<String, String> currencyData = await _storage.getCurrency();
    final String symbol = currencyData['symbol'] ?? '\$';
    return symbol;
  }

  File? getRealImageFile(String iconKey) {
    if (_appDocumentsPath == null || iconKey.isEmpty) return null;
    final fileName = iconKey.split('/').last;
    final file = File('$_appDocumentsPath/$fileName');
    return file.existsSync() ? file : null;
  }

  String totalSpending7DaysString (AppLocalizations l10n) {
    final format = NumberFormat("#,###", l10n.localeName);
    return " ${format.format(_totalSpending7Days)}";
  }

  bool _isSameCategory(CategoryModel a, CategoryModel b) {
    if (a.id == b.id) return true;
    if (a.l10nKey != null && b.l10nKey != null && a.l10nKey == b.l10nKey) {
      return true;
    }
    if (a.name.trim().isNotEmpty &&
        a.name.trim().toLowerCase() == b.name.trim().toLowerCase()) {
      return true;
    }
    return false;
  }

  Future<void> loadTrendData(BuildContext context) async {
    _isLoadingChart = true;
    notifyListeners();

    try {
      final l10n = AppLocalizations.of(context)!;

      // Chuẩn hóa ngày hiện tại và ngày của giao dịch về 00:00:00
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final targetDate = DateTime(
        _transaction.date.year,
        _transaction.date.month,
        _transaction.date.day,
      );

      // Số ngày từ ngày chọn tới hôm nay
      final daysUntilToday = today.difference(targetDate).inDays;

      // Số ngày sau ngày chọn: tối đa 3 ngày và không vượt quá ngày hiện tại (n ngày sau <= today)
      final afterDays = math.min(3, math.max(0, daysUntilToday));

      // Số ngày trước ngày chọn: 6 - n ngày trước để tổng cộng luôn là 7 ngày
      final beforeDays = 6 - afterDays;

      final startDate = targetDate.subtract(Duration(days: beforeDays));
      final endDate = targetDate.add(Duration(days: afterDays));

      // Tạo danh sách 7 ngày hiển thị
      final List<DateTime> chartDates = [];
      for (int i = 0; i < 7; i++) {
        chartDates.add(
          DateTime(startDate.year, startDate.month, startDate.day + i),
        );
      }

      // Xác định walletId hợp lệ
      String walletId = _transaction.walletId;
      if (walletId.isEmpty) {
        final prefs = await SharedPreferences.getInstance();
        walletId = prefs.getString('current_wallet_id') ?? '';
        if (walletId.isEmpty) {
          final wallets = await _storage.getAllWallets();
          if (wallets.isNotEmpty) {
            walletId = wallets.first.id;
          }
        }
      }

      // Lấy danh sách giao dịch của các tháng nằm trong khoảng
      final Map<String, TransactionModel> uniqueTransactions = {};

      final transactionsStartMonth = await _storage.getTransactionsByMonth(
        startDate,
        walletId,
      );
      for (var tx in transactionsStartMonth) {
        uniqueTransactions[tx.id] = tx;
      }

      if (startDate.year != endDate.year || startDate.month != endDate.month) {
        final transactionsEndMonth = await _storage.getTransactionsByMonth(
          endDate,
          walletId,
        );
        for (var tx in transactionsEndMonth) {
          uniqueTransactions[tx.id] = tx;
        }
      }

      final List<TransactionModel> allTransactions =
          uniqueTransactions.values.toList();

      // Đảm bảo giao dịch chi tiêu hiện tại có trong danh sách
      if (!_transaction.isIncome &&
          !allTransactions.any((tx) => tx.id == _transaction.id)) {
        allTransactions.add(_transaction);
      }

      final Map<String, double> dailyTotals = {};
      for (var date in chartDates) {
        final key = DateFormat('yyyyMMdd').format(date);
        dailyTotals[key] = 0.0;
      }

      double tempTotal7Days = 0;

      for (var tx in allTransactions) {
        if (!tx.isIncome &&
            _isSameCategory(tx.category, _transaction.category)) {
          final key = DateFormat('yyyyMMdd').format(tx.date);
          if (dailyTotals.containsKey(key)) {
            dailyTotals[key] = (dailyTotals[key] ?? 0) + tx.amount;
            tempTotal7Days += tx.amount;
          }
        }
      }

      _totalSpending7Days = tempTotal7Days;

      double maxSpending = 0;
      if (dailyTotals.isNotEmpty) {
        maxSpending = dailyTotals.values.reduce((a, b) => a > b ? a : b);
      }
      if (maxSpending == 0) maxSpending = 1;

      final List<BarChartData> result = [];
      final targetKey = DateFormat('yyyyMMdd').format(targetDate);
      final todayKey = DateFormat('yyyyMMdd').format(today);

      for (var date in chartDates) {
        final key = DateFormat('yyyyMMdd').format(date);
        final amount = dailyTotals[key] ?? 0;

        String label;
        if (key == todayKey) {
          label = l10n.today;
        } else {
          label = DateFormat('d/M').format(date);
        }

        final isCurrentTxDay = (key == targetKey);
        result.add(BarChartData(label, amount / maxSpending, isCurrentTxDay));
      }

      _spendingTrendData = result;
    } catch (e) {
      debugPrint("Error loading chart data: $e");
    } finally {
      _isLoadingChart = false;
      notifyListeners();
    }
  }

  String amountString(AppLocalizations l10n) {
    final formattedAmount = _formatCompactCurrency(_transaction.amount, l10n);
    final sign = _transaction.isIncome ? "+" : "-";
    return "$sign $_currencySymbol $formattedAmount"; // Use cached symbol
  }

  String _formatCompactCurrency(double amount, AppLocalizations l10n) {
    final formatter = NumberFormat.compactCurrency(
      locale: l10n.localeName,
      decimalDigits: 1,
      symbol: '',
    );
    return formatter.format(amount);
  }
}

class BarChartData {
  final String label;
  final double percent;
  final bool isActive;
  BarChartData(this.label, this.percent, this.isActive);
}
