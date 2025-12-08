import 'package:spend_flow/features/add_stransaction/model/category_model.dart';

class TransactionModel {
  final double amount;
  final String title;
  final CategoryModel category;
  final DateTime date;
  final String note;

  TransactionModel({
    required this.amount,
    required this.title,
    required this.category,
    required this.date,
    required this.note,
  });

  static List<TransactionModel> getMockTransactions() {
    return [
      TransactionModel(
        amount: 50.0,
        title: 'Ăn trưa',
        category: CategoryModel.sampleCategories[0],
        date: DateTime.now(),
        note: 'Ăn phở bò cùng đồng nghiệp',
      ),
      TransactionModel(
        amount: 25.5,
        title: 'Grab đi làm',
        category: CategoryModel.sampleCategories[1],
        date: DateTime.now().subtract(const Duration(days: 1)),
        note: 'Trời mưa nên đi Grab',
      ),
      TransactionModel(
        amount: 3000.0,
        title: 'Lương tháng 10',
        category: CategoryModel.sampleCategories[2],
        date: DateTime(2025, 10, 30),
        note: 'Nhận qua tài khoản ngân hàng',
      ),
      TransactionModel(
        amount: 120.0,
        title: 'Siêu thị cuối tuần',
        category: CategoryModel.sampleCategories[3],
        date: DateTime.now().subtract(const Duration(days: 2)),
        note: 'Mua đồ dùng cho cả tuần',
      ),
      TransactionModel(
        amount: 45.0,
        title: 'Xem phim',
        category: CategoryModel.sampleCategories[4],
        date: DateTime.now().subtract(const Duration(hours: 4)),
        note: 'Xem phim Marvel mới ra',
      ),
    ];
  }
}
