import 'package:shared_preferences/shared_preferences.dart';

class FontService {
  static const String _keyFont = 'selected_font_family';

  Future<void> saveFont(String fontFamily) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyFont, fontFamily);
  }

  Future<String> getSavedFont() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFont) ?? 'Lexend';
  }

  Future<String> getFontName() async {
    return await getSavedFont();
  }
}
