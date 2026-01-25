import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/services/sercurity_service/location_service.dart';

enum BiometricDisplayType { faceId, touchId, none }

class SettingViewModel extends ChangeNotifier {
  final _localStorage = LocalStorageService();
  final LocationService _locationService = LocationService();

  static final SettingViewModel _instance = SettingViewModel._internal();
  factory SettingViewModel() => _instance;

  bool _isLocationEnabled = false;
  bool get isLocationEnabled => _isLocationEnabled;

  SettingViewModel._internal() {
    loadSettings();
  }

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

  Future<void> initLocationState() async {
    final status = await _locationService.requestPermission();
    _localStorage.saveLocationStatus(status);
    _isLocationEnabled = status;
    notifyListeners();
  }

  Future<void> toggleLocation(bool value, BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever && value == true) {
      if (!context.mounted) return;
      _showOpenSettingsDialog(context);
      notifyListeners();
      return;
    }

    if (value) {
      final granted = await _locationService.requestPermission();
      if (granted) {
        _isLocationEnabled = true;
        await _localStorage.saveLocationStatus(true);
      } else {
        _isLocationEnabled = false;
        await _localStorage.saveLocationStatus(false);
      }
    } else {
      _isLocationEnabled = false;
      await _localStorage.saveLocationStatus(false);
    }

    notifyListeners();
  }

  Future<void> loadLocationState() async {
    if (await _localStorage.getLocationStatus() == null) {
      await _locationService.requestPermission();
    }
    notifyListeners();
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

  void _showOpenSettingsDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(l10n.location_permission_denied),
        content: Text(l10n.settings),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.cancel),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text(l10n.settings),
            onPressed: () {
              Navigator.pop(context);
              _locationService.openAppSettings();
            },
          ),
        ],
      ),
    );
  }
}
