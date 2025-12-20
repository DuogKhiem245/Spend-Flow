import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';

enum BiometricDisplayType { faceId, touchId, none }

class SecurityViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final LocalAuthentication _auth = LocalAuthentication();

  bool _isBiometricEnabled = false;
  bool _isPasscodeEnabled = false;
  bool _isLoading = true;
  BiometricDisplayType _biometricType = BiometricDisplayType.none;

  bool get isBiometricEnabled => _isBiometricEnabled;
  bool get isPasscodeEnabled => _isPasscodeEnabled;
  bool get isLoading => _isLoading;
  BiometricDisplayType get biometricType => _biometricType;

  IconData get biometricIcon {
    if (_biometricType == BiometricDisplayType.faceId) return CupertinoIcons.smiley; 
    if (_biometricType == BiometricDisplayType.touchId) return CupertinoIcons.hand_draw;
    return CupertinoIcons.lock_shield;
  }

  SecurityViewModel() {
    loadSettings(showLoading: true);
  }

  Future<void> loadSettings({bool showLoading = true}) async {
    if (showLoading) {
      _isLoading = true;
      notifyListeners();
    }

    try {
      await _checkBiometricType();

      final hasPass = await _storage.hasPasscode();
      final bioEnabled = await _storage.isFaceIdEnabled();

      _isPasscodeEnabled = hasPass;
      _isBiometricEnabled = bioEnabled && hasPass;
    } catch (e) {
      debugPrint("Lỗi load settings: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _checkBiometricType() async {
    try {
      List<BiometricType> availableBiometrics = await _auth
          .getAvailableBiometrics();

      if (availableBiometrics.contains(BiometricType.face)) {
        _biometricType = BiometricDisplayType.faceId;
      } else if (availableBiometrics.contains(BiometricType.fingerprint) ||
          availableBiometrics.contains(BiometricType.strong)) {
        _biometricType = BiometricDisplayType.touchId;
      } else {
        _biometricType = BiometricDisplayType.none;
      }
    } catch (e) {
      _biometricType = BiometricDisplayType.none;
    }
  }

  Future<String?> toggleBiometric(bool value) async {
    if (!value) {
      await _storage.setFaceIdEnabled(false);
      _isBiometricEnabled = false;
      notifyListeners();
      return null;
    }

    if (!_isPasscodeEnabled) {
      notifyListeners();
      return "Vui lòng thiết lập Mã khóa (Passcode) trước khi bật Face ID.";
    }

    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();

      if (!canAuthenticate) {
        return "Thiết bị của bạn không hỗ trợ xác thực sinh trắc học.";
      }

      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Vui lòng xác thực để bật tính năng này',
        sensitiveTransaction: true,
        biometricOnly: true,
      );

      if (didAuthenticate) {
        await _storage.setFaceIdEnabled(true);
        _isBiometricEnabled = true;
        notifyListeners();
        return null; 
      } else {
        notifyListeners();
        return "Xác thực thất bại. Vui lòng thử lại.";
      }
    } catch (e) {
      notifyListeners();
      return "Đã xảy ra lỗi khi xác thực: $e";
    }
  }

  Future<void> reload() async {
    await loadSettings(showLoading: false);
  }

  bool isFaceId() {
    if (_biometricType == BiometricDisplayType.faceId) {
      return true; 
    }
    return false;
  }
}
