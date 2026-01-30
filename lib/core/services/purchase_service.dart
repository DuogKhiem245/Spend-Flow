import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';

class PremiumService {
  final LocalStorageService _storage = LocalStorageService();

  Future<void> init(String? userId) async {
    await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration("test_NGmuOndCaRRGaFJHPInPDiWCKAk");
    } else {
      configuration = PurchasesConfiguration("test_NGmuOndCaRRGaFJHPInPDiWCKAk");
    }

    if (userId != null && userId.isNotEmpty) {
      configuration.appUserID = userId;
    }

    await Purchases.configure(configuration);
  }

  Future<Offerings> getOfferings() async {
    return await Purchases.getOfferings();
  }

  Future<CustomerInfo?> purchase(Package package) async {
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      await _syncStatusWithStorage(result.customerInfo);
      return result.customerInfo;
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        debugPrint("Purchase Error: $e");
        rethrow;
      }
      return null;
    }
  }

  Future<CustomerInfo> restore() async {
    final info = await Purchases.restorePurchases();
    await _syncStatusWithStorage(info);
    return info;
  }

  Future<bool> _syncStatusWithStorage(CustomerInfo info) async {
    final entitlement = info.entitlements.all["Spend Flow Premium"];
    final bool isActive = entitlement?.isActive ?? false;

    if (isActive && entitlement != null) {
      final String? expirationDateString = entitlement.expirationDate;
      DateTime? expirationDate;

      if (expirationDateString != null) {
        expirationDate = DateTime.parse(expirationDateString);
      } else {
        expirationDate = DateTime.now().add(
          const Duration(days: 36500),
        ); 
      }
      await _storage.setPremiumStatus(true, expirationDate);

    } else {
      await _storage.setPremiumStatus(false, null);
    }

    return isActive;
  }

  void setCustomerInfoListener(Function(CustomerInfo) onUpdate) {
    Purchases.addCustomerInfoUpdateListener(onUpdate);
  }
}
