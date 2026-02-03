import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PremiumService {
  Future<void> init(String? userId) async {
    await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(
        "test_NGmuOndCaRRGaFJHPInPDiWCKAk",
      );
    } else {
      configuration = PurchasesConfiguration(
        "test_NGmuOndCaRRGaFJHPInPDiWCKAk",
      );
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

  Future<bool> isUserPremium() async {
    try {
      CustomerInfo info = await Purchases.getCustomerInfo();
      return info.entitlements.all["Spend Flow Premium"]?.isActive ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<CustomerInfo> restore() async {
    final info = await Purchases.restorePurchases();
    return info;
  }

  Future<void> logIn(String userId) async {
    await Purchases.logIn(userId);
  }

  Future<void> logOut() async {
    await Purchases.logOut();
    await Purchases.restorePurchases();
  }

  void setCustomerInfoListener(Function(CustomerInfo) onUpdate) {
    Purchases.addCustomerInfoUpdateListener(onUpdate);
  }
}
