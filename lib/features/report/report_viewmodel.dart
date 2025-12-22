import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/local_storage_service.dart'; // Import service
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/features/report/daily_group_model.dart';

class ReportViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final LocalAuthentication _auth = LocalAuthentication();

  DateTime selectedMonth = DateTime.now();
  List<TransactionModel> _transactions = [];

  bool _isLocked = true;
  bool _isFaceIdAvailable = false;

  bool get isLocked => _isLocked;
  bool get isFaceIdAvailable => _isFaceIdAvailable;

  ReportViewModel() {
    loadData();
    _checkSecurity();
  }

  Future<void> _checkSecurity() async {
    final hasPasscode = await _storage.hasPasscode();
    final faceEnabled = await _storage.isFaceIdEnabled();

    _isFaceIdAvailable = faceEnabled && hasPasscode;

    if (!hasPasscode) {
      _isLocked = false;
      notifyListeners();
    } else {
      _isLocked = true;
      notifyListeners();

      if (_isFaceIdAvailable) {
        authenticateBiometric();
      }
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
      debugPrint("Lỗi FaceID: $e");
    }
  }

  Future<bool> verifyPasscode(String inputCode) async {
    final savedCode = await _storage.getPasscode();
    if (savedCode == inputCode) {
      _isLocked = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> loadData() async {
    final data = await _storage.getTransactionsByMonth(selectedMonth);

    data.sort((a, b) => b.date.compareTo(a.date));

    _transactions = data;
    notifyListeners();
  }

  List<DailyGroup> getGroupedTransactions() {
    final Map<String, List<TransactionModel>> groups = {};

    for (var tx in _transactions) {
      final dateKey = DateFormat('yyyy-MM-dd').format(tx.date);

      if (!groups.containsKey(dateKey)) {
        groups[dateKey] = [];
      }
      groups[dateKey]!.add(tx);
    }

    return groups.entries.map((e) {
      return DailyGroup(DateTime.parse(e.key), e.value);
    }).toList();
  }

  Map<String, double> getSummaryStats() {
    double income = 0;
    double expense = 0;

    for (var tx in _transactions) {
      if (tx.isIncome) {
        income += tx.amount;
      } else {
        expense += tx.amount;
      }
    }

    return {'income': income, 'expense': expense, 'balance': income - expense};
  }

  void nextMonth() {
    selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);
    loadData(); 
    notifyListeners();
  }

  void previousMonth() {
    selectedMonth = DateTime(selectedMonth.year, selectedMonth.month - 1);
    loadData();
    notifyListeners();
  }

  String formatCurrency(double amount) {
    final format = NumberFormat("#,##0.00", "en_US");
    return "\$${format.format(amount)}";
  }

  String formatDateHeader(DateTime date, AppLocalizations l10n, String locale) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final checkDate = DateTime(date.year, date.month, date.day);

    final diff = today.difference(checkDate).inDays;

    String prefix = "";
    if (diff == 0) {
      prefix = "${l10n.today}, ";
    } else if (diff == 1) {
      prefix = "${l10n.yesterday}, ";
    }

    String pattern = 'MMMM d';
    if (locale.startsWith('vi')) {
      pattern = 'd MMMM';
    }

    final dateString = DateFormat(pattern, locale).format(date);
    return "$prefix${toBeginningOfSentenceCase(dateString)}";
  }

  void setMonth(DateTime date) {
    selectedMonth = DateTime(date.year, date.month, 1);
    loadData(); 
    notifyListeners();
  }

  String formatTime(DateTime date) => DateFormat('h:mm a').format(date);
  String formatMonthYear() => DateFormat('MMMM\nyyyy').format(selectedMonth);
}
