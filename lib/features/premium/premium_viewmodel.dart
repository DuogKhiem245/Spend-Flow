import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';

// ID sản phẩm Premium Lifetime của bạn
const String _kProductId = 'spendflow_premium_lifetime';

class PremiumViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final InAppPurchase _iap = InAppPurchase.instance;

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  bool _isPremium = false;
  bool _isLoading = false;

  String? _storePrice;
  ProductDetails? _productDetails;

  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;
  String get priceString => _storePrice ?? '---';

  PremiumViewModel() {
    _checkStatus();

    _loadProducts();

    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () {
        _subscription?.cancel();
      },
      onError: (error) {
        debugPrint("Lỗi Purchase Stream: $error");
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> _listenToPurchaseUpdated(
    List<PurchaseDetails> purchaseDetailsList,
  ) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _isLoading = true;
        notifyListeners();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          debugPrint("Lỗi mua hàng: ${purchaseDetails.error}");
          _isLoading = false;
          notifyListeners();
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          // Mua hoặc khôi phục thành công!
          await _setPremiumSuccess();
        } else if (purchaseDetails.status == PurchaseStatus.canceled) {
          _isLoading = false;
          notifyListeners();
        }

        // Bắt buộc: Xác nhận giao dịch với Store để tránh bị refund tự động
        if (purchaseDetails.pendingCompletePurchase) {
          await _iap.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> _setPremiumSuccess() async {
    await _storage.setPremiumStatus(
      true,
      DateTime.now().add(const Duration(days: 30)),
    );
    _isPremium = true;
    _isLoading = false;

    notifyListeners();
  }

  Future<void> purchasePremium() async {
    if (_productDetails == null) {
      debugPrint("Sản phẩm chưa sẵn sàng");
      return;
    }

    _isLoading = true;
    notifyListeners();

    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: _productDetails!,
    );

    try {
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Không thể bắt đầu thanh toán: $e");
    }
  }

  Future<void> restorePurchase() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _iap.restorePurchases();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint("Lỗi khôi phục: $e");
    }
  }

  Future<void> _checkStatus() async {
    _isPremium = await _storage.getPremiumStatus();
    notifyListeners();
  }

  Future<void> _loadProducts() async {
    // try {
    //   final bool available = await _iap.isAvailable();
    //   if (!available) {
    //     _storePrice = "N/A";
    //     notifyListeners();
    //     return;
    //   }

    //   const Set<String> kIds = {_kProductId};
    //   final ProductDetailsResponse response = await _iap.queryProductDetails(
    //     kIds,
    //   );

    //   if (response.notFoundIDs.isNotEmpty) {
    //     debugPrint("ID không tồn tại: ${response.notFoundIDs}");
    //   }

    //   if (response.productDetails.isNotEmpty) {
    //     _productDetails = response.productDetails.first;
    //     _storePrice = _productDetails!.price;
    //     notifyListeners();
    //   }
    // } catch (e) {
    //   debugPrint("Lỗi tải sản phẩm: $e");
    //   _storePrice = "Error";
    //   notifyListeners();
    // }

    _storePrice = "99.000đ (Demo)";
    _productDetails = ProductDetails(
      id: _kProductId,
      title: "Premium Lifetime",
      description: "Mở khóa toàn bộ tính năng",
      price: "99.000đ",
      rawPrice: 99000,
      currencyCode: "VND",
    );
    notifyListeners();
  }

  Future<void> debugFakePurchase({bool shouldNotify = true}) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    await _storage.setPremiumStatus(
      true,
      DateTime.now().add(const Duration(days: 30)),
    );
    _isPremium = true;
    _isLoading = false;

    if (shouldNotify) {
      notifyListeners();
    }
  }

  void refreshPremiumStatus() {
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
