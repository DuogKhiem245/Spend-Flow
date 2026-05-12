import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PremiumService {
  String androidApiKey = dotenv.env['PURCHASES_API_KEY_ANDROID'] ?? '';
  String iosApiKey = dotenv.env['PURCHASES_API_KEY_IOS'] ?? '';

  Future<void> init(String? userId) async {
    await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(androidApiKey);
    } else {
      configuration = PurchasesConfiguration(iosApiKey);
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

  Future<bool> restorePurchases() async {
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      return customerInfo.entitlements.all["Spend Flow Premium"]?.isActive == true;
    } on PlatformException catch (e) {
      debugPrint("Failed to restore purchases: ${e.message}");
      return false;
    }
  }

  Future<void> logIn(String userId) async {
    await Purchases.logIn(userId);
  }

  Future<void> logOut() async {
    // CHỈ ĐĂNG XUẤT. Tuyệt đối không gọi restorePurchases() ở đây
    // để tránh bị cướp quyền qua tài khoản ẩn danh.
    await Purchases.logOut();
  }

  void setCustomerInfoListener(Function(CustomerInfo) onUpdate) {
    Purchases.addCustomerInfoUpdateListener(onUpdate);
  }
}
