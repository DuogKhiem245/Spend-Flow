import 'package:uuid/uuid.dart';
import 'package:spend_flow/core/model/transaction_model.dart'; 

class WalletModel {
  final String id;
  final String name;
  final String currency;
  final List<TransactionModel> transactions;

  WalletModel({
    String? id,
    required this.name,
    this.currency = 'USD',
    List<TransactionModel>? transactions,
  }) : id = id ?? const Uuid().v4(),
       transactions = transactions ?? [];

  WalletModel copyWith({
    String? id,
    String? name,
    String? currency,
    List<TransactionModel>? transactions,
  }) {
    return WalletModel(
      id: id ?? this.id,
      name: name ?? this.name,
      currency: currency ?? this.currency,
      transactions: transactions ?? this.transactions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'currency': currency,
      'transactions': transactions.map((x) => x.toMap()).toList(),
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
    );
  }
}
