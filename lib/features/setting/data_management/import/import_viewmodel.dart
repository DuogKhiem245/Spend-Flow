import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/ai_service.dart';
import 'package:spend_flow/core/services/language_service.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';

enum ImportStatus { initial, loading, success, error }

class ImportViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final AIService _aiService = AIService();

  ImportStatus _status = ImportStatus.initial;
  ImportStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

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
    await Share.shareXFiles([XFile(file.path)]);
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

    String csv = const ListToCsvConverter().convert(rows);
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/sample_transactions.csv');
    await file.writeAsString(csv);
    await Share.shareXFiles([XFile(file.path)]);
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
    await Share.shareXFiles([XFile(file.path)]);
  }

  Future<void> pickAndImportFile(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'xlsx', 'json'],
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
          showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(l10n.import_success),
              content: Text(l10n.import_success_description),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.ok),
                ),
              ],
            ),
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
          content = latin1.decode(
            bytes,
          ); 
        }

        final fields = const CsvToListConverter().convert(content);
        for (var row in fields) {
          if (row.isNotEmpty) {
            rawLines.add(row.join(" "));
          }
        }
      } else if (extension == 'xlsx' || extension == 'xls') {
        var bytes = file.readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);
        for (var table in excel.tables.keys) {
          var sheet = excel.tables[table];
          if (sheet == null) continue;

          for (var row in sheet.rows.skip(1)) {
            final lineData = row
                .map((cell) => cell?.value?.toString() ?? "")
                .join(" ");
            if (lineData.trim().isNotEmpty) {
              rawLines.add(lineData);
            }
          }
        }
      } else if (extension == 'json') {
        String content = await file.readAsString();
        final decoded = jsonDecode(content);

        if (decoded is List) {
          for (var item in decoded) {
            rawLines.add(item.toString());
          }
        }
      }

      if (rawLines.isEmpty) return false;

      await _sendToAI(rawLines, categories, language, extension);

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
    String type,
  ) async {
    List<TransactionModel> transactionsToSave = [];

    final listWallets = await _storage.getAllWallets();
    final walletIds = listWallets.map((w) => w.id).toList();
    final defaultWalletId = await _storage.getCurrentWalletId();

    for (String line in lines) {
      try {
        Map<String, dynamic>? result;

        if (type == 'csv') {
          result = await _aiService.analyzeTextCSVImport(
            line,
            categories,
            language,
            walletIds,
          );
        } else if (type == 'xlsx' || type == 'xls') {
        } else if (type == 'json') {
        }

        if (result != null && result['data'] != null) {
          final data = Map<String, dynamic>.from(result['data']);

          final tx = TransactionModel.fromAIResponse(
            aiData: data,
            availableCategories: categories,
            currentWalletId: defaultWalletId,
          );

          transactionsToSave.add(tx);
          debugPrint("Đã phân tích xong: ${tx.title}");
        }
      } catch (e) {
        debugPrint("Lỗi phân tích dòng [$line]: $e");
      }
    }

    if (transactionsToSave.isNotEmpty) {
      debugPrint(
        "Bắt đầu lưu ${transactionsToSave.length} giao dịch vào máy...",
      );

      for (var tx in transactionsToSave) {
        await _storage.addTransaction(tx);
      }

      debugPrint("Hoàn tất nhập liệu!");
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
