import 'package:flutter/material.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'model/category_model.dart';

class AddStransactionViewmodel {
  String? getTranslatedCategoryName(
    BuildContext context,
    CategoryModel category,
  ) {
    if (category.l10nKey == null) return category.name;

    final l10n = AppLocalizations.of(context)!;

    final Map<String, String> localizedMap = {
      'category_food': l10n.category_food,
      'category_transport': l10n.category_transport,
      'category_salary': l10n.category_salary,
      'category_shopping': l10n.category_shopping,
      'category_game': l10n.category_game,
      'category_house': l10n.category_house,
      'category_gift': l10n.category_gift,
      'category_health': l10n.category_health,
      'category_entertainment': l10n.category_entertainment,
      'category_bill': l10n.category_bill,
      'category_insurance': l10n.category_insurance,
      'category_education': l10n.category_education,
      'category_pet': l10n.category_pet,
      'category_travel': l10n.category_travel,
      'category_savings': l10n.category_savings,
      'category_phone': l10n.category_phone,
      'category_internet': l10n.category_internet,
      'category_water': l10n.category_water,
      'category_electricity': l10n.category_electricity,
      'category_gas': l10n.category_gas,
      'category_cleaning': l10n.category_cleaning,
      'category_beauty': l10n.category_beauty,
      'category_baby': l10n.category_baby,
      'category_sport': l10n.category_sport,
      'category_music': l10n.category_music,
      'category_repair': l10n.category_repair,
      'category_tax': l10n.category_tax,
    };

    return localizedMap[category.l10nKey] ?? category.name;
  }

  void addIncomeTransaction(
    String amount,
    String name,
    CategoryModel? selectedCategory,
    DateTime? transactionDate,
    String note,
  ) {

  }

  void addExpenseTransaction(
    String amount,
    String name,
    CategoryModel? selectedCategory,
    DateTime? transactionDate,
    String note,
  ) {
    
  }
}
