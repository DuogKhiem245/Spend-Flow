import 'package:flutter/material.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';

class CreateOrUpdateViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();

  final bool isChangeMode; 
  final bool isRemoveMode; 

  String? _savedPasscode;

  CreateOrUpdateViewModel({
    required this.isChangeMode,
    this.isRemoveMode = false,
  }) {
    _loadSavedPasscode();
  }

  Future<void> _loadSavedPasscode() async {
    _savedPasscode = await _storage.getPasscode();
    notifyListeners();
  }

  Future<String?> submit({
    required String currentCode,
    required String newCode,
    required String confirmCode,
    required BuildContext context,
  }) async {
    final l10n = AppLocalizations.of(context)!;
    if (isRemoveMode) {
      if (currentCode != _savedPasscode) {
        return l10n.currentPasscodeIncorrect;
      }
      try {
        await _storage.removePasscode();
        return null; 
      } catch (e) {
        return l10n.errorSavingData;
      }
    }

    if (isChangeMode) {
      if (currentCode != _savedPasscode) {
        return l10n.currentPasscodeIncorrect;
      }
    }

    if (newCode.length != 6) {
      return l10n.newPasscodeMustBe6Digits;
    }

    if (newCode != confirmCode) {
      return l10n.passcodesDoNotMatch;
    }

    try {
      await _storage.savePasscode(newCode);
      return null;
    } catch (e) {
      return l10n.errorSavingData;
    }
  }
}
