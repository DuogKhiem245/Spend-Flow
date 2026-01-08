import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/data/currency_data.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/model/budget_model.dart';
import 'package:spend_flow/core/model/wallet_model.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  // ============================================================
  // 1: SHARED PREFERENCES (SETTINGS)
  // ============================================================

  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static const String _kNotificationKey = 'is_notification_enabled';
  static const String _kCurrencyCodeKey = 'selected_currency_code';
  static const String _isPremiumKey = 'is_premium_user';

  Future<bool> getNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kNotificationKey) ?? false;
  }

  Future<void> saveNotificationStatus(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kNotificationKey, isEnabled);
  }

  Future<void> saveCurrencyCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kCurrencyCodeKey, code);
  }

  Future<Map<String, String>> getCurrency() async {
    final prefs = await SharedPreferences.getInstance();

    final String savedCode = prefs.getString(_kCurrencyCodeKey) ?? 'USD';

    final allCurrencies = [
      ...CurrencyData().popularList,
      ...CurrencyData().allList,
    ];

    final currency = allCurrencies.firstWhere(
      (element) => element['code'] == savedCode,
      orElse: () => CurrencyData().popularList[0],
    );

    return currency;
  }

  Future<bool> getPremiumStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isPremiumKey) ?? false;
  }

  Future<void> setPremiumStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isPremiumKey, value);
  }

  // ============================================================
  // 2: PASSCODE
  // ============================================================

  final _settingStore = stringMapStoreFactory.store('settings');
  static const String _passcodeKey = 'user_passcode';
  static const String _faceIdKey = 'is_face_id_enabled';

  Future<bool> hasPasscode() async {
    final db = await database;
    final finder = Finder(filter: Filter.byKey('user_passcode'));
    final record = await _settingStore.findFirst(db, finder: finder);
    return record != null;
  }

  Future<String?> getPasscode() async {
    final db = await database;
    final finder = Finder(filter: Filter.byKey(_passcodeKey));
    final record = await _settingStore.findFirst(db, finder: finder);
    return record?.value['code'] as String?;
  }

  Future<void> savePasscode(String code) async {
    final db = await database;
    await _settingStore.record(_passcodeKey).put(db, {'code': code});
  }

  Future<void> removePasscode() async {
    final db = await database;
    await _settingStore.record(_passcodeKey).delete(db);
  }

  Future<bool> isFaceIdEnabled() async {
    final db = await database;
    final record = await _settingStore.record(_faceIdKey).get(db);
    if (record is Map) {
      return (record?['enabled'] as bool?) ?? false;
    }
    return false;
  }

  Future<void> setFaceIdEnabled(bool enabled) async {
    final db = await database;
    await _settingStore.record(_faceIdKey).put(db, {'enabled': enabled});
  }

  // ------------------------------------------------------------
  // 3: IMPORT, EXPORT DATA
  // ------------------------------------------------------------

  Future<String> exportDataToJson() async {
    final db = await database;

    final walletsSnapshot = await _walletStore.find(db);
    final transactionsSnapshot = await _transactionStore.find(db);
    final budgetsSnapshot = await _budgetStore.find(db);

    final Map<String, dynamic> exportData = {
      'metadata': {
        'timestamp': DateTime.now().toIso8601String(),
        'app_version': '1.0.0',
        'exported_by': 'SpendFlow',
      },
      'wallets': walletsSnapshot.map((snapshot) => snapshot.value).toList(),
      'transactions': transactionsSnapshot
          .map((snapshot) => snapshot.value)
          .toList(),
      'budgets': budgetsSnapshot.map((snapshot) => snapshot.value).toList(),
    };

    return jsonEncode(exportData);
  }

  Future<void> importDataFromJson(String jsonString) async {
    final db = await database;

    try {
      final Map<String, dynamic> data = jsonDecode(jsonString);

      await db.transaction((txn) async {
        await _walletStore.delete(txn);
        await _transactionStore.delete(txn);

        if (data['wallets'] != null) {
          final List<dynamic> wallets = data['wallets'];
          for (var item in wallets) {
            await _walletStore.add(txn, item as Map<String, dynamic>);
          }
        }

        if (data['transactions'] != null) {
          final List<dynamic> transactions = data['transactions'];
          for (var item in transactions) {
            await _transactionStore.add(txn, item as Map<String, dynamic>);
          }
        }
      });
    } catch (e) {
      debugPrint("Lỗi Import Data: $e");
      throw Exception("Dữ liệu backup không hợp lệ hoặc bị lỗi.");
    }
  }

  // ============================================================
  // 4: SEMBAST DATABASE
  // ============================================================

  Database? _db;

  final _sampleStore = intMapStoreFactory.store('sample_categories');
  final _suggestStore = intMapStoreFactory.store('suggest_categories');

  final _transactionStore = intMapStoreFactory.store('transactions');
  final _budgetStore = intMapStoreFactory.store('budgets');
  final _walletStore = intMapStoreFactory.store('wallets');

  final _syncCategoryStore = intMapStoreFactory.store('sync_categories_queue');
  final _syncTransactionStore = intMapStoreFactory.store('sync_transactions_queue');
  final _syncWalletStore = intMapStoreFactory.store('sync_wallets_queue');
  final _syncBudgetStore = intMapStoreFactory.store('sync_budgets_queue');

  Future<Database> get database async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, 'spend_flow.db');
    _db = await databaseFactoryIo.openDatabase(dbPath);
    return _db!;
  }

  // ------------------------------------------------------------
  // CATEGORIES
  // ------------------------------------------------------------

  Future<void> initializeData() async {
    final db = await database;

    final sampleCount = await _sampleStore.count(db);
    if (sampleCount == 0) {
      final samples = CategoryData.sampleCategories;
      await db.transaction((txn) async {
        for (var cat in samples) {
          await _sampleStore.add(txn, cat.toMap());
        }
      });
    }

    final suggestCount = await _suggestStore.count(db);
    if (suggestCount == 0) {
      final suggests = CategoryData.suggestedCategories;
      await db.transaction((txn) async {
        for (var cat in suggests) {
          await _suggestStore.add(txn, cat.toMap());
        }
      });
    }
  }

  List<CategoryModel> getDefaultSuggestions() {
    return CategoryData.suggestedCategories;
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final db = await database;
    final finder = Finder(sortOrders: [SortOrder('name')]);
    final snapshots = await _sampleStore.find(db, finder: finder);

    return snapshots.map((snapshot) {
      return CategoryModel.fromMap(snapshot.value);
    }).toList();
  }

  Future<List<CategoryModel>> getDefaultSuggestionsFromDB() async {
    final db = await database;
    final snapshots = await _suggestStore.find(db);

    return snapshots
        .map((snapshot) => CategoryModel.fromMap(snapshot.value))
        .toList();
  }

  Future<List<CategoryModel>> getTop3MostUsedCategories() async {
    final db = await database;

    final finder = Finder(
      filter: Filter.greaterThan('count', 0),
      sortOrders: [SortOrder('count', false)],
      limit: 3,
    );

    final snapshots = await _sampleStore.find(db, finder: finder);

    return snapshots.map((snapshot) {
      return CategoryModel.fromMap(snapshot.value);
    }).toList();
  }

  Future<List<CategoryModel>> getSmartSuggestions() async {
    final mostUsed = await getTop3MostUsedCategories();

    final defaults = await getDefaultSuggestionsFromDB();

    final Map<String, CategoryModel> uniqueMap = {};

    for (var cat in mostUsed) {
      uniqueMap[cat.id] = cat;
    }

    for (var cat in defaults) {
      if (!uniqueMap.containsKey(cat.id)) {
        uniqueMap[cat.id] = cat;
      }
    }

    return uniqueMap.values.toList();
  }

  Future<void> incrementCategoryUsage(CategoryModel category) async {
    final db = await database;

    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', category.id));
      final snapshot = await _sampleStore.findFirst(txn, finder: finder);

      CategoryModel categoryToSync;

      if (snapshot != null) {
        final current = CategoryModel.fromMap(snapshot.value);
        final updated = CategoryModel(
          id: current.id,
          name: current.name,
          l10nKey: current.l10nKey,
          iconKey: current.iconKey,
          color: current.color,
          count: current.count + 1,
          isCustom: current.isCustom, 
        );
        await _sampleStore.record(snapshot.key).update(txn, updated.toMap());
        categoryToSync = updated;
      } else {
        final newCategory = CategoryModel(
          id: category.id,
          name: category.name,
          l10nKey: category.l10nKey,
          iconKey: category.iconKey,
          color: category.color,
          count: 1,
          isCustom: category.isCustom,
        );
        await _sampleStore.add(txn, newCategory.toMap());
        categoryToSync = newCategory;
      }

      await _syncCategoryStore.add(txn, categoryToSync.toMap());
    });
  }

  Future<void> addCategory(CategoryModel category) async {
    final db = await database;

    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', category.id));
      final existing = await _sampleStore.findFirst(txn, finder: finder);

      if (existing == null) {
        await _sampleStore.add(txn, category.toMap());

        await _syncCategoryStore.add(txn, category.toMap());
      } else {
        debugPrint("Category ID ${category.id} already exists.");
      }
    });
  }

  Future<void> updateCategory(CategoryModel updatedCategory) async {
    final db = await database;

    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', updatedCategory.id));
      final snapshot = await _sampleStore.findFirst(txn, finder: finder);

      if (snapshot != null) {
        await _sampleStore
            .record(snapshot.key)
            .update(txn, updatedCategory.toMap());

        await _syncCategoryStore.add(txn, updatedCategory.toMap());
      } else {
        debugPrint("Error: Category ${updatedCategory.id} not found.");
      }
    });
  }

  Future<bool> deleteCategory(CategoryModel category) async {
    if (int.tryParse(category.id) != null) {
      debugPrint("Cannot delete default system category: ${category.name}");
      return false;
    }

    final db = await database;

    final finder = Finder(filter: Filter.equals('id', category.id));
    final deletedCount = await _sampleStore.delete(db, finder: finder);

    return deletedCount > 0;
  }

  // ============================================================
  // WALLETS
  // ============================================================

 Future<void> saveWallet(WalletModel wallet) async {
    final db = await database;

    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', wallet.id));
      final existing = await _walletStore.findFirst(txn, finder: finder);

      if (existing != null) {
        await _walletStore.record(existing.key).update(txn, wallet.toMap());
      } else {
        await _walletStore.add(txn, wallet.toMap());
      }
      await _syncWalletStore.add(txn, wallet.toMap());
    });
  }

  Future<List<WalletModel>> getAllWallets() async {
    final db = await database;

    final snapshots = await _walletStore.find(db);

    return snapshots.map((snapshot) {
      return WalletModel.fromMap(snapshot.value);
    }).toList();
  }

  Future<void> deleteWallet(String walletId) async {
    final db = await database;
    final finder = Finder(filter: Filter.equals('id', walletId));

    await _walletStore.delete(db, finder: finder);

    final txFinder = Finder(filter: Filter.equals('walletId', walletId));
    await _transactionStore.delete(db, finder: txFinder);

    final bgFinder = Finder(filter: Filter.equals('walletId', walletId));
    await _budgetStore.delete(db, finder: bgFinder);
  }

  // ------------------------------------------------------------
  // TRANSACTIONS
  // ------------------------------------------------------------

  Future<void> addTransaction(TransactionModel transaction) async {
    final db = await database;

    await db.transaction((txn) async {
      await _transactionStore.add(txn, transaction.toMap());

      await _syncTransactionStore.add(txn, transaction.toMap());
    });

    await incrementCategoryUsage(transaction.category);
  }

  Future<List<TransactionModel>> getAllTransactions(String walletId) async {
    final db = await database;

    final finder = Finder(
      filter: Filter.equals('walletId', walletId),
      sortOrders: [SortOrder('date', false)],
    );

    final snapshots = await _transactionStore.find(db, finder: finder);

    return snapshots.map((snapshot) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return TransactionModel.fromMap(data);
    }).toList();
  }

  Future<List<TransactionModel>> getTransactionsByMonth(
    DateTime month,
    String walletId,
  ) async {
    final db = await database;

    final start = DateTime(month.year, month.month, 1).toIso8601String();
    final end = DateTime(month.year, month.month + 1, 1).toIso8601String();

    final finder = Finder(
      filter: Filter.and([
        Filter.greaterThanOrEquals('date', start),
        Filter.lessThan('date', end),
        Filter.equals('walletId', walletId),
      ]),
      sortOrders: [SortOrder('date', false)],
    );

    final snapshots = await _transactionStore.find(db, finder: finder);

    return snapshots.map((snapshot) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return TransactionModel.fromMap(data);
    }).toList();
  }

  Future<void> deleteTransaction(String id) async {
    final db = await database;
    final finder = Finder(filter: Filter.equals('id', id));
    await _transactionStore.delete(db, finder: finder);
  }

  // ------------------------------------------------------------
  // BUDGETS
  // ------------------------------------------------------------

  Future<void> saveBudget(BudgetModel budget) async {
    final db = await database;

    await db.transaction((txn) async {
      final finder = Finder(
        filter: Filter.custom((record) {
          final value = record.value as Map<String, dynamic>;
          if (value['walletId'] != budget.walletId) return false;

          final categoryMap = value['category'] as Map<String, dynamic>;
          if (categoryMap['iconKey'] != budget.category.iconKey) return false;

          if (value['date'] == null) return false;
          final storedDate = DateTime.parse(value['date']);
          return storedDate.year == budget.date.year &&
              storedDate.month == budget.date.month;
        }),
      );

      final existingSnapshot = await _budgetStore.findFirst(
        txn,
        finder: finder,
      );

      BudgetModel finalBudgetToSync = budget;

      if (existingSnapshot != null) {
        final updatedBudget = budget.copyWith(
          id: existingSnapshot.value['id'] as String,
        );
        await _budgetStore
            .record(existingSnapshot.key)
            .update(txn, updatedBudget.toMap());
        finalBudgetToSync = updatedBudget;
      } else {
        await _budgetStore.add(txn, budget.toMap());
      }

      await _syncBudgetStore.add(txn, finalBudgetToSync.toMap());
    });
  }

  Future<List<BudgetModel>> getBudgetsForMonth(
    DateTime month,
    String walletId,
  ) async {
    final db = await database;

    final transactions = await getTransactionsByMonth(month, walletId);

    Map<String, double> spendingByCategory = {};
    for (var tx in transactions) {
      if (!tx.isIncome) {
        final key = tx.category.iconKey;
        spendingByCategory[key] = (spendingByCategory[key] ?? 0) + tx.amount;
      }
    }

    final finder = Finder(
      filter: Filter.custom((record) {
        final value = record.value as Map<String, dynamic>;

        if (value['walletId'] != walletId) return false;

        if (value['date'] == null) return false;
        final storedDate = DateTime.parse(value['date']);
        return storedDate.year == month.year && storedDate.month == month.month;
      }),
    );

    final budgetSnapshots = await _budgetStore.find(db, finder: finder);

    List<BudgetModel> result = [];

    for (var snapshot in budgetSnapshots) {
      final data = snapshot.value;
      final rawBudget = BudgetModel.fromMap(Map<String, dynamic>.from(data));

      final spentAmount = spendingByCategory[rawBudget.category.iconKey] ?? 0.0;
      final finalBudget = rawBudget.copyWith(spent: spentAmount);

      result.add(finalBudget);
    }

    return result;
  }

  Future<void> updateBudget(BudgetModel budget) async {
    final db = await database;

    final finder = Finder(filter: Filter.equals('id', budget.id));
    final snapshot = await _budgetStore.findFirst(db, finder: finder);

    if (snapshot != null) {
      await _budgetStore.record(snapshot.key).update(db, budget.toMap());
    } else {
      debugPrint("Not found budget ${budget.id} for update.");
    }
  }

  Future<void> deleteBudget(String budgetId) async {
    final db = await database;
    final finder = Finder(filter: Filter.equals('id', budgetId));
    await _budgetStore.delete(db, finder: finder);
  }

  // ------------------------------------------------------------
  // SYNC TRANSACTIONS QUEUE
  // ------------------------------------------------------------

  
}
