import 'package:flutter/material.dart';
import 'local_storage_service.dart';

class LanguageService extends ChangeNotifier {
  static final LanguageService _instance = LanguageService._internal();

  factory LanguageService() {
    return _instance;
  }

  LanguageService._internal() {
    _loadLanguage();
  }

  static const String _langKey = 'language_code';

  final LocalStorageService _storageService = LocalStorageService();

  Locale _locale = const Locale('vi');

  Locale get locale => _locale;

  String get currentLanguageCode {
    return _locale.languageCode;
  }

  Future<void> _loadLanguage() async {
    final savedLang = await _storageService.getString(_langKey);
     if (savedLang != null) {
      _locale = Locale(savedLang);
    } else {
      final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
      
      if (systemLocale.languageCode == 'vi') {
        _locale = const Locale('vi');
      } else {
        _locale = const Locale('en');
      }
    }
    notifyListeners();
  }

  Future<void> changeLanguage(String languageCode) async {
    if (_locale.languageCode == languageCode) return;

    _locale = Locale(languageCode);
    await _storageService.saveString(_langKey, languageCode);
    notifyListeners();
  }
}
