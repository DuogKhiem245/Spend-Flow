import 'package:flutter/cupertino.dart';
import 'package:spend_flow/features/add_stransaction/model/category_model.dart';

class SpendingModel {
  final String category;
  final double amount;
  final Color color;
  final CategoryModel? originalCategory;

  SpendingModel({
    required this.category,
    required this.amount,
    required this.color,
    this.originalCategory,
  });

  SpendingModel copyWith({String? category, double? amount, Color? color}) {
    return SpendingModel(
      category: category ?? this.category,
      amount: amount ?? this.amount,
      color: color ?? this.color,
    );
  }
}

class RecentTransactionModel {
  final Icon icon;
  final String title;
  final String category;
  final double amount;
  final DateTime date;
  final bool isExpense;

  RecentTransactionModel({
    required this.icon,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.isExpense,
  });
}

class TransactionItem {
  final String title;
  final String category;
  final String time;
  final double amount;
  final IconData icon;
  final Color color;

  TransactionItem(
    this.title,
    this.category,
    this.time,
    this.amount,
    this.icon,
    this.color,
  );
}
