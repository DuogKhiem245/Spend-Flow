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
}
