import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/features/add_stransaction/model/transaction_model.dart';
import 'package:spend_flow/features/home/home_model.dart';

class HomeViewModel {
  final LocalStorageService _storage = LocalStorageService();

  String getGreetingMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return l10n.good_morning;
    } else if (hour >= 12 && hour < 18) {
      return l10n.good_afternoon;
    } else if (hour >= 18 && hour < 22) {
      return l10n.good_evening;
    } else {
      return l10n.hello;
    }
  }
  
  Future<Map<String, double>> getCurrentMonthStats() async {
    final now = DateTime.now();

    final transactions = await _storage.getTransactionsByMonth(now);

    double income = 0;
    double expenses = 0;

    for (var tx in transactions) {
      if (tx.isIncome) {
        income += tx.amount;
      } else {
        expenses += tx.amount;
      }
    }

    double balance = income - expenses;

    return {'income': income, 'expenses': expenses, 'balance': balance};
  }

  String formatCurrency(double amount) {
    final formatter = NumberFormat("#,##0.0", "en_US");
    return formatter.format(amount);
  }
  
  Future<List<SpendingModel>> getChartData() async {
    final now = DateTime.now();

    // Lấy giao dịch tháng này
    final transactions = await _storage.getTransactionsByMonth(now);

    final Map<String, double> categorySpending = {};
    final Map<String, Color> categoryColors = {};

    for (var tx in transactions) {
      if (tx.isIncome == false) {
        final amount = tx.amount.abs(); 
        final catName = tx.category.name;

        categorySpending[catName] = (categorySpending[catName] ?? 0) + amount;

        if (!categoryColors.containsKey(catName)) {
          categoryColors[catName] = tx.category.color;
        }
      }
    }

    List<SpendingModel> allSpending = categorySpending.entries.map((e) {
      return SpendingModel(
        category: e.key,
        amount: e.value,
        color: categoryColors[e.key] ?? CupertinoColors.systemGrey,
      );
    }).toList();

    allSpending.sort((a, b) => b.amount.compareTo(a.amount));

    if (allSpending.length <= 4) {
      return allSpending;
    }

    final top4 = allSpending.sublist(0, 4);
    final others = allSpending.sublist(4);

    double otherTotal = 0;
    for (var item in others) {
      otherTotal += item.amount;
    }

    top4.add(
      SpendingModel(
        category: "Other",
        amount: otherTotal,
        color: CupertinoColors.systemGrey,
      ),
    );

    return top4;
  }

  double calculateTotalSpent(List<SpendingModel> data) {
    return data.fold(0, (sum, item) => sum + item.amount);
  }

  List<PieChartSectionData> generateChartSections(
    List<SpendingModel> data,
    int touchedIndex,
    BuildContext context,
  ) {
    return data.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;
      final isTouched = i == touchedIndex;
      final fontSize = 15.0.sp;
      final radius = isTouched ? 45.0.w : 35.0.w;

      return PieChartSectionData(
        color: item.color,
        value: item.amount,
        // Nếu muốn hiển thị phần trăm thay vì số tiền:
        // title: isTouched ? '${(item.amount / total * 100).toStringAsFixed(1)}%' : '',
        title: isTouched ? '\$${formatCurrency(item.amount)}' : '',
        radius: radius,
        titleStyle: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
        ),
      );
    }).toList();
  }

  Future<List<TransactionModel>> getRecentTransactionsList() async {
    final all = await _storage.getAllTransactions();

    if (all.length > 5) {
      return all.sublist(0, 5);
    }

    return all;
  }
}
