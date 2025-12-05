import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/features/home/home_model.dart';

class HomeViewModel {
  int income = 5000;
  int expenses = 3000;

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
        color: const Color(0xFFF29985), // Cam hồng
      ),
      SpendingModel(
        category: "Food",
        amount: 840,
        color: const Color(0xFFBCA1F2), // Tím
      ),
      SpendingModel(
        category: "Transport",
        amount: 450,
        color: const Color(0xFF76CFA9), 
      ).copyWith(color: const Color(0xFF6FCF97)), 
    ];
  }

  double getTotalSpent() {
    final data = getSpendingData();
    return data.fold(0, (sum, item) => sum + item.amount);
  }

  List<PieChartSectionData> getChartSections() {
    final data = getSpendingData();
    
    return data.map((item) {
      return PieChartSectionData(
        color: item.color,
        value: item.amount,
        title: '', 
        radius: 20.w, 
        showTitle: false,
      );
    }).toList();
  }
}
