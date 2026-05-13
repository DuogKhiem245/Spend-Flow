import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/data/currency_data.dart';
import 'package:spend_flow/core/model/location_model.dart';
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
  static const String _kLocationKey = 'is_location_enabled';
  static const String _kCurrencyCodeKey = 'selected_currency_code';

  Future<bool?> getNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kNotificationKey);
  }

  Future<void> saveNotificationStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kNotificationKey, value);
  }

  Future<bool?> getLocationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kLocationKey);
  }

  Future<void> saveLocationStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLocationKey, value);
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

    final filter = Filter.or([
      Filter.equals('isDeleted', false),
      Filter.equals('isDeleted', 0),
      Filter.isNull('isDeleted'),
    ]);
    final finder = Finder(filter: filter);

    final walletsSnapshot = await _walletStore.find(db, finder: finder);
    final transactionsSnapshot = await _transactionStore.find(
      db,
      finder: finder,
    );
    final budgetsSnapshot = await _budgetStore.find(db, finder: finder);

    final categoriesSnapshot = await _categorySample.find(db, finder: finder);

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
      'categories': categoriesSnapshot
          .map((snapshot) => snapshot.value)
          .toList(),
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
        await _budgetStore.delete(txn);
        await _categorySample.delete(txn);

        if (data['wallets'] != null) {
          for (var item in data['wallets']) {
            await _walletStore.add(txn, Map<String, dynamic>.from(item));
          }
        }

        if (data['categories'] != null) {
          for (var item in data['categories']) {
            await _categorySample.add(txn, Map<String, dynamic>.from(item));
          }
        }

        if (data['transactions'] != null) {
          for (var item in data['transactions']) {
            await _transactionStore.add(txn, Map<String, dynamic>.from(item));
          }
        }

        if (data['budgets'] != null) {
          for (var item in data['budgets']) {
            await _budgetStore.add(txn, Map<String, dynamic>.from(item));
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

  final _categorySample = intMapStoreFactory.store('sample_categories');
  final _categorySuggest = intMapStoreFactory.store('suggest_categories');

  final _recentLocationStore = intMapStoreFactory.store('recent_locations');

  final _transactionStore = intMapStoreFactory.store('transactions');
  final _budgetStore = intMapStoreFactory.store('budgets');
  final _walletStore = intMapStoreFactory.store('wallets');

  final _syncCategoryStore = intMapStoreFactory.store('sync_categories_queue');
  final _syncRecentLocationStore = intMapStoreFactory.store(
    'sync_recent_locations_queue',
  );
  final _syncTransactionStore = intMapStoreFactory.store(
    'sync_transactions_queue',
  );
  final _syncWalletStore = intMapStoreFactory.store('sync_wallets_queue');
  final _syncBudgetStore = intMapStoreFactory.store('sync_budgets_queue');

  final _configStore = StoreRef<String, dynamic>('app_config');

  Future<Database> get database async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, 'spend_flow.db');
    _db = await databaseFactoryIo.openDatabase(dbPath);
    return _db!;
  }

  Future<int> getGlobalSyncTime() async {
    final db = await database;
    final record = await _configStore.record('global_sync_time').get(db);
    return (record as int?) ?? 0;
  }

  Future<void> saveGlobalSyncTime(int timestamp) async {
    final db = await database;
    await _configStore.record('global_sync_time').put(db, timestamp);
  }

  // ------------------------------------------------------------
  // CATEGORIES
  // ------------------------------------------------------------

  Future<void> initializeData() async {
    final db = await database;

    final sampleCount = await _categorySample.count(db);
    if (sampleCount == 0) {
      final samples = CategoryData.sampleCategories;
      await db.transaction((txn) async {
        for (var cat in samples) {
          await _categorySample.add(txn, cat.toMap());
        }
      });
    }

    final suggestCount = await _categorySuggest.count(db);
    if (suggestCount == 0) {
      final suggests = CategoryData.suggestedCategories;
      await db.transaction((txn) async {
        for (var cat in suggests) {
          await _categorySuggest.add(txn, cat.toMap());
        }
      });
    }
  }

  List<CategoryModel> getDefaultSuggestions() {
    return CategoryData.suggestedCategories;
  }

  Future<List<CategoryModel>> getAllCategories() async {
    final db = await database;
    final finder = Finder(
      filter: Filter.or([
        Filter.equals('isDeleted', false),
        Filter.equals('isDeleted', 0),
        Filter.isNull('isDeleted'),
      ]),
      sortOrders: [SortOrder('name')],
    );
    final snapshots = await _categorySample.find(db, finder: finder);

    return snapshots.map((snapshot) {
      return CategoryModel.fromMap(snapshot.value);
    }).toList();
  }

  Future<List<CategoryModel>> getDefaultSuggestionsFromDB() async {
    final db = await database;
    final snapshots = await _categorySuggest.find(db);

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

    final snapshots = await _categorySample.find(db, finder: finder);

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
      final snapshot = await _categorySample.findFirst(txn, finder: finder);

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
        await _categorySample.record(snapshot.key).update(txn, updated.toMap());
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
        await _categorySample.add(txn, newCategory.toMap());
        categoryToSync = newCategory;
      }

      await _upsertCategorySync(txn, categoryToSync.toMap());
    });
  }

  Future<void> addCategory(
    CategoryModel category, {
    bool forceUpdate = false,
  }) async {
    final db = await database;

    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', category.id));
      final existing = await _categorySample.findFirst(txn, finder: finder);

      if (existing == null) {
        await _categorySample.add(txn, category.toMap());

        if (!forceUpdate) {
          await _upsertCategorySync(txn, category.toMap());
        }
      } else {
        if (forceUpdate) {
          await _categorySample
              .record(existing.key)
              .update(txn, category.toMap());
        } else {
          debugPrint("Category ID ${category.id} already exists.");
        }
      }
    });
  }

  Future<void> updateCategory(CategoryModel updatedCategory) async {
    final db = await database;

    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', updatedCategory.id));
      final snapshot = await _categorySample.findFirst(txn, finder: finder);

      if (snapshot != null) {
        await _categorySample
            .record(snapshot.key)
            .update(txn, updatedCategory.toMap());

        await _upsertCategorySync(txn, updatedCategory.toMap());
      } else {
        debugPrint("Error: Category ${updatedCategory.id} not found.");
      }
    });
  }

  Future<bool> deleteCategory(CategoryModel category) async {
    if (int.tryParse(category.id) != null) return false;

    final db = await database;
    return await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', category.id));
      final snapshot = await _categorySample.findFirst(txn, finder: finder);

      if (snapshot != null) {
        final deletedData = category
            .copyWith(
              isDeleted: true,
              updatedAt: DateTime.now().millisecondsSinceEpoch,
            )
            .toMap();

        await _categorySample.record(snapshot.key).update(txn, deletedData);

        await _upsertCategorySync(txn, deletedData);

        return true;
      }
      return false;
    });
  }

  Future<List<CategoryModel>> getPendingSyncCategories() async {
    final db = await database;
    final snapshots = await _syncCategoryStore.find(db);

    return snapshots.map((snapshot) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return CategoryModel.fromMap(data);
    }).toList();
  }

  Future<void> removeSyncedCategories(List<String> categoryIds) async {
    final db = await database;
    final finder = Finder(filter: Filter.inList('id', categoryIds));
    await _syncCategoryStore.delete(db, finder: finder);
  }

  Future<bool> checkIconExists(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    return file.existsSync();
  }

  Future<void> saveCategoryFromSync(CategoryModel category) async {
    final db = await database;
    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', category.id));
      final existing = await _categorySample.findFirst(txn, finder: finder);

      if (existing != null) {
        await _categorySample
            .record(existing.key)
            .update(txn, category.toMap());
      } else {
        await _categorySample.add(txn, category.toMap());
      }
    });
  }

  Future<void> deleteCategoryFromSync(String categoryId) async {
    final db = await database;

    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', categoryId));
      final existing = await _categorySample.findFirst(txn, finder: finder);

      if (existing != null) {
        final updatedData = Map<String, dynamic>.from(existing.value);
        updatedData['isDeleted'] = 1;
        updatedData['updatedAt'] = DateTime.now().millisecondsSinceEpoch;

        await _categorySample.record(existing.key).update(txn, updatedData);
      } else {
        final deletedPlaceholder = {
          'id': categoryId,
          'isDeleted': 1,
          'updatedAt': DateTime.now().millisecondsSinceEpoch,
        };
        await _categorySample.add(txn, deletedPlaceholder);
      }
    });
  }

  Future<void> _upsertCategorySync(
    Transaction txn,
    Map<String, dynamic> data,
  ) async {
    final syncFinder = Finder(filter: Filter.equals('id', data['id']));
    final existingSync = await _syncCategoryStore.findFirst(
      txn,
      finder: syncFinder,
    );

    if (existingSync != null) {
      await _syncCategoryStore.record(existingSync.key).update(txn, data);
    } else {
      await _syncCategoryStore.add(txn, data);
    }
  }

  // ============================================================
  // RECENT LOCATIONS
  // ============================================================

  Future<void> saveRecentLocation(RecentLocationModel location) async {
    final db = await database;

    await db.transaction((txn) async {
      final finder = Finder(
        filter: Filter.and([
          Filter.equals('lat', location.lat),
          Filter.equals('lng', location.lng),
        ]),
      );
      await _recentLocationStore.delete(txn, finder: finder);
      await _recentLocationStore.add(txn, location.toMap());

      final count = await _recentLocationStore.count(txn);
      if (count > 10) {
        final oldRecordsFinder = Finder(
          sortOrders: [SortOrder('timestamp', true)],
          limit: count - 10,
        );
        await _recentLocationStore.delete(txn, finder: oldRecordsFinder);
      }

      await _syncRecentLocationStore.add(txn, {
        'action': 'UPSERT',
        'data': location.toMap(),
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      });
    });
  }

  Future<List<RecentLocationModel>> getRecentLocations() async {
    final db = await database;

    final finder = Finder(sortOrders: [SortOrder('timestamp', false)]);

    final snapshots = await _recentLocationStore.find(db, finder: finder);

    return snapshots.map((snapshot) {
      final map = Map<String, dynamic>.from(snapshot.value as Map);
      return RecentLocationModel.fromMap(map);
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getPendingRecentLocations() async {
    final db = await database;
    final snapshots = await _syncRecentLocationStore.find(db);

    return snapshots.map((snapshot) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      data['key'] = snapshot.key;
      return data;
    }).toList();
  }

  Future<void> removeSyncedRecentLocations(List<int> keys) async {
    final db = await database;

    final finder = Finder(filter: Filter.byKey(keys));
    await _syncRecentLocationStore.delete(db, finder: finder);
  }

  Future<void> saveSyncedRecentLocation(RecentLocationModel location) async {
    final db = await database;

    await db.transaction((txn) async {
      final finder = Finder(
        filter: Filter.and([
          Filter.equals('lat', location.lat),
          Filter.equals('lng', location.lng),
        ]),
      );
      await _recentLocationStore.delete(txn, finder: finder);
      await _recentLocationStore.add(txn, location.toMap());

      final count = await _recentLocationStore.count(txn);
      if (count > 10) {
        final oldRecordsFinder = Finder(
          sortOrders: [SortOrder('timestamp', true)],
          limit: count - 10,
        );
        await _recentLocationStore.delete(txn, finder: oldRecordsFinder);
      }
    });
  }

  // ============================================================
  // WALLETS
  // ============================================================

  Future<List<WalletModel>> getAllWallets() async {
    final db = await database;

    final finder = Finder(
      filter: Filter.or([
        Filter.equals('isDeleted', 0),
        Filter.equals('isDeleted', false),
        Filter.isNull('isDeleted'),
      ]),
    );

    final snapshots = await _walletStore.find(db, finder: finder);

    return snapshots.map((snapshot) {
      return WalletModel.fromMap(snapshot.value);
    }).toList();
  }

  Future<String> getCurrentWalletId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_wallet_id')!;
  }

  Future<void> saveWallet(WalletModel wallet) async {
    final db = await database;
    final updatedWallet = wallet.copyWith(
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', updatedWallet.id));

      final existing = await _walletStore.findFirst(txn, finder: finder);
      if (existing != null) {
        await _walletStore
            .record(existing.key)
            .update(txn, updatedWallet.toMap());
      } else {
        await _walletStore.add(txn, updatedWallet.toMap());
      }

      final existingSync = await _syncWalletStore.findFirst(
        txn,
        finder: finder,
      );
      if (existingSync != null) {
        await _syncWalletStore
            .record(existingSync.key)
            .update(txn, updatedWallet.toMap());
      } else {
        await _syncWalletStore.add(txn, updatedWallet.toMap());
      }
    });
  }

  Future<List<Map<String, dynamic>>> getPendingSyncWallets() async {
    final db = await database;
    final snapshots = await _syncWalletStore.find(db);

    return snapshots.map((snapshot) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      data['key'] = snapshot.key;
      return data;
    }).toList();
  }

  Future<void> removeSyncedWallets(List<int> keys) async {
    final db = await database;
    await _syncWalletStore.records(keys).delete(db);
  }

  Future<void> saveWalletFromSync(WalletModel wallet) async {
    final db = await database;
    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', wallet.id));
      final existing = await _walletStore.findFirst(txn, finder: finder);

      if (existing != null) {
        await _walletStore.record(existing.key).update(txn, wallet.toMap());
      } else {
        await _walletStore.add(txn, wallet.toMap());
      }
    });
  }

  Future<void> deleteWalletFromSync(String walletId) async {
    final db = await database;
    await db.transaction((txn) async {
      final walletFinder = Finder(filter: Filter.equals('id', walletId));
      await _walletStore.delete(txn, finder: walletFinder);

      final childFinder = Finder(filter: Filter.equals('walletId', walletId));
      await _transactionStore.delete(txn, finder: childFinder);
      await _budgetStore.delete(txn, finder: childFinder);
    });
  }

  Future<void> deleteWallet(String walletId) async {
    final db = await database;

    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', walletId));
      final snapshot = await _walletStore.findFirst(txn, finder: finder);

      if (snapshot == null) return;

      final Map<String, dynamic> deletedData = Map<String, dynamic>.from(
        snapshot.value,
      );
      deletedData['isDeleted'] = 1;
      deletedData['updatedAt'] = DateTime.now().millisecondsSinceEpoch;

      await _walletStore.record(snapshot.key).update(txn, deletedData);

      final childFinder = Finder(filter: Filter.equals('walletId', walletId));
      final updateData = {
        'isDeleted': 1,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      };

      await _transactionStore.update(txn, updateData, finder: childFinder);
      await _budgetStore.update(txn, updateData, finder: childFinder);

      await _syncWalletStore.add(txn, deletedData);
    });
  }

  // ------------------------------------------------------------
  // TRANSACTIONS
  // ------------------------------------------------------------

  Future<bool> addTransaction(TransactionModel transaction) async {
    try {
      final db = await database;

      final itemToSave = transaction.copyWith(
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      );

      await db.transaction((txn) async {
        final finder = Finder(filter: Filter.equals('id', itemToSave.id));
        final existing = await _transactionStore.findFirst(txn, finder: finder);

        if (existing != null) {
          await _transactionStore
              .record(existing.key)
              .update(txn, itemToSave.toMap());
        } else {
          await _transactionStore.add(txn, itemToSave.toMap());
        }

        await _syncTransactionStore.add(txn, itemToSave.toMap());
      });

      await incrementCategoryUsage(transaction.category);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<TransactionModel>> getAllTransactions(String walletId) async {
    final db = await database;

    final finder = Finder(
      filter: Filter.and([
        Filter.equals('walletId', walletId),
        Filter.or([
          Filter.equals('isDeleted', 0),
          Filter.equals('isDeleted', false),
          Filter.isNull('isDeleted'),
        ]),
      ]),
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
        Filter.or([
          Filter.equals('isDeleted', 0),
          Filter.equals('isDeleted', false),
          Filter.isNull('isDeleted'),
        ]),
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

    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', id));
      final snapshot = await _transactionStore.findFirst(txn, finder: finder);

      if (snapshot == null) return;

      final updatedData = Map<String, dynamic>.from(snapshot.value as Map);
      updatedData['isDeleted'] = 1;
      updatedData['updatedAt'] = DateTime.now().millisecondsSinceEpoch;

      await _transactionStore.record(snapshot.key).update(txn, updatedData);

      await _syncTransactionStore.add(txn, updatedData);
    });
  }

  Future<List<Map<String, dynamic>>> getPendingSyncTransactions() async {
    final db = await database;
    final snapshots = await _syncTransactionStore.find(db);
    return snapshots.map((s) {
      final data = Map<String, dynamic>.from(s.value as Map);
      data['key'] = s.key;
      return data;
    }).toList();
  }

  Future<void> removeSyncedTransactions(List<int> keys) async {
    final db = await database;
    final finder = Finder(filter: Filter.byKey(keys));
    await _syncTransactionStore.delete(db, finder: finder);
  }

  Future<void> saveTransactionFromSync(TransactionModel transaction) async {
    final db = await database;
    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', transaction.id));
      final existing = await _transactionStore.findFirst(txn, finder: finder);

      if (existing != null) {
        await _transactionStore
            .record(existing.key)
            .update(txn, transaction.toMap());
      } else {
        await _transactionStore.add(txn, transaction.toMap());
      }
    });
  }

  Future<void> deleteTransactionFromSync(String id) async {
    final db = await database;
    final finder = Finder(filter: Filter.equals('id', id));
    await _transactionStore.delete(db, finder: finder);
  }

  // ------------------------------------------------------------
  // BUDGETS
  // ------------------------------------------------------------

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

        if (value['isDeleted'] == 1 || value['isDeleted'] == true) return false;

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

    final itemToUpdate = budget.copyWith(
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', itemToUpdate.id));
      final snapshot = await _budgetStore.findFirst(txn, finder: finder);

      if (snapshot != null) {
        await _budgetStore
            .record(snapshot.key)
            .update(txn, itemToUpdate.toMap());

        await _syncBudgetStore.add(txn, itemToUpdate.toMap());
      } else {
        debugPrint("Not found Budget ${itemToUpdate.id} to update.");
      }
    });
  }

  Future<void> saveBudget(BudgetModel budget) async {
    final db = await database;
    final itemToSave = budget.copyWith(
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    await db.transaction((txn) async {
      final finder = Finder(
        filter: Filter.custom((record) {
          final value = record.value as Map<String, dynamic>;
          if (value['isDeleted'] == 1) {
            return false;
          }
          if (value['walletId'] != itemToSave.walletId) return false;
          final categoryMap = value['category'] as Map<String, dynamic>;
          if (categoryMap['iconKey'] != itemToSave.category.iconKey) {
            return false;
          }
          final storedDate = DateTime.parse(value['date']);
          return storedDate.year == itemToSave.date.year &&
              storedDate.month == itemToSave.date.month;
        }),
      );

      final existingSnapshot = await _budgetStore.findFirst(
        txn,
        finder: finder,
      );
      BudgetModel finalBudget;

      if (existingSnapshot != null) {
        finalBudget = itemToSave.copyWith(
          id: existingSnapshot.value['id'] as String,
        );
        await _budgetStore
            .record(existingSnapshot.key)
            .update(txn, finalBudget.toMap());
      } else {
        finalBudget = itemToSave;
        await _budgetStore.add(txn, finalBudget.toMap());
      }

      final syncData = finalBudget.toMap();
      final syncFinder = Finder(filter: Filter.equals('id', finalBudget.id));
      final existingSync = await _syncBudgetStore.findFirst(
        txn,
        finder: syncFinder,
      );

      if (existingSync != null) {
        await _syncBudgetStore.record(existingSync.key).update(txn, syncData);
      } else {
        await _syncBudgetStore.add(txn, syncData);
      }
    });
  }

  Future<void> deleteBudget(String budgetId) async {
    final db = await database;
    await db.transaction((txn) async {
      final finder = Finder(filter: Filter.equals('id', budgetId));
      final snapshot = await _budgetStore.findFirst(txn, finder: finder);
      if (snapshot == null) return;

      final updatedData = Map<String, dynamic>.from(snapshot.value as Map);
      updatedData['isDeleted'] = 1;
      updatedData['updatedAt'] = DateTime.now().millisecondsSinceEpoch;

      await _budgetStore.record(snapshot.key).update(txn, updatedData);

      await _syncBudgetStore.add(txn, updatedData);
    });
  }

  Future<List<Map<String, dynamic>>> getPendingSyncBudgets() async {
    final db = await database;
    final snapshots = await _syncBudgetStore.find(db);
    return snapshots
        .map(
          (s) => {...Map<String, dynamic>.from(s.value as Map), 'key': s.key},
        )
        .toList();
  }

  Future<void> removeSyncedBudgets(List<int> keys) async {
    final db = await database;
    await _syncBudgetStore.records(keys).delete(db);
  }

  Future<void> saveBudgetFromSync(BudgetModel budget) async {
    final db = await database;
    final finder = Finder(filter: Filter.equals('id', budget.id));
    final existing = await _budgetStore.findFirst(db, finder: finder);
    if (existing != null) {
      await _budgetStore.record(existing.key).update(db, budget.toMap());
    } else {
      await _budgetStore.add(db, budget.toMap());
    }
  }

  Future<void> deleteBudgetFromSync(String budgetId) async {
    final db = await database;
    await _budgetStore.delete(
      db,
      finder: Finder(filter: Filter.equals('id', budgetId)),
    );
  }

  // ============================================================
  // DELETE DATA DATABASE
  // ============================================================

  Future<void> purgeAllData() async {
    final db = await database;
    final user = FirebaseAuth.instance.currentUser;

    final thirtyDaysAgo = DateTime.now()
        .subtract(const Duration(days: 30))
        .millisecondsSinceEpoch;

    final filter = Filter.and([
      Filter.or([
        Filter.equals('isDeleted', 1),
        Filter.equals('isDeleted', true),
      ]),
      Filter.lessThan('updatedAt', thirtyDaysAgo),
    ]);

    final finder = Finder(filter: filter);

    if (user != null) {
      try {
        final batch = FirebaseFirestore.instance.batch();
        bool hasDataToDelete = false;

        final stores = [
          _transactionStore,
          _walletStore,
          _budgetStore,
          _categorySample,
        ];
        final collections = [
          'transactions',
          'wallets',
          'budgets',
          'categories',
        ];

        for (int i = 0; i < stores.length; i++) {
          final snapshots = await stores[i].find(db, finder: finder);

          for (var snapshot in snapshots) {
            final data = snapshot.value as Map<String, dynamic>;
            if (data.containsKey('id')) {
              hasDataToDelete = true;
              final docRef = FirebaseFirestore.instance
                  .collection('data_sync') // Update, if bug set "users"
                  .doc(user.uid)
                  .collection(collections[i])
                  .doc(data['id'].toString());
              batch.delete(docRef);
            }
          }
        }

        if (hasDataToDelete) {
          await batch.commit();
        }
      } catch (e) {
        debugPrint("Error deleting data from Firebase: $e");
        return;
      }
    }
    await db.transaction((txn) async {
      await _transactionStore.delete(txn, finder: finder);
      await _walletStore.delete(txn, finder: finder);
      await _budgetStore.delete(txn, finder: finder);
      await _categorySample.delete(txn, finder: finder);

      await _syncTransactionStore.delete(txn, finder: finder);
      await _syncWalletStore.delete(txn, finder: finder);
      await _syncBudgetStore.delete(txn, finder: finder);
      await _syncCategoryStore.delete(txn, finder: finder);
    });
  }
}
