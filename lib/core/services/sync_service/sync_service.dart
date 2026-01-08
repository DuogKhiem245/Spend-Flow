import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/core/model/category_model.dart';
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
  final LocalStorageService _localDb = LocalStorageService();
  final ImageSyncService _imageService = ImageSyncService();

  bool _isSyncing = false;
  DateTime? _lastRunTime;
  static const Duration _syncCooldown = Duration(minutes: 5);

  DocumentReference get _userRef {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");
    return _firestore.collection('users').doc(uid);
  }

  Future<void> syncData({bool force = false}) async {
    final user = _auth.currentUser;
    if (user == null) return;

    if (_isSyncing) {
      debugPrint("Sync đang chạy, bỏ qua yêu cầu mới.");
      return;
    }

    if (!force && _lastRunTime != null) {
      final difference = DateTime.now().difference(_lastRunTime!);
      if (difference < _syncCooldown) {
        debugPrint(
          "Vừa sync cách đây ${difference.inMinutes} phút. Bỏ qua (Cooldown).",
        );
        return;
      }
    }

    _isSyncing = true;

    try {
      debugPrint("Bắt đầu tiến trình Sync...");
      await _pushCategories();
      await _pullCategories();
      _lastRunTime = DateTime.now();
      debugPrint("Sync hoàn tất.");
    } catch (e) {
      debugPrint("Lỗi Sync: $e");
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _pushCategories() async {
    final pending = await _localDb.getPendingSyncCategories();
    if (pending.isEmpty) return;

    debugPrint("⬆️ Đẩy ${pending.length} categories lên Cloud.");

    List<String> syncedIds = [];
    final userId = _auth.currentUser!.uid;

    for (var cat in pending) {
      CategoryModel catToSync = cat;

      if (cat.isCustom &&
          (cat.remoteIconUrl == null || cat.remoteIconUrl!.isEmpty)) {
        final url = await _imageService.uploadImage(cat.iconKey, userId);

        if (url != null) {
          catToSync = cat.copyWith(remoteIconUrl: url);
          await _localDb.updateCategory(catToSync);
        }
      }

      try {
        final docRef = _userRef.collection('categories').doc(cat.id);
        await docRef.set(catToSync.toMap(), SetOptions(merge: true));
        syncedIds.add(cat.id);
      } catch (e) {
        debugPrint("Lỗi push category ${cat.name}: $e");
      }
    }

    if (syncedIds.isNotEmpty) {
      await _localDb.removeSyncedCategories(syncedIds);
    }
  }

  Future<void> _pullCategories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastSyncTime = prefs.getInt('last_sync_time_categories') ?? 0;

      Query query = _userRef.collection('categories');

      if (lastSyncTime > 0) {
        query = query.where('updatedAt', isGreaterThan: lastSyncTime);
      }

      final snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        return;
      }

      debugPrint("⬇️ Kéo ${snapshot.docs.length} categories về máy...");

      int maxUpdatedAt = lastSyncTime;

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        var cloudCat = CategoryModel.fromMap(data);

        if (cloudCat.updatedAt > maxUpdatedAt) {
          maxUpdatedAt = cloudCat.updatedAt;
        }

        if (cloudCat.isDeleted) {
          await _localDb.deleteCategoryFromSync(cloudCat.id);
          continue;
        }

        if (cloudCat.isCustom &&
            cloudCat.remoteIconUrl != null &&
            cloudCat.remoteIconUrl!.isNotEmpty) {
          final isFileExist = await _localDb.checkIconExists(cloudCat.iconKey);

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

        await _localDb.saveCategoryFromSync(cloudCat);
      }

      await prefs.setInt('last_sync_time_categories', maxUpdatedAt);
    } catch (e) {
      debugPrint("Lỗi Pull Categories: $e");
    }
  }
}
