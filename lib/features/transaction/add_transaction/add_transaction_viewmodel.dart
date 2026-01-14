import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/core/model/location_model.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/location_service.dart';
import '../../../core/model/category_model.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class AddTransactionViewmodel extends ChangeNotifier {
  final LocalStorageService _storageService = LocalStorageService();
  final LocationService _locationService = LocationService();

  String _currencySymbol = '\$';
  String get currencySymbol => _currencySymbol;

  Position? _currentPosition;
  String? _selectedAddress;
  bool _isLoadingLocation = true;

  Position? get currentPosition => _currentPosition;
  String? get selectedAddress => _selectedAddress;
  bool get isLoadingLocation => _isLoadingLocation;

  AddTransactionViewmodel() {
    _loadCurrency();
  }

  Future<void> _loadCurrency() async {
    final Map<String, String> currencyData = await _storageService
        .getCurrency();
    _currencySymbol = currencyData['symbol'] ?? '\$';
    notifyListeners();
  }

  Future<String?> _getCurrentWalletId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_wallet_id');
  }

  Future<void> addExpenseTransaction(
    String amount,
    String name,
    CategoryModel? selectedCategory,
    DateTime? transactionDate,
    String note,  
  ) async {
    if (selectedCategory == null) return;

    final double value = _parseAmount(amount);
    if (value == 0) return;

    final walletId = await _getCurrentWalletId();

    if (walletId == null) {
      return;
    }

    final locationData = _getLocationFromState();

    final transaction = TransactionModel(
      walletId: walletId, 
      amount: value.abs(),
      title: name.isEmpty ? selectedCategory.name : name,
      category: selectedCategory,
      date: transactionDate ?? DateTime.now(),
      note: note,
      isIncome: false,
      location: locationData,
    );

    await _storageService.addTransaction(transaction);
  }

  Future<void> addIncomeTransaction(
    String amount,
    String name,
    CategoryModel? selectedCategory,
    DateTime? transactionDate,
    String note,
  ) async {
    if (selectedCategory == null) return;

    final double value = _parseAmount(amount);
    if (value == 0) return;

    final walletId = await _getCurrentWalletId();

    if (walletId == null) {
      return;
    }

    final locationData = _getLocationFromState();

    final transaction = TransactionModel(
      walletId: walletId, 
      amount: value.abs(),
      title: name.isEmpty ? selectedCategory.name : name,
      category: selectedCategory,
      date: transactionDate ?? DateTime.now(),
      note: note,
      isIncome: true,
      location: locationData,
    );

    await _storageService.addTransaction(transaction);
  }

  Future<void> getCurrentLocation() async {
    _isLoadingLocation = true;
    notifyListeners();

    try {
      final geoPos = await _locationService.getCurrentPosition();

      if (geoPos != null) {
        _currentPosition = Position(geoPos.longitude, geoPos.latitude);
      } else {
        _currentPosition = null;
      }
          
    } catch (e) {
      _currentPosition = null;
    } finally {
      _isLoadingLocation = false;
      notifyListeners();
    }
  }

  void updateLocation(Position position, String addressName) {
    _currentPosition = position;
    _selectedAddress = addressName;
    _isLoadingLocation = false;
    notifyListeners();
  }

  LocationModel _getLocationFromState() {
    if (_currentPosition == null) {
      return const LocationModel(); 
    }
    return LocationModel(
      latitude: _currentPosition!.lat.toDouble(),
      longitude: _currentPosition!.lng.toDouble(),
      address: _selectedAddress ?? '', 
    );
  }

  double _parseAmount(String input) {
    if (input.isEmpty) return 0.0;

    String cleanString = input.replaceAll('.', '');

    cleanString = cleanString.replaceAll(',', '.');

    return double.tryParse(cleanString) ?? 0.0;
  }
}
