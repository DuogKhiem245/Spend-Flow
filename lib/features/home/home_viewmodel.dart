import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/features/home/home_model.dart';

class HomeViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final LocalAuthentication _auth = LocalAuthentication();

  User? get currentUser => FirebaseAuth.instance.currentUser;

  bool _isLocked = false;
  bool _hasSecurity = false;
  bool _isFaceIdAvailable = false;

  bool get isLocked => _isLocked;
  bool get hasSecurity => _hasSecurity;
  bool get isFaceIdAvailable => _isFaceIdAvailable;

  HomeViewModel() {
    _checkSecurity();
  }

  Future<void> _checkSecurity() async {
    final hasPasscode = await _storage.hasPasscode();
    final faceEnabled = await _storage.isFaceIdEnabled();

    _hasSecurity = hasPasscode;

    _isFaceIdAvailable = hasPasscode && faceEnabled;

    if (hasPasscode) {
      _isLocked = true;
      notifyListeners();
    }
  }

  Future<bool> authenticateBiometric() async {
    if (!_isFaceIdAvailable) return false;

    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Xác thực để xem giao dịch',
        biometricOnly: true,
        sensitiveTransaction: true,
      );

      if (didAuthenticate) {
        _isLocked = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint("Lỗi Auth: $e");
    }
    return false;
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

  String getGreetingMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return l10n.good_morning;
    } else if (hour >= 12 && hour < 18) {
      return l10n.good_afternoon;
    } else if (hour >= 18 || hour < 5) {
      return l10n.good_evening;
    } else {
      return l10n.hello;
    }
  }

  String formatCurrency(double amount) {
    final formatter = NumberFormat("#,##0.0", "en_US");
    return formatter.format(amount);
  }

  String formatCompactCurrency(double amount) {
    final formatter = NumberFormat.compactCurrency(
      locale: "en_US",
      decimalDigits: 1,
      symbol: '',
    );
    return formatter.format(amount);
  }

  double calculateTotalSpent(List<SpendingModel> data) {
    return data.fold(0, (sum, item) => sum + item.amount);
  }

  Map<String, List<TransactionModel>> groupTransactionsByDate(
    List<TransactionModel> list,
  ) {
    final Map<String, List<TransactionModel>> groups = {};
    for (var tx in list) {
      final dateKey = formatDate(tx.date);
      if (!groups.containsKey(dateKey)) {
        groups[dateKey] = [];
      }
      groups[dateKey]!.add(tx);
    }
    return groups;
  }

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final checkDate = DateTime(date.year, date.month, date.day);

    if (checkDate == today) return "Today";
    if (checkDate == yesterday) return "Yesterday";
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String formatHours(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  Future<Map<String, double>> getCurrentMonthStats() async {
    final now = DateTime.now();

    final transactions = await _storage.getTransactionsByMonth(now);

    double income = 0;
    double expenses = 0;

    for (var tx in transactions) {
      if (tx.isIncome) {
        income += tx.amount;
      } else {
        expenses += tx.amount;
      }
    }

    double balance = income - expenses;

    return {'income': income, 'expenses': expenses, 'balance': balance};
  }

  Future<List<SpendingModel>> getChartData() async {
    final now = DateTime.now();
    final transactions = await _storage.getTransactionsByMonth(now);

    final Map<String, double> categorySpending = {};
    final Map<String, CategoryModel> categoryObjects = {};

    for (var tx in transactions) {
      if (tx.isIncome == false) {
        final amount = tx.amount.abs();
        final catName = tx.category.name;

        categorySpending[catName] = (categorySpending[catName] ?? 0) + amount;

        if (!categoryObjects.containsKey(catName)) {
          categoryObjects[catName] = tx.category;
        }
      }
    }

    List<SpendingModel> allSpending = categorySpending.entries.map((e) {
      final catModel = categoryObjects[e.key];
      return SpendingModel(
        category: e.key,
        amount: e.value,
        color: catModel?.color ?? CupertinoColors.systemGrey,
        originalCategory: catModel,
      );
    }).toList();

    allSpending.sort((a, b) => b.amount.compareTo(a.amount));

    if (allSpending.length <= 4) {
      return allSpending;
    }

    final top4 = allSpending.sublist(0, 4);
    final others = allSpending.sublist(4);

    double otherTotal = 0;
    for (var item in others) {
      otherTotal += item.amount;
    }

    top4.add(
      SpendingModel(
        category: "Other",
        amount: otherTotal,
        color: CupertinoColors.systemGrey,
        originalCategory: null,
      ),
    );

    return top4;
  }

  Future<List<SpendingModel>> getAllChartData() async {
    final now = DateTime.now();
    final transactions = await _storage.getTransactionsByMonth(now);

    final Map<String, double> categorySpending = {};
    final Map<String, CategoryModel> categoryObjects = {};

    for (var tx in transactions) {
      if (tx.isIncome == false) {
        final amount = tx.amount.abs();
        final catName = tx.category.name;

        categorySpending[catName] = (categorySpending[catName] ?? 0) + amount;

        if (!categoryObjects.containsKey(catName)) {
          categoryObjects[catName] = tx.category;
        }
      }
    }

    List<SpendingModel> allSpending = categorySpending.entries.map((e) {
      final catModel = categoryObjects[e.key];
      return SpendingModel(
        category: e.key,
        amount: e.value,
        color: catModel?.color ?? CupertinoColors.systemGrey,
        originalCategory: catModel,
      );
    }).toList();

    allSpending.sort((a, b) => b.amount.compareTo(a.amount));

    return allSpending;
  }

  List<PieChartSectionData> generateChartSections(
    List<SpendingModel> data,
    int touchedIndex,
    BuildContext context,
  ) {
    return data.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;
      final isTouched = i == touchedIndex;
      final fontSize = 15.0.sp;
      final radius = isTouched ? 45.0.w : 35.0.w;

      return PieChartSectionData(
        color: item.color,
        value: item.amount,
        title: isTouched ? '\$${formatCurrency(item.amount)}' : '',
        radius: radius,
        titleStyle: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
        ),
      );
    }).toList();
  }

  Future<List<TransactionModel>> getRecentTransactionsList() async {
    final all = await _storage.getAllTransactions();

    if (all.length > 5) {
      return all.sublist(0, 5);
    }

    return all;
  }

  Future<List<TransactionModel>> getTransactionsForCurrentMonth() async {
    final now = DateTime.now();
    final transactions = await _storage.getTransactionsByMonth(now);

    transactions.sort((a, b) => b.date.compareTo(a.date));

    return transactions;
  }

  Future<double> calculateSpendingChange() async {
    final now = DateTime.now();
    final lastMonthDate = DateTime(now.year, now.month - 1);

    final currentTrans = await _storage.getTransactionsByMonth(now);
    final lastMonthTrans = await _storage.getTransactionsByMonth(lastMonthDate);

    double currentSpent = 0;
    for (var t in currentTrans) {
      if (!t.isIncome) currentSpent += t.amount;
    }

    double lastSpent = 0;
    for (var t in lastMonthTrans) {
      if (!t.isIncome) lastSpent += t.amount;
    }

    if (lastSpent == 0) {
      return currentSpent > 0 ? 100.0 : 0.0;
    }

    return ((currentSpent - lastSpent) / lastSpent) * 100;
  }
}
