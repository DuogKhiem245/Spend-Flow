import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';

// Đặt ID sản phẩm trùng với ID bạn tạo trên App Store Connect / Google Play Console
const String _kProductId = 'spendflow_premium_lifetime';

class PremiumViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final InAppPurchase _iap = InAppPurchase.instance;

  bool _isPremium = false;
  bool _isLoading = false;

  String? _storePrice;
  ProductDetails? _productDetails;

  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;

  String get priceString => _storePrice ?? '';

  PremiumViewModel() {
    _checkStatus();
    _loadProducts();
  }

  Future<void> _checkStatus() async {
    _isPremium = await _storage.getPremiumStatus();
    notifyListeners();
  }

  Future<void> _loadProducts() async {
    try {
      final bool available = await _iap.isAvailable();

      if (!available) {
        debugPrint("Store không khả dụng (Do máy ảo hoặc chưa setup IAP)");
        _storePrice = "N/A (No Store)"; 
        notifyListeners();
        return;
      }

      const Set<String> kIds = {_kProductId};
      final ProductDetailsResponse response = await _iap.queryProductDetails(
        kIds,
      );

      // Trường hợp 1: ID bị sai hoặc chưa Active trên Store
      if (response.notFoundIDs.isNotEmpty) {
        debugPrint("Không tìm thấy ID sản phẩm: ${response.notFoundIDs}");
        _storePrice = "Err: ID Not Found";
        notifyListeners();
        return; 
      }

      // Trường hợp 2: Tìm thấy sản phẩm
      if (response.productDetails.isNotEmpty) {
        _productDetails = response.productDetails.first;
        _storePrice = _productDetails!.price;
        notifyListeners();
      } else {
        // Trường hợp 3: Danh sách rỗng mà không báo lỗi ID (Hiếm gặp)
        _storePrice = "Unavailable";
        notifyListeners();
      }

    } catch (e) {
      debugPrint("Lỗi kết nối Store: $e");
      _storePrice = "Error Connect";
      notifyListeners();
    }
  }

  Future<void> purchasePremium() async {
    if (_productDetails == null) {
      debugPrint("Chưa load được sản phẩm, không thể mua");
      return;
    }

    _isLoading = true;
    notifyListeners();

    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: _productDetails!,
    );

    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchase() async {
    _isLoading = true;
    notifyListeners();

    // await Future.delayed(const Duration(seconds: 2));
    await _storage.setPremiumStatus(true, DateTime.now().add(const Duration(days: 30)),
    );
    _isPremium = true;
    _isLoading = false;
    notifyListeners();
  }
}
