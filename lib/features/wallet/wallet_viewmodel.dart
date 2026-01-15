import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/core/model/wallet_model.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';

class WalletViewModel extends ChangeNotifier {
  final LocalStorageService _localStorageService = LocalStorageService();

  WalletModel? _createdWallet;
  WalletModel? get createdWallet => _createdWallet;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> createWallet({
    required String name,
    required String currency,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final newWallet = WalletModel(
        name: name,
        currency: currency,
      );

      await _localStorageService.saveWallet(newWallet);

      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool('create_first_wallet', true);

      await prefs.setString('current_wallet_id', newWallet.id);

      _createdWallet = newWallet;

    } catch (e) {
      debugPrint("Error creating wallet: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkUserHasWallet() async {
    try {
      final localWallets = await _localStorageService.getAllWallets();
      if (localWallets.isNotEmpty) {
        return true;
      }

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('wallets')
          .where('isDeleted', isEqualTo: 0) 
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return true;
      }

      return false;
    } catch (e) {
      debugPrint("Error checking wallet (Local & Firebase): $e");
      return false;
    }
  }
}
