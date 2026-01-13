import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/model/location_model.dart';
import 'package:uuid/uuid.dart';

class TransactionModel {
  final String id;
  final double amount;
  final String title;
  final CategoryModel category;
  final DateTime date;
  final String note;
  final bool isIncome;

  final LocationModel location;

  final String currency;
  final double exchangeRate;

  final String walletId;

  TransactionModel({
    String? id,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.note,
    required this.isIncome,
    required this.walletId,
    this.currency = 'USD',
    this.exchangeRate = 1.0,
    this.location = const LocationModel(),
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
      'walletId': walletId,
      'location': location.toMap(),
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
      walletId: map['walletId'],
      location: LocationModel.fromMap(map['location']),
    );
  }

  factory TransactionModel.fromAIResponse({
    required Map<String, dynamic> aiData,
    required List<CategoryModel> availableCategories,
  }) {
    final String? aiCategoryId = aiData['categoryId'];

    CategoryModel selectedCategory;

    try {
      selectedCategory = availableCategories.firstWhere(
        (cat) => cat.id == aiCategoryId,
        orElse: () => availableCategories.first,
      );
    } catch (e) {
      selectedCategory = availableCategories.isNotEmpty
          ? availableCategories.first
          : throw Exception("List categories is empty");
    }

    LocationModel locationFromAI = const LocationModel();
    if (aiData['location'] != null) {
      if (aiData['location'] is Map<String, dynamic>) {
        locationFromAI = LocationModel.fromMap(aiData['location']);
      } else if (aiData['location'] is String) {
        locationFromAI = LocationModel(address: aiData['location']);
      }
    }

    return TransactionModel(
      id: const Uuid().v4(),
      amount: (aiData['amount'] as num?)?.toDouble() ?? 0.0,
      title: aiData['title'],
      category: selectedCategory,
      date: aiData['date'] != null
          ? DateTime.parse(aiData['date'])
          : DateTime.now(),
      note: aiData['note'] ?? '',
      isIncome: aiData['isIncome'] ?? false,
      walletId: aiData['walletId'] ?? '',
      currency: 'USD',
      exchangeRate: 1.0,
      location: locationFromAI,
    );
  }
}
