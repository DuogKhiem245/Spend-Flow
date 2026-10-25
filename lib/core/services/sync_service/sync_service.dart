import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/core/model/budget_model.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/model/location_model.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/model/wallet_model.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/services/sync_service/image_sync_service.dart';
import 'package:spend_flow/core/services/widget_sync_service.dart';
import 'package:spend_flow/main.dart';

class SyncService {
  static final SyncService _instance = SyncService._internal();

  factory SyncService() {
    return _instance;
  }

  SyncService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocalStorageService _localStorage = LocalStorageService();
  final ImageSyncService _imageService = ImageSyncService();
  final _premiumViewModel = premiumViewModel;

  final ValueNotifier<DateTime?> lastSyncNotifier = ValueNotifier(null);

  bool _isSyncing = false;
  DateTime? _lastRunTime;
  static const Duration _windowDuration = Duration(minutes: 10);
  static const Duration _lockDuration = Duration(minutes: 15);
  static const int _maxClicks = 3;

  DocumentReference get _userRef {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");
    return _firestore.collection('data_sync').doc(uid);
  }

  Future<String?> syncData({bool isAds = false}) async {
    if (_isSyncing) {
      return "sync_in_progress";
    }

    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final nowMs = now.millisecondsSinceEpoch;

    // 1. Kiểm tra trạng thái bị khoá 15 phút
    final lockedUntilMs = prefs.getInt('sync_locked_until') ?? 0;
    if (nowMs < lockedUntilMs) {
      final remainingSeconds = ((lockedUntilMs - nowMs) / 1000).ceil();
      return "cooldown:$remainingSeconds";
    }

    // Đã hết 15 phút khoá: tự động reset lượt
    if (lockedUntilMs > 0 && nowMs >= lockedUntilMs) {
      await prefs.remove('sync_locked_until');
      await prefs.setInt('sync_click_count', 0);
      await prefs.remove('sync_window_start_time');
    }

    // 2. Kiểm tra nếu là tài khoản Free chưa xem quảng cáo (giới hạn 1 lần/ngày)
    final isPremium = _premiumViewModel.isPremium;
    if (!isPremium && isAds == false) {
      final lastGlobalSync = await _localStorage.getGlobalSyncTime();
      if (lastGlobalSync > 0) {
        final lastDate = DateTime.fromMillisecondsSinceEpoch(lastGlobalSync);
        final isSameDay = lastDate.year == now.year &&
            lastDate.month == now.month &&
            lastDate.day == now.day;
        if (isSameDay) {
          return "premium_required";
        }
      }
    }

    // 3. Quản lý cửa sổ trượt 10 phút và số lượt bấm (tối đa 3 lượt)
    int clickCount = prefs.getInt('sync_click_count') ?? 0;
    final windowStartMs = prefs.getInt('sync_window_start_time') ?? 0;

    // Nếu đã quá 10 phút kể từ lần bấm trước mà chưa đủ 3 lượt -> reset lại chu kỳ mới
    if (windowStartMs > 0 && (nowMs - windowStartMs) > _windowDuration.inMilliseconds) {
      clickCount = 0;
    }

    // Tăng số lượt bấm
    clickCount += 1;

    // Nếu đạt lượt thứ 3 -> Cho phép thực hiện và khoá 15 phút
    if (clickCount >= _maxClicks) {
      final lockEndTimeMs = nowMs + _lockDuration.inMilliseconds;
      await prefs.setInt('sync_locked_until', lockEndTimeMs);
      await prefs.setInt('sync_click_count', 0);
      await prefs.remove('sync_window_start_time');
    } else {
      // Chưa đạt 3 lượt -> Ghi nhận lượt bấm và reset thời gian đếm 10 phút từ mốc bấm này
      await prefs.setInt('sync_click_count', clickCount);
      await prefs.setInt('sync_window_start_time', nowMs);
    }

    _isSyncing = true;

    try {
      final lastSyncTimestamp = await _localStorage.getGlobalSyncTime();
      final bool isInitialSync = (lastSyncTimestamp == 0);

      final queryTimestamp = lastSyncTimestamp > 30000
          ? lastSyncTimestamp - 30000
          : 0;

      // 1. Pull các cập nhật từ Cloud về
      await _pullCategories(queryTimestamp);
      await _pullWallets(queryTimestamp);
      await _pullLocationChanges(queryTimestamp);
      await _pullTransactions(queryTimestamp);
      await _pullBudgets(queryTimestamp);

      // 2. Push dữ liệu local lên Cloud
      await _pushCategories(isInitialSync);
      await _pushWallets(isInitialSync);
      await _pushLocationChanges();
      await _pushTransactions(isInitialSync);
      await _pushBudgets(isInitialSync);

      _lastRunTime = DateTime.now();
      await _localStorage.saveGlobalSyncTime(
        DateTime.now().millisecondsSinceEpoch,
      );
      lastSyncNotifier.value = _lastRunTime;

      // 3. Thông báo cập nhật UI và Widgets
      _localStorage.notifyTransactionChanged();
      try {
        await WidgetSyncService().updateAllWidgets();
      } catch (e) {
        debugPrint("Error update widgets after sync: $e");
      }

      return null;
    } catch (e) {
      debugPrint("SyncData error: $e");
      return "error:${e.toString()}";
    } finally {
      _isSyncing = false;
    }
  }

  Future<DateTime?> getLastSyncTime() async {
    final timestamp = await _localStorage.getGlobalSyncTime();
    if (timestamp == 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Helper chia nhỏ batch commit để không vượt quá giới hạn 500 documents của Firestore
  Future<void> _commitInChunks<T>(
    List<T> items,
    void Function(WriteBatch batch, T item) action,
  ) async {
    const int chunkSize = 400;
    for (int i = 0; i < items.length; i += chunkSize) {
      final batch = _firestore.batch();
      final end = (i + chunkSize < items.length) ? i + chunkSize : items.length;
      final chunk = items.sublist(i, end);
      for (var item in chunk) {
        action(batch, item);
      }
      await batch.commit();
    }
  }

  // ============================================================
  // CATEGORIES
  // ============================================================

  Future<void> _pushCategories(bool isInitialSync) async {
    final pending = await _localStorage.getPendingSyncCategories();

    List<CategoryModel> categoriesToPush = [];
    List<String> syncedIds = [];

    if (pending.isNotEmpty) {
      categoriesToPush = pending;
    } else if (isInitialSync) {
      categoriesToPush = await _localStorage.getAllCustomCategories();
    }

    if (categoriesToPush.isEmpty) return;

    final userId = _auth.currentUser!.uid;

    for (var cat in categoriesToPush) {
      CategoryModel catToSync = cat;

      if (cat.isCustom &&
          (cat.remoteIconUrl == null || cat.remoteIconUrl!.isEmpty)) {
        final url = await _imageService.uploadImage(cat.iconKey, userId);
        if (url != null) {
          catToSync = cat.copyWith(remoteIconUrl: url);
          await _localStorage.updateCategory(catToSync);
        }
      }

      final docRef = _userRef.collection('categories').doc(cat.id);
      Map<String, dynamic> data = catToSync.toMap();
      data['updatedAt'] = FieldValue.serverTimestamp();
      await docRef.set(data, SetOptions(merge: true));
      syncedIds.add(cat.id);
    }

    if (pending.isNotEmpty && syncedIds.isNotEmpty) {
      await _localStorage.removeSyncedCategories(syncedIds);
    }
  }

  Future<void> _pullCategories(int lastSyncTime) async {
    Query query = _userRef.collection('categories');

    if (lastSyncTime > 0) {
      final queryTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        lastSyncTime,
      );
      query = query.where('updatedAt', isGreaterThan: queryTimestamp);
    }

    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) return;

    for (var doc in snapshot.docs) {
      try {
        final data = doc.data() as Map<String, dynamic>;
        var cloudCat = CategoryModel.fromMap(data);

        if (cloudCat.isDeleted) {
          await _localStorage.deleteCategoryFromSync(cloudCat.id);
          continue;
        }

        if (cloudCat.isCustom &&
            cloudCat.remoteIconUrl != null &&
            cloudCat.remoteIconUrl!.isNotEmpty) {
          final isFileExist = await _localStorage.checkIconExists(
            cloudCat.iconKey,
          );

          if (!isFileExist) {
            final savedName = await _imageService.downloadImageToLocal(
              cloudCat.remoteIconUrl!,
              cloudCat.iconKey,
            );
            if (savedName != null) {
              cloudCat = cloudCat.copyWith(iconKey: savedName);
            }
          }
        }
        await _localStorage.saveCategoryFromSync(cloudCat);
      } catch (e) {
        debugPrint("Error Pull Category ${doc.id}: $e");
      }
    }
  }

  // ============================================================
  // WALLETS
  // ============================================================

  Future<void> _pushWallets(bool isInitialSync) async {
    final pending = await _localStorage.getPendingSyncWallets();

    if (pending.isNotEmpty) {
      List<int> processedKeys = [];
      await _commitInChunks(pending, (batch, item) {
        final int key = item['key'];
        final data = Map<String, dynamic>.from(item)..remove('key');
        final wallet = WalletModel.fromMap(data);
        final docRef = _userRef.collection('wallets').doc(wallet.id);

        Map<String, dynamic> walletData = wallet.toMap();
        walletData['updatedAt'] = FieldValue.serverTimestamp();
        batch.set(docRef, walletData, SetOptions(merge: true));
        processedKeys.add(key);
      });

      if (processedKeys.isNotEmpty) {
        await _localStorage.removeSyncedWallets(processedKeys);
      }
    } else if (isInitialSync) {
      final allWallets = await _localStorage.getAllWallets();
      if (allWallets.isNotEmpty) {
        await _commitInChunks(allWallets, (batch, wallet) {
          final docRef = _userRef.collection('wallets').doc(wallet.id);
          Map<String, dynamic> walletData = wallet.toMap();
          walletData['updatedAt'] = FieldValue.serverTimestamp();
          batch.set(docRef, walletData, SetOptions(merge: true));
        });
      }
    }
  }

  Future<void> _pullWallets(int lastSyncTime) async {
    Query query = _userRef.collection('wallets');

    if (lastSyncTime > 0) {
      final queryTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        lastSyncTime,
      );
      query = query.where('updatedAt', isGreaterThan: queryTimestamp);
    }

    final snapshot = await query.get();
    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          final cloudWallet = WalletModel.fromMap(data);

          if (cloudWallet.isDeleted) {
            await _localStorage.deleteWalletFromSync(cloudWallet.id);
          } else {
            await _localStorage.saveWalletFromSync(cloudWallet);
          }
        } catch (e) {
          debugPrint("Error Pull Wallet ${doc.id}: $e");
        }
      }
    }

    // Đảm bảo SharedPreferences có current_wallet_id hợp lệ sau khi clone về
    final prefs = await SharedPreferences.getInstance();
    final currentWalletId = prefs.getString('current_wallet_id');
    final allWallets = await _localStorage.getAllWallets();
    if (allWallets.isNotEmpty) {
      if (currentWalletId == null ||
          !allWallets.any((w) => w.id == currentWalletId)) {
        await prefs.setString('current_wallet_id', allWallets.first.id);
        await prefs.setBool('create_first_wallet', true);
      }
    }
  }

  // ============================================================
  // RECENT LOCATIONS
  // ============================================================

  Future<void> _pushLocationChanges() async {
    final pendingItems = await _localStorage.getPendingRecentLocations();
    if (pendingItems.isEmpty) return;

    List<int> processedKeys = [];
    await _commitInChunks(pendingItems, (batch, item) {
      final int key = item['key'];
      final String action = item['action'];
      final Map<String, dynamic> data = item['data'];

      if (action == 'UPSERT') {
        final location = RecentLocationModel.fromMap(data);
        final docRef = _userRef
            .collection('recent_locations')
            .doc(location.id);
        batch.set(docRef, location.toMap(), SetOptions(merge: true));
      }
      processedKeys.add(key);
    });

    if (processedKeys.isNotEmpty) {
      await _localStorage.removeSyncedRecentLocations(processedKeys);
    }
  }

  Future<void> _pullLocationChanges(int lastSyncTime) async {
    Query query = _userRef.collection('recent_locations');

    if (lastSyncTime > 0) {
      final queryTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        lastSyncTime,
      );
      query = query.where('timestamp', isGreaterThan: queryTimestamp);
    }

    query = query.orderBy('timestamp', descending: true).limit(20);

    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) return;

    for (var doc in snapshot.docs) {
      try {
        final data = doc.data() as Map<String, dynamic>;
        final location = RecentLocationModel.fromMap(data);
        await _localStorage.saveSyncedRecentLocation(location);
      } catch (e) {
        debugPrint("Error Pull Location ${doc.id}: $e");
      }
    }
  }

  // ============================================================
  // TRANSACTIONS
  // ============================================================

  Future<void> _pushTransactions(bool isInitialSync) async {
    final pending = await _localStorage.getPendingSyncTransactions();

    if (pending.isNotEmpty) {
      List<int> processedKeys = [];
      await _commitInChunks(pending, (batch, item) {
        final int key = item['key'];
        final data = Map<String, dynamic>.from(item)..remove('key');
        final tx = TransactionModel.fromMap(data);

        final docRef = _userRef.collection('transactions').doc(tx.id);
        Map<String, dynamic> txData = tx.toMap();
        txData['updatedAt'] = FieldValue.serverTimestamp();

        batch.set(docRef, txData, SetOptions(merge: true));
        processedKeys.add(key);
      });

      if (processedKeys.isNotEmpty) {
        await _localStorage.removeSyncedTransactions(processedKeys);
      }
    } else if (isInitialSync) {
      final allActive = await _localStorage.getAllActiveTransactions();
      if (allActive.isNotEmpty) {
        await _commitInChunks(allActive, (batch, tx) {
          final docRef = _userRef.collection('transactions').doc(tx.id);
          Map<String, dynamic> txData = tx.toMap();
          txData['updatedAt'] = FieldValue.serverTimestamp();
          batch.set(docRef, txData, SetOptions(merge: true));
        });
      }
    }
  }

  Future<void> _pullTransactions(int lastSyncTime) async {
    Query query = _userRef.collection('transactions');

    if (lastSyncTime > 0) {
      final queryTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        lastSyncTime,
      );
      query = query.where('updatedAt', isGreaterThan: queryTimestamp);
    }

    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) return;

    for (var doc in snapshot.docs) {
      try {
        final data = doc.data() as Map<String, dynamic>;
        final tx = TransactionModel.fromMap(data);

        if (tx.isDeleted) {
          await _localStorage.deleteTransactionFromSync(tx.id);
        } else {
          await _localStorage.saveTransactionFromSync(tx);
        }
      } catch (e) {
        debugPrint("Error Pull Transaction ${doc.id}: $e");
      }
    }
  }

  // ============================================================
  // BUDGETS
  // ============================================================

  Future<void> _pushBudgets(bool isInitialSync) async {
    final pending = await _localStorage.getPendingSyncBudgets();

    if (pending.isNotEmpty) {
      List<int> processedKeys = [];
      await _commitInChunks(pending, (batch, item) {
        final int key = item['key'];
        final data = Map<String, dynamic>.from(item)..remove('key');
        final budget = BudgetModel.fromMap(data);

        final docRef = _userRef.collection('budgets').doc(budget.id);
        Map<String, dynamic> budgetData = budget.toMap();
        budgetData['updatedAt'] = FieldValue.serverTimestamp();

        batch.set(docRef, budgetData, SetOptions(merge: true));
        processedKeys.add(key);
      });

      if (processedKeys.isNotEmpty) {
        await _localStorage.removeSyncedBudgets(processedKeys);
      }
    } else if (isInitialSync) {
      final allBudgets = await _localStorage.getAllActiveBudgets();
      if (allBudgets.isNotEmpty) {
        await _commitInChunks(allBudgets, (batch, budget) {
          final docRef = _userRef.collection('budgets').doc(budget.id);
          Map<String, dynamic> budgetData = budget.toMap();
          budgetData['updatedAt'] = FieldValue.serverTimestamp();
          batch.set(docRef, budgetData, SetOptions(merge: true));
        });
      }
    }
  }

  Future<void> _pullBudgets(int lastSyncTime) async {
    Query query = _userRef.collection('budgets');

    if (lastSyncTime > 0) {
      final queryTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        lastSyncTime,
      );
      query = query.where('updatedAt', isGreaterThan: queryTimestamp);
    }

    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) return;

    for (var doc in snapshot.docs) {
      try {
        final data = doc.data() as Map<String, dynamic>;
        final cloudBudget = BudgetModel.fromMap(data);

        if (cloudBudget.isDeleted) {
          await _localStorage.deleteBudgetFromSync(cloudBudget.id);
        } else {
          await _localStorage.saveBudgetFromSync(cloudBudget);
        }
      } catch (e) {
        debugPrint("Error Pull Budget ${doc.id}: $e");
      }
    }
  }
}
