import 'dart:io';
import 'dart:convert';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';

class ExportViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> exportExcel(BuildContext context) async {
    _setLoading(true);
    try {
      final dbData = await _storage.exportDataToJson();
      final Map<String, dynamic> data = jsonDecode(dbData);

      final List<dynamic> transactions = (data['transactions'] ?? [])
          .where((tx) => tx['isDeleted'] != true && tx['isDeleted'] != 1)
          .toList();

      final List<dynamic> wallets = (data['wallets'] ?? [])
          .where((w) => w['isDeleted'] != true && w['isDeleted'] != 1)
          .toList();

      final List<dynamic> budgets = (data['budgets'] ?? [])
          .where((b) => b['isDeleted'] != true && b['isDeleted'] != 1)
          .toList();

      final allCategories = (await _storage.getAllCategories())
          .where((cat) => !cat.isDeleted)
          .toList();

      var excel = Excel.createExcel();

      // ================= SHEET: TRANSACTIONS =================
      Sheet sheetTx = excel['Transactions'];
      List<String> txHeaders = [
        "ID",
        "Date",
        "Title",
        "Type",
        "Category ID",
        "Amount",
        "Currency",
        "Address",
        "Longitude",
        "Latitude",
        "Note",
        "Wallet ID",
      ];
      sheetTx.appendRow(txHeaders.map((e) => TextCellValue(e)).toList());

      for (var tx in transactions) {
        final date = DateTime.tryParse(tx['date']) ?? DateTime.now();
        final loc = tx['location'] is Map ? tx['location'] : {};

        sheetTx.appendRow([
          TextCellValue(tx['id'] ?? ""),
          TextCellValue(DateFormat('yyyy-MM-dd HH:mm').format(date)),
          TextCellValue(tx['title'] ?? ""),
          TextCellValue((tx['isIncome'] == true) ? "Income" : "Expense"),
          TextCellValue(tx['category'] is Map ? tx['category']['id'] : ""),
          DoubleCellValue((tx['amount'] ?? 0).toDouble()),
          TextCellValue(tx['currency'] ?? "USD"),
          TextCellValue(loc['address'] ?? ""),
          DoubleCellValue((loc['longitude'] ?? 0).toDouble()),
          DoubleCellValue((loc['latitude'] ?? 0).toDouble()),
          TextCellValue(tx['note'] ?? ""),
          TextCellValue(tx['walletId'] ?? ""),
        ]);
      }

      // ================= SHEET: WALLETS =================
      Sheet sheetWallet = excel['Wallets'];
      sheetWallet.appendRow(
        [
          "ID",
          "Name",
          "Balance",
          "Currency",
          "Updated At",
        ].map((e) => TextCellValue(e)).toList(),
      );

      for (var w in wallets) {
        sheetWallet.appendRow([
          TextCellValue(w['id'] ?? ""),
          TextCellValue(w['name'] ?? ""),
          DoubleCellValue((w['balance'] ?? 0).toDouble()),
          TextCellValue(w['currency'] ?? ""),
          IntCellValue(w['updatedAt'] ?? 0),
        ]);
      }

      // ================= SHEET: BUDGETS =================
      Sheet sheetBudget = excel['Budgets'];
      sheetBudget.appendRow(
        [
          "ID",
          "Wallet ID",
          "Category ID",
          "Total",
          "Date",
        ].map((e) => TextCellValue(e)).toList(),
      );

      for (var b in budgets) {
        sheetBudget.appendRow([
          TextCellValue(b['id'] ?? ""),
          TextCellValue(b['walletId'] ?? ""),
          TextCellValue(b['category'] is Map ? b['category']['id'] : ""),
          DoubleCellValue((b['total'] ?? 0).toDouble()),
          TextCellValue(b['date'] ?? ""),
        ]);
      }

      // ================= SHEET: CATEGORIES =================
      Sheet sheetCat = excel['Categories'];
      sheetCat.appendRow(
        [
          "ID",
          "Name",
          "l10nKey",
          "IconKey",
          "ColorValue",
          "Is Custom",
          "Updated At",
        ].map((e) => TextCellValue(e)).toList(),
      );

      for (var cat in allCategories) {
        sheetCat.appendRow([
          TextCellValue(cat.id),
          TextCellValue(cat.name),
          TextCellValue(cat.l10nKey ?? ""),
          TextCellValue(cat.iconKey),
          IntCellValue(cat.color.toARGB32()),
          IntCellValue(cat.isCustom ? 1 : 0),
          IntCellValue(cat.updatedAt),
        ]);
      }

      if (excel.sheets.containsKey('Sheet1')) excel.delete('Sheet1');

      final fileBytes = excel.save();
      final String fileName =
          'spendflow_export_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.xlsx';
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(fileBytes!);

      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], subject: 'Excel Report'),
      );
    } catch (e) {
      if (context.mounted) {
        _showError(context, "Lỗi xuất Excel: $e");
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> exportCsv(BuildContext context) async {
    await _performExport(context, 'csv', () async {
      final dbData = await _storage.exportDataToJson();
      final Map<String, dynamic> data = jsonDecode(dbData);

      final List<dynamic> transactions = (data['transactions'] ?? [])
          .where((tx) => tx['isDeleted'] != true && tx['isDeleted'] != 1)
          .toList();

      List<List<dynamic>> rows = [];
      rows.add([
        "ID",
        "Date",
        "Title",
        "Type",
        "CategoryID",
        "Amount",
        "Currency",
        "Note",
        "WalletID",
      ]);

      for (var tx in transactions) {
        rows.add([
          tx['id'] ?? "",
          tx['date'] ?? "",
          tx['title'] ?? "",
          (tx['isIncome'] == true) ? "Income" : "Expense",
          tx['category'] is Map ? tx['category']['id'] : "",
          tx['amount'],
          tx['currency'] ?? "",
          tx['note'] ?? "",
          tx['walletId'] ?? "",
        ]);
      }
      return const ListToCsvConverter().convert(rows);
    });
  }

  Future<void> exportJson(BuildContext context) async {
    _setLoading(true);
    try {
      final String rawData = await _storage.exportDataToJson();
      final Map<String, dynamic> data = jsonDecode(rawData);

      final Map<String, dynamic> cleanData = {
        'transactions': (data['transactions'] ?? [])
            .where((tx) => tx['isDeleted'] != true)
            .toList(),
        'wallets': (data['wallets'] ?? [])
            .where((w) => w['isDeleted'] != true)
            .toList(),
        'budgets': (data['budgets'] ?? [])
            .where((b) => b['isDeleted'] != true)
            .toList(),
        'categories': (await _storage.getAllCategories())
            .where((cat) => !cat.isDeleted)
            .map((e) => e.toMap())
            .toList(),
      };

      final String fileName =
          'spendflow_backup_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.json';
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsString(jsonEncode(cleanData));

      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], subject: 'JSON Backup'),
      );
    } catch (e) {
      if (context.mounted) {
        _showError(context, "Lỗi xuất JSON: $e");
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _performExport(
    BuildContext context,
    String extension,
    Future<String> Function() contentGenerator,
  ) async {
    _setLoading(true);
    try {
      final content = await contentGenerator();

      final String fileName =
          'spendflow_data_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.$extension';
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');

      await file.writeAsString(content);

      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)], subject: 'SpendFlow Export Data'),
      );
    } catch (e) {
      if (context.mounted) {
        _showError(context, "Lỗi xuất file: $e");
      }
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _showError(BuildContext context, String message) {
    if (!context.mounted) return;

    final l10n = AppLocalizations.of(context)!;

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.error,
      message: message,
      icon: 'exclamationmark.circle.fill',
      actions: [
        AlertAction(
          title: "OK",
          style: AlertActionStyle.primary,
          onPressed: () {},
        ),
      ],
    );
  }
}
