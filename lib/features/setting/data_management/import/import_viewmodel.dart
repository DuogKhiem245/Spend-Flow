import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/widgets/check_valid/check_valid_widget.dart';

enum ImportStatus { initial, loading, success, error }

class ImportViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();

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

      bool success = await _processFileContent(file, extension);

      if (success) {
        final now = DateTime.now();
        final newItem = {
          'id': now.millisecondsSinceEpoch.toString(),
          'name': result.files.first.name,
          'time':
              "${now.day}/${now.month} ${now.hour}:${now.minute.toString().padLeft(2, '0')}",
          'format': extension?.toUpperCase() ?? 'FILE',
        };

        _recentImports.insert(0, newItem);
        await _saveHistory();
        _status = ImportStatus.success;

        if (context.mounted) {
          showCupertinoModalPopup(
            context: context,
            builder: (context) => CupertinoActionSheet(
              title: Text(l10n.import_success),
              message: Text(l10n.import_success_description),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Done"),
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

  Future<bool> _processFileContent(File file, String? extension) async {
    try {
      if (extension == 'csv') {
        try {
          final bytes = await file.readAsBytes();
          String content;
          try {
            content = utf8.decode(bytes);
          } catch (_) {
            content = latin1.decode(bytes);
          }

          final fields = const CsvToListConverter().convert(content);
          debugPrint("Đã đọc ${fields.length} dòng từ CSV");
          return true;
        } catch (e) {
          return false;
        }
      } else if (extension == 'xlsx') {
        var bytes = file.readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);
        for (var table in excel.tables.keys) {
          debugPrint("Sheet: $table, Rows: ${excel.tables[table]?.maxRows}");
        }
        return true;
      } else if (extension == 'json') {
        String content = await file.readAsString();
        jsonDecode(content);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Lỗi xử lý file: $e");
      return false;
    }
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
