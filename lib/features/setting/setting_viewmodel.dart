import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart'; 
import 'package:local_auth/local_auth.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/local_storage_service.dart'; 

enum BiometricDisplayType { faceId, touchId, none }

class SettingViewModel extends ChangeNotifier {
  static final SettingViewModel _instance = SettingViewModel._internal();
  factory SettingViewModel() => _instance;

  SettingViewModel._internal() {
    loadSettings();
  }

  final _localStorage = LocalStorageService();

  String _currentCurrencyCode = 'USD';
  String get currentCurrencyCode => _currentCurrencyCode;

  Future<void> loadSettings() async {
    final currency = await _localStorage.getCurrency();
    _currentCurrencyCode = currency['code'] ?? 'USD';
    notifyListeners();
  }

  Future<void> setCurrency(String code) async {
    if (_currentCurrencyCode == code) return;

    _currentCurrencyCode = code;
    notifyListeners();

    await _localStorage.saveCurrencyCode(code);
  }

  Future<String> checkBiometricSupport(AppLocalizations l10n) async {
    final LocalAuthentication auth = LocalAuthentication();
    String biometricText = "";

    try {
      final bool canCheckBiometrics = await auth.canCheckBiometrics;
      final bool isDeviceSupported = await auth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) {
        return "";
      }

      final List<BiometricType> availableBiometrics = await auth
          .getAvailableBiometrics();

      if (availableBiometrics.contains(BiometricType.face)) {
        biometricText = "Face ID";
      } else if (availableBiometrics.contains(BiometricType.fingerprint) ||
          availableBiometrics.contains(BiometricType.strong)) {
        biometricText = l10n.fingerprint; // Dùng text từ l10n
      }
    } catch (e) {
      debugPrint("Error checking biometric: $e");
    }

    return biometricText;
  }

  String getGreetingMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return l10n.good_morning;
    } else if (hour >= 12 && hour < 18) {
      return l10n.good_afternoon;
    } else if (hour >= 18 || hour < 5) {
      return l10n.good_evening;
    } else {
      return l10n.hello;
    }
  }
}
