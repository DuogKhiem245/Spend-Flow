import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';

class WidgetSyncService {
  static final WidgetSyncService _instance = WidgetSyncService._internal();
  factory WidgetSyncService() => _instance;
  WidgetSyncService._internal();

  static const String appGroupId = 'group.com.duogkhiem.spendflow';
  final LocalStorageService _storage = LocalStorageService();

  Future<void> init() async {
    try {
      await HomeWidget.setAppGroupId(appGroupId);
    } catch (e) {
      debugPrint('Error setting app group id: $e');
    }
  }

  Future<void> updateAllWidgets() async {
    try {
      final walletId = await _storage.getCurrentWalletId();
      if (walletId.isEmpty) return;
      final currencyData = await _storage.getCurrency();
      final symbol = currencyData['symbol'] ?? '\$';

      final numberFormatter = NumberFormat("#,###");

      final allTransactions = await _storage.getAllTransactions(walletId);

      double totalBalance = 0;
      for (var tx in allTransactions) {
        if (tx.isIncome) {
          totalBalance += tx.amount;
        } else {
          totalBalance -= tx.amount;
        }
      }

      // 1. DATA CHO WIDGET GIAO DỊCH GẦN ĐÂY
      final recentList = allTransactions.take(6).map((tx) {
        final prefix = tx.isIncome ? '+' : '-';
        final formatted = '$prefix${numberFormatter.format(tx.amount)} $symbol';
        return {
          'id': tx.id,
          'title': tx.title,
          'amount': tx.amount,
          'formattedAmount': formatted,
          'categoryName': tx.category.name,
          'categoryColor': '#${tx.category.color.toARGB32().toRadixString(16).padLeft(8, '0')}',
          'iconKey': tx.category.iconKey,
          'isIncome': tx.isIncome,
          'date': DateFormat('dd/MM HH:mm').format(tx.date),
        };
      }).toList();

      final formattedBalance = '${numberFormatter.format(totalBalance)} $symbol';
      await HomeWidget.saveWidgetData<String>('recent_transactions', jsonEncode(recentList));
      await HomeWidget.saveWidgetData<String>('total_balance', formattedBalance);
      await HomeWidget.saveWidgetData<String>('wallet_balance', formattedBalance);
      await HomeWidget.saveWidgetData<String>('currency_symbol', symbol);

      // 2. DATA CHO WIDGET BIỂU ĐỒ THÁNG
      final now = DateTime.now();
      final monthTransactions = await _storage.getTransactionsByMonth(now, walletId);

      double monthlyExpense = 0;
      double monthlyIncome = 0;
      Map<int, double> dayExpenseMap = {};
      Map<int, double> dayIncomeMap = {};

      for (var tx in monthTransactions) {
        if (tx.isIncome) {
          monthlyIncome += tx.amount;
          final day = tx.date.day;
          dayIncomeMap[day] = (dayIncomeMap[day] ?? 0) + tx.amount;
        } else {
          monthlyExpense += tx.amount;
          final day = tx.date.day;
          dayExpenseMap[day] = (dayExpenseMap[day] ?? 0) + tx.amount;
        }
      }

      final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
      List<Map<String, dynamic>> dailyChartPoints = [];
      for (int d = 1; d <= daysInMonth; d++) {
        dailyChartPoints.add({
          'day': d,
          'date': '$d/${now.month}',
          'expense': dayExpenseMap[d] ?? 0.0,
          'income': dayIncomeMap[d] ?? 0.0,
        });
      }

      final formattedExpense = '${numberFormatter.format(monthlyExpense)} $symbol';
      final formattedIncome = '${numberFormatter.format(monthlyIncome)} $symbol';
      await HomeWidget.saveWidgetData<String>('monthly_expense', formattedExpense);
      await HomeWidget.saveWidgetData<String>('monthly_total_expense', formattedExpense);
      await HomeWidget.saveWidgetData<String>('monthly_income', formattedIncome);
      await HomeWidget.saveWidgetData<String>('monthly_total_income', formattedIncome);
      await HomeWidget.saveWidgetData<String>('monthly_daily_chart', jsonEncode(dailyChartPoints));

      // 3. DATA CHO WIDGET XEM NGÂN SÁCH CÒN LẠI
      final budgets = await _storage.getBudgetsForMonth(now, walletId);

      double totalBudget = 0;
      double totalSpent = 0;

      List<Map<String, dynamic>> categoryBudgets = [];

      for (var b in budgets) {
        totalBudget += b.total;
        totalSpent += b.spent;

        categoryBudgets.add({
          'name': b.name,
          'total': b.total,
          'spent': b.spent,
          'remaining': b.remaining,
          'formattedRemaining': '${numberFormatter.format(b.remaining)} $symbol',
          'progress': b.progress,
          'color': '#${b.color.toARGB32().toRadixString(16).padLeft(8, '0')}',
          'iconKey': b.iconKey,
        });
      }

      final remainingBudget = totalBudget - totalSpent;
      final overallProgress = totalBudget > 0 ? (totalSpent / totalBudget).clamp(0.0, 1.0) : 0.0;

      await HomeWidget.saveWidgetData<String>('budget_total', '${numberFormatter.format(totalBudget)} $symbol');
      await HomeWidget.saveWidgetData<String>('budget_spent', '${numberFormatter.format(totalSpent)} $symbol');
      await HomeWidget.saveWidgetData<String>('budget_remaining', '${numberFormatter.format(remainingBudget)} $symbol');
      await HomeWidget.saveWidgetData<double>('budget_progress', overallProgress);
      await HomeWidget.saveWidgetData<String>('budget_percent', '${(overallProgress * 100).toInt()}%');
      await HomeWidget.saveWidgetData<String>('category_budgets', jsonEncode(categoryBudgets));

      // CẬP NHẬT CẢ 3 WIDGET TRÊN IOS & ANDROID
      await HomeWidget.updateWidget(
        iOSName: 'RecentTransactionsWidget',
        androidName: 'RecentTransactionsWidgetProvider',
      );
      await HomeWidget.updateWidget(
        iOSName: 'MonthlyChartWidget',
        androidName: 'MonthlyChartWidgetProvider',
      );
      await HomeWidget.updateWidget(
        iOSName: 'RemainingBudgetWidget',
        androidName: 'RemainingBudgetWidgetProvider',
      );

      debugPrint('✅ WidgetSyncService: Updated all widgets successfully.');
    } catch (e) {
      debugPrint('🚨 Error updating widgets: $e');
    }
  }
}
