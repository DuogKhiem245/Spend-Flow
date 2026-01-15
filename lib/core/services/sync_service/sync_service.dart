import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:spend_flow/core/model/budget_model.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/model/location_model.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/model/wallet_model.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/services/sync_service/image_sync_service.dart';

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

  final ValueNotifier<DateTime?> lastSyncNotifier = ValueNotifier(null);

  bool _isSyncing = false;
  DateTime? _lastRunTime;
  static const Duration _syncCooldown = Duration(minutes: 10);

  DocumentReference get _userRef {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");
    return _firestore.collection('users').doc(uid);
  }

  Future<void> syncData({bool force = false}) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final isPremium = await _localStorage.getPremiumStatus();
    if (!isPremium) {
      return;
    }

    if (_isSyncing) {
      return;
    }

    if (!force && _lastRunTime != null) {
      final difference = DateTime.now().difference(_lastRunTime!);
      if (difference < _syncCooldown) {
        return;
      }
    }

    _isSyncing = true;

    try {
      final lastSyncTimestamp = await _localStorage.getGlobalSyncTime();

      final queryTimestamp = lastSyncTimestamp > 30000
          ? lastSyncTimestamp - 30000
          : 0;

      await _pushCategories();
      await _pushWallets();
      await _pushLocationChanges();
      await _pushTransactions();
      await _pushBudgets();

      await _pullCategories(queryTimestamp);
      await _pullWallets(queryTimestamp);
      await _pullLocationChanges(queryTimestamp);
      await _pullTransactions(queryTimestamp);
      await _pullBudgets(queryTimestamp);

      _lastRunTime = DateTime.now();
      await _localStorage.saveGlobalSyncTime(
        DateTime.now().millisecondsSinceEpoch,
      );
      lastSyncNotifier.value = _lastRunTime;
    } catch (e) {
      debugPrint("Error Sync: $e");
    } finally {
      _isSyncing = false;
    }
  }

  Future<DateTime?> getLastSyncTime() async {
    final timestamp = await _localStorage.getGlobalSyncTime();
    if (timestamp == 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  Future<void> _pushCategories() async {
    final pending = await _localStorage.getPendingSyncCategories();
    if (pending.isEmpty) return;

    List<String> syncedIds = [];
    final userId = _auth.currentUser!.uid;

    for (var cat in pending) {
      CategoryModel catToSync = cat;

      if (cat.isCustom &&
          (cat.remoteIconUrl == null || cat.remoteIconUrl!.isEmpty)) {
        final url = await _imageService.uploadImage(cat.iconKey, userId);

        if (url != null) {
          catToSync = cat.copyWith(remoteIconUrl: url);
          await _localStorage.updateCategory(catToSync);
        }
      }

      try {
        final docRef = _userRef.collection('categories').doc(cat.id);
        Map<String, dynamic> data = catToSync.toMap();
        data['updatedAt'] = FieldValue.serverTimestamp();
        await docRef.set(data, SetOptions(merge: true));
        syncedIds.add(cat.id);
      } catch (e) {
        debugPrint("Error push category ${cat.name}: $e");
      }
    }

    if (syncedIds.isNotEmpty) {
      await _localStorage.removeSyncedCategories(syncedIds);
    }
  }

  Future<void> _pullCategories(int lastSyncTime) async {
    try {
      Query query = _userRef.collection('categories');

     // if (lastSyncTime > 0) {
      //   query = query.where('updatedAt', isGreaterThan: lastSyncTime);
      // }

      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) return;

      for (var doc in snapshot.docs) {
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
      }
    } catch (e) {
      debugPrint("Error Pull Categories: $e");
    }
  }

  Future<void> _pushWallets() async {
    final pending = await _localStorage.getPendingSyncWallets();
    if (pending.isEmpty) return;

    List<int> processedKeys = [];
    final batch = _firestore.batch();

    for (var item in pending) {
      final int key = item['key'];
      final data = Map<String, dynamic>.from(item)..remove('key');
      final wallet = WalletModel.fromMap(data);
      final docRef = _userRef.collection('wallets').doc(wallet.id);

      Map<String, dynamic> walletData = wallet.toMap();
      walletData['updatedAt'] = FieldValue.serverTimestamp();
      batch.set(docRef, walletData, SetOptions(merge: true));
      processedKeys.add(key);
    }

    try {
      await batch.commit();
      if (processedKeys.isNotEmpty) {
        await _localStorage.removeSyncedWallets(processedKeys);
      }
    } catch (e) {
      debugPrint("Error push wallets: $e");
    }
  }

  Future<void> _pullWallets(int lastSyncTime) async {
    try {
      Query query = _userRef.collection('wallets');

     // if (lastSyncTime > 0) {
      //   query = query.where('updatedAt', isGreaterThan: lastSyncTime);
      // }

      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) return;

      debugPrint("Kéo ${snapshot.docs.length} wallets về máy...");

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final cloudWallet = WalletModel.fromMap(data);

        if (cloudWallet.isDeleted) {
          await _localStorage.deleteWalletFromSync(cloudWallet.id);
        } else {
          await _localStorage.saveWalletFromSync(cloudWallet);
        }
      }
    } catch (e) {
      debugPrint("Error Pull Wallets: $e");
    }
  }

  Future<void> _pushLocationChanges() async {
    final pendingItems = await _localStorage.getPendingRecentLocations();

    if (pendingItems.isEmpty) return;

    List<int> processedKeys = [];
    final batch = _firestore.batch();

    for (var item in pendingItems) {
      final int key = item['key'];
      final String action = item['action'];
      final Map<String, dynamic> data = item['data'];

      try {
        if (action == 'UPSERT') {
          final location = RecentLocationModel.fromMap(data);
          final docRef = _userRef
              .collection('recent_locations')
              .doc(location.id);

          batch.set(docRef, location.toMap(), SetOptions(merge: true));
        }

        processedKeys.add(key);
      } catch (e) {
        debugPrint("Error preparing item $key: $e");
      }
    }

    try {
      await batch.commit();

      if (processedKeys.isNotEmpty) {
        await _localStorage.removeSyncedRecentLocations(processedKeys);
      }
    } catch (e) {
      debugPrint("Error Batch Commit Recent Locations: $e");
    }
  }

  Future<void> _pullLocationChanges(int lastSyncTime) async {
    try {
      Query query = _userRef.collection('recent_locations');

      if (lastSyncTime > 0) {
        query = query.where('timestamp', isGreaterThan: lastSyncTime);
      }

      query = query.orderBy('timestamp', descending: true).limit(20);

      final snapshot = await query.get();

      if (snapshot.docs.isEmpty) return;

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final location = RecentLocationModel.fromMap(data);

        await _localStorage.saveSyncedRecentLocation(location);
      }
    } catch (e) {
      debugPrint("Error loading Recent Locations from Server: $e");
    }
  }

  Future<void> _pushTransactions() async {
    final pending = await _localStorage.getPendingSyncTransactions();
    if (pending.isEmpty) return;

    List<int> processedKeys = [];
    final batch = _firestore.batch();

    for (var item in pending) {
      final int key = item['key'];
      final data = Map<String, dynamic>.from(item)..remove('key');
      final tx = TransactionModel.fromMap(data);

      final docRef = _userRef.collection('transactions').doc(tx.id);

      Map<String, dynamic> txData = tx.toMap();
      txData['updatedAt'] = FieldValue.serverTimestamp();

      batch.set(docRef, txData, SetOptions(merge: true));
      processedKeys.add(key);
    }

    try {
      await batch.commit();
      if (processedKeys.isNotEmpty) {
        await _localStorage.removeSyncedTransactions(processedKeys);
      }
    } catch (e) {
      debugPrint("Error push transactions: $e");
    }
  }

  Future<void> _pullTransactions(int lastSyncTime) async {
    try {
      Query query = _userRef.collection('transactions');

      // if (lastSyncTime > 0) {
      //   query = query.where('updatedAt', isGreaterThan: lastSyncTime);
      // }

      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) return;

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final tx = TransactionModel.fromMap(data);

        if (tx.isDeleted) {
          await _localStorage.deleteTransactionFromSync(tx.id);
        } else {
          await _localStorage.saveTransactionFromSync(tx);
        }
      }
    } catch (e) {
      debugPrint("Error Pull Transactions: $e");
    }
  }

  Future<void> _pushBudgets() async {
    final pending = await _localStorage.getPendingSyncBudgets();
    if (pending.isEmpty) return;

    List<int> processedKeys = [];
    final batch = _firestore.batch();

    for (var item in pending) {
      final int key = item['key'];
      final data = Map<String, dynamic>.from(item)..remove('key');

      final budget = BudgetModel.fromMap(data);
      final docRef = _userRef.collection('budgets').doc(budget.id);

      Map<String, dynamic> budgetData = budget.toMap();

      budgetData['updatedAt'] = FieldValue.serverTimestamp();
      batch.set(docRef, budgetData, SetOptions(merge: true));
      processedKeys.add(key);
    }

    try {
      await batch.commit();
      await _localStorage.removeSyncedBudgets(processedKeys);
    } catch (e) {
      debugPrint("Error push budgets: $e");
    }
  }

  Future<void> _pullBudgets(int lastSyncTime) async {
    try {
      Query query = _userRef.collection('budgets');

     // if (lastSyncTime > 0) {
      //   query = query.where('updatedAt', isGreaterThan: lastSyncTime);
      // }

      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) return;

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final cloudBudget = BudgetModel.fromMap(data);

        if (cloudBudget.isDeleted) {
          await _localStorage.deleteBudgetFromSync(cloudBudget.id);
        } else {
          await _localStorage.saveBudgetFromSync(cloudBudget);
        }
      }
    } catch (e) {
      debugPrint("Error pull budgets: $e");
    }
  }
}
