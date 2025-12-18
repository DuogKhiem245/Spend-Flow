import 'package:spend_flow/features/add_stransaction/model/transaction_model.dart';

class DailyGroup {
  final DateTime date;
  final List<TransactionModel> transactions;
  DailyGroup(this.date, this.transactions);
}
