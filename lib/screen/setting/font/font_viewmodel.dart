import 'package:flutter/cupertino.dart';
import 'package:spend_flow/core/services/general_service/font_service.dart';

class FontViewModel extends ChangeNotifier {
  final FontService _service = FontService();
  String _currentFont = 'Lexend';

  String get currentFont => _currentFont;

  Future<void> init() async {
    _currentFont = await _service.getSavedFont();
    notifyListeners();
  }

  Future<void> changeFont(String newFont) async {
    _currentFont = newFont;
    await _service.saveFont(newFont);
    notifyListeners();
  }
}
