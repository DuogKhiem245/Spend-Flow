import 'package:spend_flow/features/add_stransaction/model/category_model.dart';
import 'package:uuid/uuid.dart'; 

class TransactionModel {
  final String id;
  final double amount;
  final String title;
  final CategoryModel category;
  final DateTime date;
  final String note;
  final bool isIncome;

  TransactionModel({
    String?
    id, 
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.note,
    required this.isIncome,
  }) : id = id ?? const Uuid().v4(); 

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Lưu ID vào map
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
      id: map['id'], 
      amount: map['amount'],
      title: map['title'],
      note: map['note'],
      date: DateTime.parse(map['date']),
      category: CategoryModel.fromMap(map['category']),
      isIncome: map['isIncome'],
    );
  }
}
