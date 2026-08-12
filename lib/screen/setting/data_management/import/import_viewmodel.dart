import 'dart:convert';
import 'dart:io';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/model/budget_model.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/model/wallet_model.dart';
import 'package:spend_flow/core/services/ai_service.dart';
import 'package:spend_flow/core/services/general_service/language_service.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';

enum ImportStatus { initial, loading, success, error }

class ImportViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final AIService _aiService = AIService();

  ImportStatus _status = ImportStatus.initial;
  ImportStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int? _recentImportCount = 0;
  int? get recentImportCount => _recentImportCount;

  List<Map<String, dynamic>> _recentImports = [];
  List<Map<String, dynamic>> get recentImports => _recentImports;

  ImportViewModel() {
    loadImportHistory();
  }

  Future<void> loadImportHistory() async {
    final data = await _storage.getString('import_history');
    if (data != null) {
      _recentImports = List<Map<String, dynamic>>.from(jsonDecode(data));
      notifyListeners();
    }
  }

  Future<void> _saveHistory() async {
    await _storage.saveString('import_history', jsonEncode(_recentImports));
  }

  Future<void> exportExcelTemplate(BuildContext context) async {
    var excel = Excel.createExcel();

    Sheet sheetTx = excel['Transactions'];
    sheetTx.appendRow([
      TextCellValue("ID"),
      TextCellValue("Date"),
      TextCellValue("Title"),
      TextCellValue("Amount"),
      TextCellValue("Type"),
      TextCellValue("Category ID"),
      TextCellValue("Wallet ID"),
      TextCellValue("Note"),
    ]);
    sheetTx.appendRow([
      TextCellValue("tx_sample_01"),
      TextCellValue("2026-01-14"),
      TextCellValue("Ăn tối"),
      DoubleCellValue(25.0),
      TextCellValue("Expense"),
      TextCellValue("cat_food_01"),
      TextCellValue("wallet_01"),
      TextCellValue("Ghi chú mẫu"),
    ]);

    Sheet sheetCat = excel['Categories'];
    sheetCat.appendRow([
      TextCellValue("ID"),
      TextCellValue("Name"),
      TextCellValue("IconKey"),
      TextCellValue("ColorValue"),
      TextCellValue("isCustom"),
    ]);
    sheetCat.appendRow([
      TextCellValue("cat_food_01"),
      TextCellValue("Ăn uống"),
      TextCellValue("restaurant"),
      IntCellValue(4282515258),
      IntCellValue(0),
    ]);

    Sheet sheetWallet = excel['Wallets'];
    sheetWallet.appendRow([
      TextCellValue("ID"),
      TextCellValue("Name"),
      TextCellValue("Currency"),
    ]);
    sheetWallet.appendRow([
      TextCellValue("wallet_01"),
      TextCellValue("Ví Tiền Mặt"),
      TextCellValue("VND"),
    ]);

    Sheet sheetBudget = excel['Budgets'];
    sheetBudget.appendRow([
      TextCellValue("ID"),
      TextCellValue("Category ID"),
      TextCellValue("Wallet ID"),
      TextCellValue("Total"),
      TextCellValue("Date"),
    ]);
    sheetBudget.appendRow([
      TextCellValue("bg_sample_01"),
      TextCellValue("cat_food_01"),
      TextCellValue("wallet_01"),
      DoubleCellValue(1000.0),
      TextCellValue("2026-01-01"),
    ]);

    if (excel.sheets.containsKey('Sheet1')) excel.delete('Sheet1');

    final fileBytes = excel.save();
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/SpendFlow_Template.xlsx');
    await file.writeAsBytes(fileBytes!);
    await SharePlus.instance.share(XFile(file.path) as ShareParams);
    //await Share.shareXFiles([XFile(file.path)]);
  }

  Future<void> exportCsvTemplate() async {
    List<List<dynamic>> rows = [
      [
        "id",
        "date",
        "title",
        "amount",
        "isIncome",
        "categoryId",
        "walletId",
        "note",
      ],
      [
        "sample_tx_01",
        "2026-01-14 08:00",
        "Ăn sáng",
        30000,
        "false",
        "cat_food",
        "wallet_01",
        "Bún riêu",
      ],
    ];

    String csv = Csv().encode(rows);
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/sample_transactions.csv');
    await file.writeAsString(csv);
    await SharePlus.instance.share(XFile(file.path) as ShareParams);
    // await Share.shareXFiles([XFile(file.path)]);
  }

  Future<void> exportJsonTemplate() async {
    final Map<String, dynamic> template = {
      "wallets": [
        {"id": "w_01", "name": "Ví chính", "currency": "VND"},
      ],
      "categories": [
        {
          "id": "cat_01",
          "name": "Ăn uống",
          "iconKey": "food",
          "colorValue": 4294901760,
        },
      ],
      "transactions": [
        {
          "id": "tx_01",
          "title": "Giao dịch mẫu",
          "amount": 100.0,
          "date": DateTime.now().toIso8601String(),
          "isIncome": false,
          "walletId": "w_01",
          "category": {"id": "cat_01"},
        },
      ],
      "budgets": [],
    };

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/sample_backup.json');
    await file.writeAsString(jsonEncode(template));
    await SharePlus.instance.share(XFile(file.path) as ShareParams);
    // await Share.shareXFiles([XFile(file.path)]);
  }

  Future<void> pickAndImportFile(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'json'],
      );

      if (result == null) return;

      _status = ImportStatus.loading;
      notifyListeners();

      final file = File(result.files.first.path!);
      final extension = result.files.first.extension?.toLowerCase();

      bool success = await _processFileContent(file, extension!);

      if (success) {
        await _recordImportHistory(result.files.first.name, extension);
        _status = ImportStatus.success;

        if (context.mounted) {
          final l10n = AppLocalizations.of(context)!;

          AdaptiveAlertDialog.show(
            context: context,
            title: l10n.import_success,
            message: l10n.import_success_description(_recentImportCount! as String),
            icon: 'arrow.down.doc.fill',
            actions: [
              AlertAction(
                title: l10n.ok,
                style: AlertActionStyle.primary,
                onPressed: () {},
              ),
            ],
          );
        }
      } else {
        throw Exception(l10n.invalid_format);
      }
    } catch (e) {
      _status = ImportStatus.error;
      _errorMessage = e.toString();
      if (context.mounted) {
        _showErrorAlert(context, l10n, e.toString());
      }
    } finally {
      notifyListeners();
    }
  }

  Future<bool> _processFileContent(File file, String extension) async {
    try {
      List<String> rawLines = [];

      List<CategoryModel> categories = CategoryData.getAll();
      String language = LanguageService().locale.languageCode;

      if (extension == 'csv') {
        final bytes = await file.readAsBytes();
        String content;
        try {
          content = utf8.decode(bytes);
        } catch (_) {
          content = latin1.decode(bytes);
        }

        final fields = Csv().decode(content);
        for (var row in fields.skip(1)) {
          if (row.isNotEmpty) {
            rawLines.add(row.join(" "));
          }
        }

        if (rawLines.isEmpty) return false;

        await _sendToAI(rawLines, categories, language);
      } else if (extension == 'json') {
        final String content = await file.readAsString();
        final Map<String, dynamic> data = jsonDecode(content);

        if (data.containsKey('wallets')) {
          final List<dynamic> walletsRaw = data['wallets'];
          for (var w in walletsRaw) {
            final wallet = WalletModel.fromMap(Map<String, dynamic>.from(w));
            await _storage.saveWallet(wallet);
          }
        }

        if (data.containsKey('categories')) {
          final List<dynamic> categoriesRaw = data['categories'];
          for (var cat in categoriesRaw) {
            final category = CategoryModel.fromMap(
              Map<String, dynamic>.from(cat),
            );
            await _storage.addCategory(category);
          }
        }

        if (data.containsKey('budgets')) {
          final List<dynamic> budgetsRaw = data['budgets'];
          for (var b in budgetsRaw) {
            final budget = BudgetModel.fromMap(Map<String, dynamic>.from(b));
            await _storage.saveBudget(budget);
          }
        }

        if (data.containsKey('transactions')) {
          final List<dynamic> transactionsRaw = data['transactions'];
          for (var tx in transactionsRaw) {
            final transaction = TransactionModel.fromMap(
              Map<String, dynamic>.from(tx),
            );
            await _storage.addTransaction(transaction);
          }
        }

        return true;
      }
      // else if (extension == 'xlsx' || extension == 'xls') {
      //   var bytes = file.readAsBytesSync();
      //   var excel = Excel.decodeBytes(bytes);
      //   for (var table in excel.tables.keys) {
      //     var sheet = excel.tables[table];
      //     if (sheet == null) continue;

      //     for (var row in sheet.rows.skip(1)) {
      //       final lineData = row
      //           .map((cell) => cell?.value?.toString() ?? "")
      //           .join(" ");
      //       if (lineData.trim().isNotEmpty) {
      //         rawLines.add(lineData);
      //       }
      //     }
      //   }
      // }
      return true;
    } catch (e) {
      debugPrint("Lỗi xử lý file: $e");
      return false;
    }
  }

  Future<void> _sendToAI(
    List<String> lines,
    List<CategoryModel> categories,
    String language,
  ) async {
    List<TransactionModel> transactionsToSave = [];
    final defaultWalletId = await _storage.getCurrentWalletId();

    for (String line in lines) {
      try {
        final List<Map<String, dynamic>> results = await _aiService
            .analyzeTextCSVImport(line, categories, language);

        for (var item in results) {
          if (item['data'] != null) {
            final data = Map<String, dynamic>.from(item['data'] as Map);

            final tx = TransactionModel.fromAIResponse(
              aiData: data,
              availableCategories: categories,
              currentWalletId: defaultWalletId,
            );

            transactionsToSave.add(tx);
          }
        }
      } catch (e) {
        debugPrint("Lỗi xử lý tại _sendToAI: $e");
      }
    }
    if (transactionsToSave.isNotEmpty) {
      for (var tx in transactionsToSave) {
        final result = await _storage.addTransaction(tx);
        if (result) {
          _recentImportCount = _recentImportCount! + 1;
        }
      }
    } else {
      debugPrint("Không có giao dịch hợp lệ nào để lưu.");
    }
  }

  Future<void> _recordImportHistory(String fileName, String? extension) async {
    final now = DateTime.now();
    final newItem = {
      'id': now.millisecondsSinceEpoch.toString(),
      'name': fileName,
      'time':
          "${now.day}/${now.month} ${now.hour}:${now.minute.toString().padLeft(2, '0')}",
      'format': extension?.toUpperCase() ?? 'FILE',
    };
    _recentImports.insert(0, newItem);
    await _saveHistory();
  }

  void _showErrorAlert(
    BuildContext context,
    AppLocalizations l10n,
    String message,
  ) {
    CheckValidWidget.showIncompleteDetailsSheet(
      context: context,
      title: l10n.error,
      description: message,
      missingFields: [],
      buttonText: "OK",
    );
  }
}
