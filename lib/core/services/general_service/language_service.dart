import 'package:flutter/material.dart';
import 'package:spend_flow/core/services/widget_sync_service.dart';
import '../data_service/local_storage_service.dart';

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

  static Locale parseLocale(String code) {
    if (code.contains('_') || code.contains('-')) {
      final parts = code.split(RegExp(r'[-_]'));
      if (parts.length >= 2) {
        if (parts[1].length == 4) {
          return Locale.fromSubtags(languageCode: parts[0], scriptCode: parts[1]);
        } else {
          return Locale(parts[0], parts[1]);
        }
      }
    }
    return Locale(code);
  }

  String get currentLanguageCode {
    if (_locale.scriptCode != null && _locale.scriptCode!.isNotEmpty) {
      return '${_locale.languageCode}_${_locale.scriptCode}';
    }
    if (_locale.countryCode != null && _locale.countryCode!.isNotEmpty) {
      return '${_locale.languageCode}_${_locale.countryCode}';
    }
    return _locale.languageCode;
  }

  Future<void> _loadLanguage() async {
    final savedLang = await _storageService.getString(_langKey);
    if (savedLang != null) {
      _locale = parseLocale(savedLang);
    } else {
      final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
      final code = systemLocale.languageCode;
      if (code == 'vi') {
        _locale = const Locale('vi');
      } else if (code == 'zh') {
        if (systemLocale.scriptCode == 'Hant' ||
            systemLocale.countryCode == 'TW' ||
            systemLocale.countryCode == 'HK') {
          _locale = const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant');
        } else {
          _locale = const Locale('zh');
        }
      } else if (code == 'ja') {
        _locale = const Locale('ja');
      } else if (code == 'ko') {
        _locale = const Locale('ko');
      } else if (code == 'es') {
        _locale = const Locale('es');
      } else {
        _locale = const Locale('en');
      }
    }
    notifyListeners();
  }

  Future<void> changeLanguage(String languageCode) async {
    if (currentLanguageCode == languageCode) return;

    _locale = parseLocale(languageCode);
    await _storageService.saveString(_langKey, languageCode);
    notifyListeners();

    try {
      await WidgetSyncService().updateAllWidgets();
    } catch (e) {
      debugPrint('Error updating widgets after language change: $e');
    }
  }
}

