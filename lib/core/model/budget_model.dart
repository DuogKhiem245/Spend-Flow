import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:uuid/uuid.dart';

class BudgetModel {
  final String id;
  final CategoryModel category;
  final double total;
  final double spent;
  final DateTime date;
  final String walletId;

  final int updatedAt;
  final bool isDeleted;

  BudgetModel({
    String? id,
    required this.category,
    required this.total,
    this.spent = 0.0,
    required this.date,
    required this.walletId,
    int? updatedAt,
    this.isDeleted = false,
  }) : id = id ?? const Uuid().v4(),
       updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

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
      'date': date.toIso8601String(),
      'walletId': walletId,
      'updatedAt': updatedAt,
      'isDeleted': isDeleted ? 1 : 0,
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map['id'],
      category: CategoryModel.fromMap(map['category']),
      total: (map['total'] as num?)?.toDouble() ?? 0.0,
      spent: 0.0,
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
      walletId: map['walletId'],
      updatedAt: _parseTime(map['updatedAt']),
      isDeleted: map['isDeleted'] == 1 || map['isDeleted'] == true,
    );
  }
  
  BudgetModel copyWith({
    String? id,
    CategoryModel? category,
    double? total,
    double? spent,
    DateTime? date,
    int? updatedAt,
    bool? isDeleted,
  }) {
    return BudgetModel(
      id: id ?? this.id,
      category: category ?? this.category,
      total: total ?? this.total,
      spent: spent ?? this.spent,
      date: date ?? this.date,
      walletId: walletId,
      updatedAt: updatedAt ?? DateTime.now().millisecondsSinceEpoch,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  factory BudgetModel.fromAIResponse({
    required Map<String, dynamic> aiData,
    required List<CategoryModel> availableCategories,
    required String currentWalletId,
  }) {
    final String? aiCategoryId = aiData['categoryId'];
    final category = availableCategories.firstWhere(
      (c) => c.id == aiCategoryId,
      orElse: () => availableCategories.firstWhere(
        (c) => c.name.toLowerCase().contains('orders') || c.id == 'others',
        orElse: () => availableCategories.first, 
      ),
    );

    DateTime parsedDate;
    try {
      parsedDate = aiData['date'] != null
          ? DateTime.parse(aiData['date'])
          : DateTime.now();
    } catch (e) {
      parsedDate = DateTime.now();
    }

    return BudgetModel(
      id: const Uuid().v4(), 
      category: category,
      total: (aiData['amount'] as num?)?.toDouble() ?? 0.0,
      spent: 0.0,
      date: parsedDate,
      walletId: currentWalletId, 
      updatedAt: DateTime.now().millisecondsSinceEpoch,
      isDeleted: false,
    );
  }

  static int _parseTime(dynamic value) {
    if (value is int) return value;
    if (value is Timestamp) {
      return value.millisecondsSinceEpoch;
    }
    return DateTime.now().millisecondsSinceEpoch;
  }
}
