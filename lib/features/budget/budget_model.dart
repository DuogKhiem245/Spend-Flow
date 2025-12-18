import 'package:flutter/material.dart';
import 'package:spend_flow/features/add_stransaction/model/category_model.dart';

class BudgetModel {
  final CategoryModel category;
  final double spent; 
  final double total; 

  BudgetModel({
    required this.category,
    required this.spent,
    required this.total,
  });

  String get name => category.name;
  Color get color => category.color;
  String get iconKey => category.iconKey;

  double get remaining => total - spent;
  double get progress => (total == 0) ? 0.0 : (spent / total).clamp(0.0, 1.0);

  Map<String, dynamic> toMap() {
    return {
      'category': category.toMap(),
      'total': total,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map, double currentSpent) {
    return BudgetModel(
      category: CategoryModel.fromMap(map['category']),
      total: map['total'] ?? 0.0,
      spent: currentSpent,
    );
  }
}
