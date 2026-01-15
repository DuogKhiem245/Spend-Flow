import 'package:cloud_firestore/cloud_firestore.dart';
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
  final String? remoteIconUrl;

  final bool isDeleted; 
  final int updatedAt; 

  CategoryModel({
    String? id,
    required this.name,
    this.l10nKey,
    required this.iconKey,
    required this.color,
    this.count = 0,
    this.isCustom = false,
    this.remoteIconUrl,
    this.isDeleted = false,
    int? updatedAt,
  }) : id = id ?? const Uuid().v4(),
       updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  CategoryModel copyWith({
    String? id,
    String? name,
    String? l10nKey,
    String? iconKey,
    Color? color,
    int? count,
    bool? isCustom,
    String? remoteIconUrl,
    bool? isDeleted,
    int? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      l10nKey: l10nKey ?? this.l10nKey,
      iconKey: iconKey ?? this.iconKey,
      color: color ?? this.color,
      count: count ?? this.count,
      isCustom: isCustom ?? this.isCustom,
      remoteIconUrl: remoteIconUrl ?? this.remoteIconUrl,
      updatedAt: updatedAt ?? DateTime.now().millisecondsSinceEpoch,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'l10nKey': l10nKey,
      'iconKey': iconKey,
      'colorValue': color.value,
      'count': count,
      'isCustom': isCustom ? 1 : 0,
      'remoteIconUrl': remoteIconUrl,

      'isDeleted': isDeleted ? 1 : 0,
      'updatedAt': updatedAt,
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

      isCustom: map['isCustom'] == 1 || map['isCustom'] == true,
      remoteIconUrl: map['remoteIconUrl'],

      isDeleted: map['isDeleted'] == 1 || map['isDeleted'] == true,
      updatedAt: _parseTime(map['updatedAt']),
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
