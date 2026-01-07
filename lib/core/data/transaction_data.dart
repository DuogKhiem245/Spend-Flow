import 'package:flutter/cupertino.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/model/transaction_model.dart';

class TransactionData {
  static List<TransactionModel> getMockTransactions() {
    return [
      TransactionModel(
        walletId: UniqueKey().toString(),
        amount: 50.0,
        title: 'Ăn trưa',
        category: CategoryData.sampleCategories[0], 
        date: DateTime.now(),
        note: 'Ăn phở bò cùng đồng nghiệp',
        isIncome: false,
      ),
      TransactionModel(
        amount: 25.5,
        title: 'Grab đi làm',
        category: CategoryData.sampleCategories[1], 
        date: DateTime.now().subtract(const Duration(days: 1)),
        note: 'Trời mưa nên đi Grab',
        isIncome: false,
        walletId: UniqueKey().toString(),
      ),
      TransactionModel(
        amount: 3000.0,
        title: 'Lương tháng 10',
        category: CategoryData.sampleCategories[2],
        date: DateTime(2025, 10, 30),
        note: 'Nhận qua tài khoản ngân hàng',
        isIncome: true,
        walletId: UniqueKey().toString(),
      ),
      TransactionModel(
        amount: 120.0,
        title: 'Siêu thị cuối tuần',
        category: CategoryData.sampleCategories[3], 
        date: DateTime.now().subtract(const Duration(days: 2)),
        note: 'Mua đồ dùng cho cả tuần',
        isIncome: false,
        walletId: UniqueKey().toString(),
      ),
      TransactionModel(
        amount: 45.0,
        title: 'Xem phim',
        category: CategoryData.sampleCategories[4],
        date: DateTime.now().subtract(const Duration(hours: 4)),
        note: 'Xem phim Marvel mới ra',
        isIncome: false,
        walletId: UniqueKey().toString(),
      ),
    ];
  }
}
