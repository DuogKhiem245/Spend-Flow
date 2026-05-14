import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
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

  Future<void> initLocationState(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _isLocationEnabled = isServiceEnabled;
      await _localStorage.saveLocationStatus(true);
    } else {
      _isLocationEnabled = false;
    }

    notifyListeners();

    if (permission == LocationPermission.deniedForever) {
      final status = await _localStorage.getLocationStatus();
      if (status == true && context.mounted) {
        _showOpenSettingsDialog(context);
      }
    }
  }

  Future<void> loadLocationState(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _isLocationEnabled = true;
      await _localStorage.saveLocationStatus(true);
    } else {
      _isLocationEnabled = false;
      await _localStorage.saveLocationStatus(false);
    }
    notifyListeners();
  }

  Future<void> toggleLocation(bool value, BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever && value == true) {
      if (!context.mounted) return;
      _showOpenSettingsDialog(context);
      _isLocationEnabled = false;
      notifyListeners();
      return;
    }

    if (value) {
      final granted = await _locationService.requestPermission();
      _isLocationEnabled = granted;
      await _localStorage.saveLocationStatus(granted);
    } else {
      _isLocationEnabled = false;
      await _localStorage.saveLocationStatus(false);
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

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.permission_required_location,
      message: l10n.permission_required_location_description,
      icon: 'location.circle.fill',
      actions: [
        AlertAction(
          title: l10n.cancel,
          style: AlertActionStyle.cancel,
          onPressed: () => {},
        ),
        AlertAction(
          title: l10n.settings,
          style: AlertActionStyle.primary,
          onPressed: () {
            _locationService.openAppSettings();
          },
        ),
      ],
    );
  }
}
