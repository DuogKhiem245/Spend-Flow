import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/purchase_service.dart';

enum PremiumPlan { monthly, yearly, lifetime }

class PremiumViewModel extends ChangeNotifier {
  final PremiumService _service = PremiumService();

  PremiumPlan _selectedPlan = PremiumPlan.monthly;
  bool _isPremium = false;
  bool _isLoading = false;
  String? _errorMessage;

  final Map<PremiumPlan, Package> _packagesMap = {};
  final Map<PremiumPlan, String> _storePrices = {};

  PremiumPlan get selectedPlan => _selectedPlan;
  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String planPrice(PremiumPlan plan) => _storePrices[plan] ?? '---';

  bool _showSuccessDialog = false;
  bool _showRestoreSuccessDialog = false;
  
  bool get showSuccessDialog => _showSuccessDialog;
  bool get showRestoreSuccessDialog => _showRestoreSuccessDialog;

  PremiumViewModel(String? userId) {
    _setup(userId);
  }

  Future<void> _setup(String? userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _service.init(userId);

      _service.setCustomerInfoListener((info) {
        _isPremium = info.entitlements.all["Spend Flow Premium"]?.isActive ?? false;
        notifyListeners();
      });

      await _loadOfferings();
    } catch (e) {
      debugPrint("Premium Setup Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _loadOfferings() async {
    try {
      final offerings = await _service.getOfferings();
      if (offerings.current != null) {
        for (var package in offerings.current!.availablePackages) {
          final plan = _mapPackageToPlan(package.packageType);
          if (plan != null) {
            _packagesMap[plan] = package;
            _storePrices[plan] = package.storeProduct.priceString;
          }
        }
      }
    } catch (e) {
      debugPrint("Load Offerings Error: $e");
    }
  }

  PremiumPlan? _mapPackageToPlan(PackageType type) {
    switch (type) {
      case PackageType.monthly:
        return PremiumPlan.monthly;
      case PackageType.annual:
        return PremiumPlan.yearly;
      case PackageType.lifetime:
        return PremiumPlan.lifetime;
      default:
        return null;
    }
  }

  Future<void> purchasePremium(AppLocalizations l10n) async {
    final package = _packagesMap[_selectedPlan];
    if (package == null) return;

    _isLoading = true;
    _errorMessage = null;
    _showSuccessDialog = false;
    notifyListeners();

    try {
      final customerInfo = await _service.purchase(package);

      final bool hasPremium =
          customerInfo?.entitlements.all["Spend Flow Premium"]?.isActive ?? false;

      if (hasPremium) {
        _isPremium = true;
        _showSuccessDialog = true; 
      } else {
        _errorMessage =
            "Giao dịch thành công nhưng chưa kích hoạt được quyền lợi.";
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);

      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        _errorMessage = l10n.cancel_purchase;
      } else {
        _errorMessage = l10n.purchase_failed_description;
      }
    } catch (e) {
      _errorMessage = l10n.purchase_failed_description;
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }

  Future<void> restorePurchase(AppLocalizations l10n) async {
   _isLoading = true;
    _errorMessage = null;
    _showSuccessDialog = false;
    _showRestoreSuccessDialog = false;
    notifyListeners();

    try {
      final info = await _service.restore();
      if (info.entitlements.all["Spend Flow Premium"]?.isActive ?? false) {
        _isPremium = true;
        _showRestoreSuccessDialog = true; 
      } else {
        _errorMessage = "Không tìm thấy giao dịch nào để khôi phục.";
      }
    } catch (e) {
      _errorMessage = l10n.restore_failed_description;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectPlan(PremiumPlan plan) {
    _selectedPlan = plan;
    notifyListeners();
  }

  void clearStatus() {
    _showSuccessDialog = false;
    _showRestoreSuccessDialog = false;
    _errorMessage = null;
    notifyListeners();
  }
}
