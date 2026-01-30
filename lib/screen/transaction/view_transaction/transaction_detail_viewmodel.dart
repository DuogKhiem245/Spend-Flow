import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';

class TransactionDetailViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final TransactionModel _transaction;

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

  String get amountString {
    final formattedAmount = _formatCompactCurrency(_transaction.amount);
    final sign = _transaction.isIncome ? "+" : "-";
    return "$sign $_currencySymbol $formattedAmount"; // Use cached symbol
  }

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

  String get totalSpending7DaysString {
    final format = NumberFormat("#,##0.00", "en_US");
    return " ${format.format(_totalSpending7Days)}";
  }

  Future<void> loadTrendData(BuildContext context) async {
    _isLoadingChart = true;
    notifyListeners();

    try {
      final l10n = AppLocalizations.of(context)!;

      final endDate = _transaction.date;
      final startDate = endDate.subtract(const Duration(days: 6));

      final transactionsStartMonth = await _storage.getTransactionsByMonth(
        startDate,
        _transaction.walletId,
      );
      List<TransactionModel> allTransactions = [...transactionsStartMonth];
      if (startDate.month != endDate.month) {
        final transactionsEndMonth = await _storage.getTransactionsByMonth(
          endDate,
          _transaction.walletId,
        );
        allTransactions.addAll(transactionsEndMonth);
      }

      Map<String, double> dailyTotals = {};

      double tempTotal7Days = 0;

      for (int i = 0; i < 7; i++) {
        final date = startDate.add(Duration(days: i));
        final key = DateFormat('yyyyMMdd').format(date);
        dailyTotals[key] = 0.0;
      }
      for (var tx in allTransactions) {
        if (!tx.isIncome && tx.category.id == _transaction.category.id) {
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

      List<BarChartData> result = [];
      final now = DateTime.now();

      for (int i = 0; i < 7; i++) {
        final date = startDate.add(Duration(days: i));
        final key = DateFormat('yyyyMMdd').format(date);
        final amount = dailyTotals[key] ?? 0;

        String label;

        final isRealToday =
            date.year == now.year &&
            date.month == now.month &&
            date.day == now.day;

        if (isRealToday) {
          label = l10n.today;
        } else {
          label = DateFormat('d/M').format(date);
        }

        final isCurrentTxDay =
            DateFormat('yyyyMMdd').format(date) ==
            DateFormat('yyyyMMdd').format(_transaction.date);

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

  String _formatCompactCurrency(double amount) {
    final formatter = NumberFormat.compactCurrency(
      locale: "en_US",
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
