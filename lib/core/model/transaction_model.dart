import 'package:spend_flow/core/model/category_model.dart';
import 'package:uuid/uuid.dart'; 

class TransactionModel {
  final String id;
  final double amount;
  final String title;
  final CategoryModel category;
  final DateTime date;
  final String note;
  final bool isIncome;

  final String currency; 
  final double exchangeRate;

  TransactionModel({
    String?
    id, 
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.note,
    required this.isIncome,
    this.currency = 'USD',
    this.exchangeRate = 1.0,
  }) : id = id ?? const Uuid().v4(); 

  double get valueInBaseCurrency => amount * exchangeRate;

  Map<String, dynamic> toMap() {
    return {
      'id': id, 
      'amount': amount,
      'title': title,
      'note': note,
      'date': date.toIso8601String(),
      'category': category.toMap(),
      'isIncome': isIncome,
      'currency': currency,
      'exchangeRate': exchangeRate,
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
      currency: map['currency'],
      exchangeRate: map['exchangeRate'],
    );
  }
}
