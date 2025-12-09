import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String? l10nKey;
  final String iconKey;
  final Color color;
  final int count;

  CategoryModel({
    required this.name,
    this.l10nKey,
    required this.iconKey,
    required this.color,
    this.count = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'l10nKey': l10nKey,
      'iconKey': iconKey,
      'colorValue': color.value,
      'count': count,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'],
      l10nKey: map['l10nKey'],
      iconKey: map['iconKey'],
      color: Color(map['colorValue']),
      count: map['count'] ?? 0,
    );
  }
  
}
