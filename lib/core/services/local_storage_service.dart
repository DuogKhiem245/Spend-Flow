import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  // --- Singleton Pattern ---
  // Giúp đảm bảo trong toàn bộ app chỉ có DUY NHẤT 1 instance của service này
  // Tránh việc mở kết nối tới bộ nhớ nhiều lần gây lỗi hoặc chậm.
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  /// Lưu một chuỗi (String) vào bộ nhớ
  /// [key]: Tên định danh (ví dụ: 'theme_mode')
  /// [value]: Giá trị cần lưu (ví dụ: 'dark')
  Future<void> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /// Lấy một chuỗi từ bộ nhớ ra
  /// Trả về null nếu chưa lưu gì cả
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// Xóa dữ liệu theo key (ví dụ khi logout muốn xóa token)
  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // Bạn có thể thêm các hàm lưu bool, int... nếu cần sau này
  Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
