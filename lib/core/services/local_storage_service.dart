import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/features/add_stransaction/model/transaction_model.dart';
import 'package:spend_flow/features/add_stransaction/model/category_model.dart'; // Đảm bảo import Model Category

class LocalStorageService {
  // --- Singleton Pattern ---
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  // ============================================================
  // PHẦN 1: SHARED PREFERENCES (SETTINGS)
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

  // ============================================================
  // PHẦN 2: SEMBAST DATABASE (DATA)
  // ============================================================

  Database? _db;

  // Khai báo các Store (Bảng)
  final _transactionStore = intMapStoreFactory.store('transactions');
  final _sampleStore = intMapStoreFactory.store(
    'sample_categories',
  ); 
  final _suggestStore = intMapStoreFactory.store('suggest_categories');

  // Khởi tạo DB
  Future<Database> get database async {
    if (_db != null) return _db!;
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, 'spend_flow.db');
    _db = await databaseFactoryIo.openDatabase(dbPath);
    return _db!;
  }

  // ------------------------------------------------------------
  // QUẢN LÝ CATEGORIES (DANH MỤC)
  // ------------------------------------------------------------

  /// Hàm khởi tạo dữ liệu mẫu khi chạy app lần đầu
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
      debugPrint("Đã nạp bảng SAMPLE: ${samples.length} mục.");
    }

    final suggestCount = await _suggestStore.count(db);
    if (suggestCount == 0) {
      final suggests = CategoryData.suggestedCategories;
      await db.transaction((txn) async {
        for (var cat in suggests) {
          await _suggestStore.add(txn, cat.toMap());
        }
      });
      debugPrint("Đã nạp bảng SUGGEST: ${suggests.length} mục.");
    }
  }

  List<CategoryModel> getDefaultSuggestions() {
    return CategoryData.suggestedCategories;
  }

  /// Lấy tất cả danh mục
  Future<List<CategoryModel>> getAllCategories() async {
    final db = await database;
    // Sắp xếp theo tên (tùy chọn)
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
      uniqueMap[cat.iconKey] = cat;
    }

    for (var cat in defaults) {
      if (!uniqueMap.containsKey(cat.iconKey)) {
        uniqueMap[cat.iconKey] = cat;
      }
    }

    return uniqueMap.values.toList();
  }

  Future<void> incrementCategoryUsage(CategoryModel category) async {
    final db = await database;

    final finder = Finder(filter: Filter.equals('iconKey', category.iconKey));
    final snapshot = await _sampleStore.findFirst(db, finder: finder);

    if (snapshot != null) {
      final current = CategoryModel.fromMap(snapshot.value);
      final updated = CategoryModel(
        name: current.name,
        l10nKey: current.l10nKey,
        iconKey: current.iconKey,
        color: current.color,
        count: current.count + 1, 
      );
      await _sampleStore.record(snapshot.key).update(db, updated.toMap());
    } else {
      await _sampleStore.add(db, category.toMap());
    }
  }

  /// Thêm danh mục mới
  Future<void> addCategory(CategoryModel category) async {
    final db = await database;
    await _sampleStore.add(db, category.toMap());
  }

  // ------------------------------------------------------------
  // QUẢN LÝ TRANSACTIONS (GIAO DỊCH)
  // ------------------------------------------------------------

  /// Lưu giao dịch mới
  Future<void> addTransaction(TransactionModel transaction) async {
    final db = await database;

    await _transactionStore.add(db, transaction.toMap());
    await incrementCategoryUsage(transaction.category);
  }

  /// Lấy tất cả giao dịch (Mới nhất lên đầu)
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await database;

    // Sắp xếp: date giảm dần (false) -> Mới nhất lên đầu
    final finder = Finder(sortOrders: [SortOrder('date', false)]);

    final snapshots = await _transactionStore.find(db, finder: finder);

    return snapshots.map((snapshot) {
      return TransactionModel.fromMap(snapshot.value);
    }).toList();
  }

  /// Lọc giao dịch theo tháng
  Future<List<TransactionModel>> getTransactionsByMonth(DateTime month) async {
    final db = await database;

    // Tạo khoảng thời gian: Ngày 1 tháng này -> Ngày 1 tháng sau
    final start = DateTime(month.year, month.month, 1).toIso8601String();
    final end = DateTime(month.year, month.month + 1, 1).toIso8601String();

    final finder = Finder(
      filter: Filter.and([
        Filter.greaterThanOrEquals('date', start),
        Filter.lessThan('date', end),
      ]),
      sortOrders: [SortOrder('date', false)],
    );

    final snapshots = await _transactionStore.find(db, finder: finder);
    return snapshots.map((s) => TransactionModel.fromMap(s.value)).toList();
  }

  /// Xóa toàn bộ giao dịch
  Future<void> deleteAllTransactions() async {
    final db = await database;
    await _transactionStore.delete(db);
  }
}
