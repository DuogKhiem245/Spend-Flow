import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CategoryModel {
  final String id;
  final String name;
  final String? l10nKey;
  final String iconKey;
  final Color color;
  final int count;
  final bool isCustom;

  CategoryModel({
    String? id, 
    required this.name,
    this.l10nKey,
    required this.iconKey,
    required this.color,
    this.count = 0,
    this.isCustom = false,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'l10nKey': l10nKey,
      'iconKey': iconKey,
      'colorValue': color.value,
      'count': count,
      'isCustom': isCustom,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      l10nKey: map['l10nKey'],
      iconKey: map['iconKey'],
      color: Color(map['colorValue']),
      count: map['count'] ?? 0,
      isCustom: map['isCustom'] ?? false,
    );
  }
}
