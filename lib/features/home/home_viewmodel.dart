import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/features/home/home_model.dart';

class HomeViewModel {
  int income = 5000;
  int expenses = 6000;

  int getBalance() {
    return income - expenses;
  }

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
  
  List<SpendingModel> getSpendingData() {
    return [
      SpendingModel(
        category: "Shopping",
        amount: 550,
        color: const Color(0xFFF29985), 
      ),
      SpendingModel(
        category: "Food",
        amount: 840,
        color: const Color(0xFFBCA1F2),
      ),
      SpendingModel(
        category: "Transport",
        amount: 450,
        color: const Color(0xFF76CFA9), 
      ).copyWith(color: const Color(0xFF6FCF97)), 
      SpendingModel(
        category: "Other",
        amount: 300,
        color: CupertinoColors.systemGrey2, 
      ),
    ];
  }

  List<RecentTransactionModel> getRecentTransactions() {
    return [
      RecentTransactionModel(
        icon: Icon(CupertinoIcons.cart_fill),
        title: "Grocery Shopping",
        category: "Food",
        amount: 120.50,
        date: DateTime(2025, 11, 15),
        isExpense: true,
      ),
      RecentTransactionModel(
        icon: Icon(CupertinoIcons.bolt_horizontal_circle_fill),
        title: "Dinner at Restaurant",
        category: "Food",
        amount: 75.20,
        date: DateTime(2025, 11, 10),
        isExpense: true,
      ),
      RecentTransactionModel(
        icon: Icon(CupertinoIcons.money_dollar_circle_fill),
        title: "Monthly Salary",
        category: "Income",
        amount: 3000.00,
        date: DateTime(2025, 11, 30),
        isExpense: false,
      ),
      RecentTransactionModel(
        icon: Icon(CupertinoIcons.car_fill),
        title: "Grab",
        category: "Transport",
        amount: 103.75,
        date: DateTime(2025, 11, 5),
        isExpense: true,
      ),
    ];
  }

  double getTotalSpent() {
    final data = getSpendingData();
    return data.fold(0, (sum, item) => sum + item.amount);
  }

  List<PieChartSectionData> getChartSections(int touchedIndex, BuildContext context) {
    final data = getSpendingData();
    return data.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;
      final isTouched = i == touchedIndex;
      final fontSize = 14.0.sp;
      final radius = isTouched ? 45.0.w : 35.0.w;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: item.color,
        value: item.amount,
        title: isTouched ? '${item.category} : \$${item.amount}' : '', 
        radius: radius, 
        titleStyle: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          shadows: shadows,
        ),
      );
    }).toList();
  }
}
