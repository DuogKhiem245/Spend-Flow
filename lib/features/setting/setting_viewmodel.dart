import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';

enum BiometricDisplayType { faceId, touchId, none }

class SettingViewmodel {

  Future<String> checkBiometricSupport(AppLocalizations l10n) async {
    final LocalAuthentication auth = LocalAuthentication();
    String biometricText = ""; 

    try {
      final List<BiometricType> availableBiometrics = await auth
          .getAvailableBiometrics();

      if (availableBiometrics.contains(BiometricType.face)) {
        biometricText = "Face ID";
      } else if (availableBiometrics.contains(BiometricType.fingerprint) ||
          availableBiometrics.contains(BiometricType.strong)) {
        biometricText = l10n.fingerprint;
      }
    } catch (e) {
      debugPrint("Lỗi check biometric: $e");
    }

    return biometricText;
  }

  
}