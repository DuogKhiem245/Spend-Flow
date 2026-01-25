import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/model/budget_model.dart';

class AddBudgetViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();

  Future<String?> _getCurrentWalletId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_wallet_id');
  }

  Future<void> saveBudget({
    required String amount,
    required CategoryModel category,
    required DateTime date,
    String? idToUpdate, 
    String? note,
  }) async {
    final double parsedAmount = _parseAmount(amount);

    final walletId = await _getCurrentWalletId();

    if (walletId == null) {
      debugPrint("Lỗi: Không tìm thấy ví hiện tại");
      return;
    }

    if (idToUpdate != null) {
      final updatedBudget = BudgetModel(
        walletId: walletId,
        id: idToUpdate, 
        category: category,
        total: parsedAmount,
        date: date,
        note: note ?? '',
      );
      
      await _storage.updateBudget(updatedBudget);

    } else {

      final newBudget = BudgetModel(
        walletId: walletId,
        category: category,
        total: parsedAmount,
        date: date,
        note: note ?? '',
      );
      
      await _storage.saveBudget(newBudget);
    }
  }

  double _parseAmount(String input) {
    if (input.isEmpty) return 0.0;
    String cleanString = input.replaceAll('.', '');
    cleanString = cleanString.replaceAll(',', '.');
    return double.tryParse(cleanString) ?? 0.0;
  }
}
