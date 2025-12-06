import 'dart:ui';

import 'package:flutter/cupertino.dart';

class SpendingModel {
  final String category;
  final double amount;
  final Color color;

  SpendingModel({
    required this.category,
    required this.amount,
    required this.color,
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
