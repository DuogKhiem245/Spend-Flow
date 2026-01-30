import 'package:spend_flow/core/model/transaction_model.dart';

class DailyGroup {
  final DateTime date;
  final List<TransactionModel> transactions;
  DailyGroup(this.date, this.transactions);
}
