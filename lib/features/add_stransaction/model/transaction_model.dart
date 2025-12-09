import 'package:spend_flow/features/add_stransaction/model/category_model.dart';

class TransactionModel {
  final double amount;
  final String title;
  final CategoryModel category;
  final DateTime date;
  final String note;
  final bool isIncome;

  TransactionModel({
    required this.amount,
    required this.title,
    required this.category,
    required this.date,
    required this.note,
    required this.isIncome,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'title': title,
      'note': note,
      'date': date.toIso8601String(), 
      'category': category.toMap(), 
      'isIncome': isIncome,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      amount: map['amount'],
      title: map['title'],
      note: map['note'],
      date: DateTime.parse(map['date']),
      category: CategoryModel.fromMap(map['category']),
      isIncome: map['isIncome'],
    );
  }
}
