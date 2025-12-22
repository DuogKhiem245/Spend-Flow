import 'package:flutter/material.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:uuid/uuid.dart'; 

class BudgetModel {
  final String id; 
  final CategoryModel category;
  final double total; 
  final double spent; 
  final DateTime date;

  BudgetModel({
    String? id,
    required this.category,
    required this.total,
    this.spent = 0.0, 
    required this.date,
  }) : id = id ?? const Uuid().v4(); 

  String get name => category.name;
  Color get color => category.color;
  String get iconKey => category.iconKey;

  double get remaining => total - spent;

  double get progress => (total == 0) ? 0.0 : (spent / total).clamp(0.0, 1.0);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category.toMap(),
      'total': total,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'],
      category: CategoryModel.fromMap(map['category']),
      total: (map['total'] as num?)?.toDouble() ?? 0.0,
      spent: 0.0,
      date: DateTime.now(),
    );
  }

  BudgetModel copyWith({
    String? id,
    CategoryModel? category,
    double? total,
    double? spent,
    DateTime? date,
  }) {
    return BudgetModel(
      id: id ?? this.id,
      category: category ?? this.category,
      total: total ?? this.total,
      spent: spent ?? this.spent,
      date: date ?? this.date,
    );
  }
}
