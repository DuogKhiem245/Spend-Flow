import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';

const String _kProductMonthlyId = 'spendflow_premium_monthly';
const String _kProductYearlyId = 'spendflow_premium_yearly';
const String _kProductLifetimeId = 'spendflow_premium_lifetime';

enum PremiumPlan { monthly, yearly, lifetime }

class PremiumViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final InAppPurchase _iap = InAppPurchase.instance;

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  PremiumPlan _selectedPlan = PremiumPlan.monthly;
  PremiumPlan get selectedPlan => _selectedPlan;

  bool _isPremium = false;
  bool _isLoading = false;

  final Map<PremiumPlan, String> _storePrices = {};
  final Map<PremiumPlan, ProductDetails> _productDetailsMap = {};

  Timer? _timeoutTimer;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;

  String get priceString => planPrice(_selectedPlan);

  String planPrice(PremiumPlan plan) => _storePrices[plan] ?? '---';

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
          _cancelTimeout();
          _isLoading = false;
          notifyListeners();
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          _cancelTimeout();
          _errorMessage = null;
          await _setPremiumSuccess();
        } else if (purchaseDetails.status == PurchaseStatus.canceled) {
          _cancelTimeout();
          _isLoading = false;
          notifyListeners();
        }

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

  Future<void> purchasePremium(AppLocalizations l10n) async {
    final ProductDetails? details = _productDetailsMap[_selectedPlan];
    if (details == null) {
      debugPrint("Sản phẩm chưa sẵn sàng cho plan: $_selectedPlan");
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    _startTimeout(kind: 'purchase', l10n: l10n);

    final PurchaseParam purchaseParam = PurchaseParam(productDetails: details);

    try {
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      _cancelTimeout();
      _isLoading = false;
      _errorMessage = l10n.purchase_failed_description;
      notifyListeners();
    }
  }

  Future<void> restorePurchase(AppLocalizations l10n) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    _startTimeout(kind: 'restore', l10n: l10n);

    try {
      await _iap.restorePurchases();
    } catch (e) {
      _cancelTimeout();
      _isLoading = false;
      _errorMessage = l10n.restore_failed_description;
      notifyListeners();
      debugPrint("Lỗi khôi phục: $e");
    }
  }

  Future<void> _checkStatus() async {
    _isPremium = await _storage.getPremiumStatus();
    notifyListeners();
  }

  Future<void> _loadProducts() async {
    try {
      final bool available = await _iap.isAvailable();
      if (!available) {
        notifyListeners();
        return;
      }

      const Set<String> kIds = {
        _kProductMonthlyId,
        _kProductYearlyId,
        _kProductLifetimeId,
      };
      final ProductDetailsResponse response = await _iap.queryProductDetails(
        kIds,
      );

      if (response.notFoundIDs.isNotEmpty) {
        debugPrint("ID không tồn tại: ${response.notFoundIDs}");
      }

      PremiumPlan? planFromId(String id) {
        switch (id) {
          case _kProductMonthlyId:
            return PremiumPlan.monthly;
          case _kProductYearlyId:
            return PremiumPlan.yearly;
          case _kProductLifetimeId:
            return PremiumPlan.lifetime;
          default:
            return null;
        }
      }

      for (final pd in response.productDetails) {
        final plan = planFromId(pd.id);
        if (plan != null) {
          _productDetailsMap[plan] = pd;
          _storePrices[plan] = pd.price;
        }
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Lỗi tải sản phẩm: $e");
      notifyListeners();
    }
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

  void selectPlan(PremiumPlan plan) {
    _selectedPlan = plan;
    _errorMessage = null;
    notifyListeners();
  }

  void _startTimeout({required String kind, required AppLocalizations l10n}) {
    _timeoutTimer?.cancel();
    _timeoutTimer = Timer(const Duration(seconds: 30), () {
      if (_isLoading) {
        _isLoading = false;
        _errorMessage = kind == 'restore'
            ? l10n.restore_failed_description
            : l10n.purchase_failed_description;
        notifyListeners();
      }
    });
  }

  void _cancelTimeout() {
    _timeoutTimer?.cancel();
    _timeoutTimer = null;
  }

  void clearError() {
    _errorMessage = null;
    Future.microtask(() => notifyListeners());
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _timeoutTimer?.cancel();
    super.dispose();
  }
}
