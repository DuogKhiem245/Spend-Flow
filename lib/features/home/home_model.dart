import 'dart:ui';

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


