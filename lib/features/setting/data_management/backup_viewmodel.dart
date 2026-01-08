import 'dart:io';
import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';

class BackupViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // --- 1. XUẤT CSV (Comma Separated Values) ---
  Future<void> exportCsv(BuildContext context) async {
    await _performExport(context, 'csv', () async {
      // Lấy dữ liệu từ DB (giả sử exportDataToJson trả về chuỗi JSON chứa toàn bộ DB)
      final dbData = await _storage.exportDataToJson();
      final Map<String, dynamic> data = jsonDecode(dbData);
      final List<dynamic> transactions = data['transactions'] ?? [];

      // Tạo header cho file CSV
      List<List<dynamic>> rows = [];
      rows.add([
        "Date",
        "Type", // Income / Expense
        "Category",
        "Amount",
        "Note",
        "Wallet ID",
      ]);

      // Duyệt qua từng giao dịch để thêm vào dòng
      for (var tx in transactions) {
        // Parse ngày tháng
        final date = DateTime.tryParse(tx['date']) ?? DateTime.now();

        // Xử lý Category: nếu là object thì lấy name, nếu string thì lấy string
        String categoryName = "Unknown";
        if (tx['category'] is Map) {
          categoryName = tx['category']['name'] ?? "Unknown";
        } else if (tx['category'] is String) {
          categoryName = tx['category'];
        }

        rows.add([
          DateFormat('yyyy-MM-dd HH:mm').format(date),
          (tx['isIncome'] == true) ? "Income" : "Expense",
          categoryName,
          tx['amount'],
          tx['note'] ?? "",
          tx['walletId'] ?? "",
        ]);
      }

      // Chuyển List thành chuỗi CSV
      return const ListToCsvConverter().convert(rows);
    });
  }

  // --- 2. XUẤT EXCEL (File .xlsx đẹp, chia sheet) ---
  Future<void> exportExcel(BuildContext context) async {
    _setLoading(true);
    try {
      final dbData = await _storage.exportDataToJson();
      final Map<String, dynamic> data = jsonDecode(dbData);

      final List<dynamic> transactions = data['transactions'] ?? [];
      final List<dynamic> wallets = data['wallets'] ?? [];

      // Tạo file Excel mới
      var excel = Excel.createExcel();

      // --- SHEET 1: GIAO DỊCH (Transactions) ---
      Sheet sheetTx = excel['Transactions'];

      // Tạo Header đậm (nếu thư viện hỗ trợ style, ở đây ta cứ add text trước)
      List<String> headers = [
        "Date",
        "Type",
        "Category",
        "Amount",
        "Note",
        "Wallet Name",
      ];
      sheetTx.appendRow(headers.map((e) => TextCellValue(e)).toList());

      for (var tx in transactions) {
        final date = DateTime.tryParse(tx['date']) ?? DateTime.now();

        // Tìm tên ví dựa vào ID
        String walletName = "Unknown";
        if (tx['walletId'] != null) {
          final wallet = wallets.firstWhere(
            (w) => w['id'] == tx['walletId'],
            orElse: () => null,
          );
          if (wallet != null) walletName = wallet['name'];
        }

        String categoryName = "Unknown";
        if (tx['category'] is Map) {
          categoryName = tx['category']['name'] ?? "";
        }

        // Thêm dòng dữ liệu
        sheetTx.appendRow([
          TextCellValue(DateFormat('yyyy-MM-dd').format(date)),
          TextCellValue((tx['isIncome'] == true) ? "Income" : "Expense"),
          TextCellValue(categoryName),
          DoubleCellValue(
            (tx['amount'] ?? 0).toDouble(),
          ), // Dạng số để tính toán
          TextCellValue(tx['note'] ?? ""),
          TextCellValue(walletName),
        ]);
      }

      // --- SHEET 2: TỔNG HỢP VÍ (Wallets) ---
      Sheet sheetWallet = excel['Wallets'];
      sheetWallet.appendRow([
        TextCellValue("Wallet Name"),
        TextCellValue("Balance"),
      ]);

      for (var w in wallets) {
        sheetWallet.appendRow([
          TextCellValue(w['name'] ?? "No Name"),
          DoubleCellValue((w['balance'] ?? 0).toDouble()),
        ]);
      }

      // Xóa sheet mặc định "Sheet1" cho gọn
      if (excel.sheets.containsKey('Sheet1')) {
        excel.delete('Sheet1');
      }

      // Lưu file ra bytes
      final fileBytes = excel.save();
      if (fileBytes == null) throw Exception("Không thể tạo file Excel");

      // Lưu file vào máy và chia sẻ
      final String fileName =
          'spendflow_report_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.xlsx';
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');

      await file.writeAsBytes(fileBytes);

      // Gọi Share Sheet
      await Share.shareXFiles([
        XFile(file.path),
      ], subject: 'Báo cáo tài chính SpendFlow');
    } catch (e) {
      debugPrint("Error Excel: $e");
      _showError(context, "Lỗi tạo Excel: $e");
    } finally {
      _setLoading(false);
    }
  }

  // --- 3. XUẤT JSON (Backup toàn bộ) ---
  Future<void> exportJson(BuildContext context) async {
    await _performExport(context, 'json', () async {
      return await _storage.exportDataToJson();
    });
  }

  // --- HÀM HỖ TRỢ CHUNG ---
  Future<void> _performExport(
    BuildContext context,
    String extension,
    Future<String> Function() contentGenerator,
  ) async {
    _setLoading(true);
    try {
      // 1. Tạo nội dung file
      final content = await contentGenerator();

      // 2. Tạo đường dẫn file tạm
      final String fileName =
          'spendflow_data_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.$extension';
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');

      // 3. Ghi file
      await file.writeAsString(content);

      // 4. Chia sẻ file
      await Share.shareXFiles([
        XFile(file.path),
      ], subject: 'SpendFlow Export Data');
    } catch (e) {
      debugPrint("Error Export: $e");
      _showError(context, "Lỗi xuất file: $e");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _showError(BuildContext context, String message) {
    // Kiểm tra context còn mounted không trước khi show
    if (!context.mounted) return;

    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text("Lỗi"),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }
}
