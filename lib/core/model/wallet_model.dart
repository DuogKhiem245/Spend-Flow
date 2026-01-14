import 'package:uuid/uuid.dart';
import 'package:spend_flow/core/model/transaction_model.dart'; 

class WalletModel {
  final String id;
  final String name;
  final String currency;
  final List<TransactionModel> transactions;

  final int updatedAt;
  final bool isDeleted;

  WalletModel({
    String? id,
    required this.name,
    this.currency = 'USD',
    List<TransactionModel>? transactions,
    int? updatedAt,
    this.isDeleted = false,
  }) : id = id ?? const Uuid().v4(),
       transactions = transactions ?? [],
       updatedAt = updatedAt ?? DateTime.now().millisecondsSinceEpoch;

  WalletModel copyWith({
    String? id,
    String? name,
    String? currency,
    List<TransactionModel>? transactions,
    int? updatedAt,
    bool? isDeleted,
  }) {
    return WalletModel(
      id: id ?? this.id,
      name: name ?? this.name,
      currency: currency ?? this.currency,
      transactions: transactions ?? this.transactions,
      updatedAt: updatedAt ?? DateTime.now().millisecondsSinceEpoch,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'currency': currency,
      'transactions': [],
      'updatedAt': updatedAt,
      'isDeleted': isDeleted ? 1 : 0,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'],
      name: map['name'],
      currency: map['currency'],
      transactions: map['transactions'] != null
          ? List<TransactionModel>.from(
              map['transactions']?.map((x) => TransactionModel.fromMap(x)),
            )
          : [],
      updatedAt: map['updatedAt'] ?? DateTime.now().millisecondsSinceEpoch,
      isDeleted: map['isDeleted'] == 1 || map['isDeleted'] == true,
    );
  }
}
