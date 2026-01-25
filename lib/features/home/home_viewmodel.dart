import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/model/wallet_model.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/general_service/notification_service.dart';
import 'package:spend_flow/core/services/sync_service/sync_service.dart';
import 'package:spend_flow/core/utils/category_helper.dart';
import 'package:spend_flow/features/home/home_model.dart';

class HomeViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final LocalAuthentication _auth = LocalAuthentication();
  final NotificationService notificationService = NotificationService();

  User? get currentUser => FirebaseAuth.instance.currentUser;

  String? _appDocumentsPath;

  bool _isLocked = true;
  bool _hasSecurity = false;
  bool _isFaceIdAvailable = false;

  bool get isLocked => _isLocked;
  bool get hasSecurity => _hasSecurity;
  bool get isFaceIdAvailable => _isFaceIdAvailable;

  String _currencySymbol = '\$';
  String get currencySymbol => _currencySymbol;

  String? _currentWalletId;
  String? get currentWalletId => _currentWalletId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<WalletModel> _wallets = [];
  List<WalletModel> get wallets => _wallets;

  double _income = 0;
  double _expenses = 0;
  double _balance = 0;
  List<SpendingModel> _chartData = [];
  List<TransactionModel> _recentTransactions = [];

  double get income => _income;
  double get expenses => _expenses;
  double get balance => _balance;
  List<SpendingModel> get chartData => _chartData;
  List<TransactionModel> get recentTransactions => _recentTransactions;

  Future<void> initData() async {
    _isLoading = true;
    notifyListeners();

    await notificationService.requestPermissions();

    initializeImage();

    final prefs = await SharedPreferences.getInstance();
    _currentWalletId = prefs.getString('current_wallet_id');

    await Future.wait([_checkSecurity(), _loadCurrency(), _loadWallets()]);

    await reloadData();
  }

  Future<void> initializeImage() async {
    final directory = await getApplicationDocumentsDirectory();
    _appDocumentsPath = directory.path;
  }

  Future<void> reloadData() async {
    await _loadWallets();

    final walletId = await _ensureWalletId();
    if (walletId == null) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      await Future.wait([
        _fetchMonthStats(walletId),
        _fetchChartData(walletId),
        _fetchRecentTransactions(walletId),
      ]);
      SyncService().syncData();
    } catch (e) {
      debugPrint("Error reloading data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _checkSecurity() async {
    final hasPasscode = await _storage.hasPasscode();
    final faceEnabled = await _storage.isFaceIdEnabled();

    _hasSecurity = hasPasscode;

    _isFaceIdAvailable = hasPasscode && faceEnabled;

    if (hasPasscode) {
      _isLocked = true;
    } else {
      _isLocked = false;
    }
    Future.microtask(() => notifyListeners());
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
      debugPrint("Error Auth: $e");
    }
    return false;
  }

  Future<bool> verifyPasscode(String inputCode) async {
    final savedCode = await _storage.getPasscode();
    if (savedCode == inputCode) {
      _isLocked = false;
      Future.microtask(() => notifyListeners());
      return true;
    }
    return false;
  }

  void lockApp() {
    if (_hasSecurity) {
      _isLocked = true;
      Future.microtask(() => notifyListeners());
    } else {
      _isLocked = false;
      Future.microtask(() => notifyListeners());
    }
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

  Future<void> _fetchMonthStats(String walletId) async {
    final now = DateTime.now();
    final transactions = await _storage.getTransactionsByMonth(now, walletId);

    double inc = 0;
    double exp = 0;

    for (var tx in transactions) {
      if (tx.isIncome) {
        inc += tx.amount;
      } else {
        exp += tx.amount;
      }
    }

    _income = inc;
    _expenses = exp;
    _balance = inc - exp;
  }

  Future<void> _fetchChartData(String walletId) async {
    final now = DateTime.now();
    final transactions = await _storage.getTransactionsByMonth(now, walletId);

    final Map<String, double> categorySpending = {};
    final Map<String, CategoryModel> categoryObjects = {};

    for (var tx in transactions) {
      if (!tx.isIncome) {
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
      _chartData = allSpending;
    } else {
      final top4 = allSpending.sublist(0, 4);
      final others = allSpending.sublist(4);
      double otherTotal = others.fold(0, (sum, item) => sum + item.amount);

      top4.add(
        SpendingModel(
          category: "Other",
          amount: otherTotal,
          color: CupertinoColors.systemGrey,
          originalCategory: null,
        ),
      );
      _chartData = top4;
    }
  }

  Future<void> _fetchRecentTransactions(String walletId) async {
    final all = await _storage.getAllTransactions(walletId);

    if (all.length > 5) {
      _recentTransactions = all.sublist(0, 5);
    } else {
      _recentTransactions = all;
    }
  }

  Future<void> _loadWallets() async {
    try {
      _wallets = await _storage.getAllWallets();

      if (_wallets.isEmpty) {
        return;
      }

      final prefs = await SharedPreferences.getInstance();

      final bool isCurrentWalletValid = _wallets.any(
        (w) => w.id == _currentWalletId,
      );

      if (_currentWalletId == null || !isCurrentWalletValid) {
        final newWalletId = _wallets.first.id;
        _currentWalletId = newWalletId;

        await prefs.setString('current_wallet_id', newWalletId);

        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error loading wallets: $e");
    }
  }

  Future<void> switchWallet(String walletId) async {
    if (_currentWalletId == walletId) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_wallet_id', walletId);

    _currentWalletId = walletId;

    await reloadData();

    notifyListeners();
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

  String currentWalletName(AppLocalizations l10n) {
    if (_wallets.isEmpty || _currentWalletId == null) return l10n.select_wallet;

    try {
      final wallet = _wallets.firstWhere((w) => w.id == _currentWalletId);
      return wallet.name;
    } catch (e) {
      return l10n.select_wallet;
    }
  }

  Future<void> _loadCurrency() async {
    final Map<String, String> currencyData = await _storage.getCurrency();
    final String symbol = currencyData['symbol'] ?? '\$';
    _currencySymbol = symbol;
    notifyListeners();
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
    BuildContext context,
  ) {
    final Map<String, List<TransactionModel>> groups = {};
    for (var tx in list) {
      final dateKey = formatDate(tx.date, AppLocalizations.of(context)!);
      if (!groups.containsKey(dateKey)) {
        groups[dateKey] = [];
      }
      groups[dateKey]!.add(tx);
    }
    return groups;
  }

  String formatDate(DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final checkDate = DateTime(date.year, date.month, date.day);

    if (checkDate == today) return l10n.today;
    if (checkDate == yesterday) return l10n.yesterday;

    return DateFormat('dd/MM/yyyy').format(date);
  }

  String formatHours(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  Future<String?> _ensureWalletId() async {
    if (_currentWalletId != null) return _currentWalletId;
    final prefs = await SharedPreferences.getInstance();
    _currentWalletId = prefs.getString('current_wallet_id');
    return _currentWalletId;
  }

  Future<void> refreshWallets() async {
    await _loadWallets();
    notifyListeners();
  }

  Future<String?> deleteWallet(String walletId, BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    if (_wallets.isEmpty) return null;

    if (_wallets.length <= 1) {
      return l10n.cannot_delete_last_wallet;
    }

    try {
      if (_currentWalletId == walletId) {
        final otherWallet = _wallets.firstWhere((w) => w.id != walletId);

        await switchWallet(otherWallet.id);
      }

      await _storage.deleteWallet(walletId);

      await refreshWallets();

      return null;
    } catch (e) {
      debugPrint("Lỗi xóa ví: $e");
    }
    return null;
  }

  Future<Map<String, double>> getCurrentMonthStats() async {
    final walletId = await _ensureWalletId();

    if (walletId == null) {
      return {'income': 0, 'expenses': 0, 'balance': 0};
    }

    final now = DateTime.now();
    final transactions = await _storage.getTransactionsByMonth(now, walletId);

    double income = 0;
    double expenses = 0;

    for (var tx in transactions) {
      if (tx.isIncome) {
        income += tx.amount;
      } else {
        expenses += tx.amount;
      }
    }

    return {
      'income': income,
      'expenses': expenses,
      'balance': income - expenses,
    };
  }

  Future<List<SpendingModel>> getChartData() async {
    final walletId = await _ensureWalletId();
    if (walletId == null) return [];

    final now = DateTime.now();
    final transactions = await _storage.getTransactionsByMonth(now, walletId);

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
    final walletId = await _ensureWalletId();
    if (walletId == null) return [];

    final now = DateTime.now();
    final transactions = await _storage.getTransactionsByMonth(now, walletId);

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
      final fontSize = 16.sp;
      final radius = isTouched ? 45.0.w : 35.0.w;
      final categoryName = CategoryHelper.getTranslatedName(
        context,
        item.originalCategory!,
      );

      return PieChartSectionData(
        color: item.color,
        value: item.amount,
        title: isTouched
            ? '$categoryName \n $currencySymbol ${formatCurrency(item.amount)}'
            : '',
        radius: radius,
        titleStyle: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: CupertinoTheme.of(context).textTheme.textStyle.color,
        ),
      );
    }).toList();
  }

  Future<List<TransactionModel>> getRecentTransactionsList() async {
    final walletId = await _ensureWalletId();
    if (walletId == null) return [];
    final all = await _storage.getAllTransactions(walletId);

    if (all.length > 5) {
      return all.sublist(0, 5);
    }

    return all;
  }

  Future<List<TransactionModel>> getTransactionsForCurrentMonth() async {
    final walletId = await _ensureWalletId();
    if (walletId == null) return [];

    final now = DateTime.now();
    final transactions = await _storage.getTransactionsByMonth(now, walletId);

    transactions.sort((a, b) => b.date.compareTo(a.date));

    return transactions;
  }

  Future<double> calculateSpendingChange() async {
    final walletId = await _ensureWalletId();
    if (walletId == null) return 0.0;

    final now = DateTime.now();
    final lastMonthDate = DateTime(now.year, now.month - 1);

    final currentTrans = await _storage.getTransactionsByMonth(now, walletId);
    final lastMonthTrans = await _storage.getTransactionsByMonth(
      lastMonthDate,
      walletId,
    );

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
