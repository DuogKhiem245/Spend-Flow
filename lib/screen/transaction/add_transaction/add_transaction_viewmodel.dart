import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart' show Geolocator, LocationPermission;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/core/model/location_model.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/sercurity_service/location_service.dart';
import '../../../core/model/category_model.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class AddTransactionViewmodel extends ChangeNotifier {
  final LocalStorageService _storageService = LocalStorageService();
  final LocationService _locationService = LocationService();

  String _currencySymbol = '\$';
  String get currencySymbol => _currencySymbol;

  Position? _currentPosition;
  String? _selectedAddress;
  bool? _isLocationEnabled;

  Position? get currentPosition => _currentPosition;
  String? get selectedAddress => _selectedAddress;
  bool? get isLocationEnabled => _isLocationEnabled;

  Future<void>? _locationTask;

  AddTransactionViewmodel({bool initialize = true}) {
    if (initialize) {
      _initialize();
    } else {
      _loadCurrency();
      notifyListeners();
    }
  }

  Future<void> _initialize() async {
    await _loadCurrency();
    _isLocationEnabled = await _storageService.getLocationStatus();

    await _safeLocationInitialization();

    notifyListeners();
  }

  Future<void> _safeLocationInitialization() async {
    if (_locationTask != null) return _locationTask;

    _locationTask = Future(() async {
      try {
        if (_isLocationEnabled == null) {
          final permissionGranted = await _locationService.requestPermission();

          _isLocationEnabled = permissionGranted;
          await _storageService.saveLocationStatus(permissionGranted);

          if (permissionGranted) {
            await getCurrentLocation(isAutoInit: true);
          } else {
            notifyListeners();
          }
        } else if (_isLocationEnabled == true) {
          await getCurrentLocation(isAutoInit: true);
        }
      } catch (e) {
        debugPrint('Location Init Error: $e');
      } finally {
        _locationTask = null;
      }
    });
    notifyListeners();
    return _locationTask;
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
    LocationModel? location,
  ) async {
    if (selectedCategory == null) return;

    final double value = _parseAmount(amount);
    if (value == 0) return;

    final walletId = await _getCurrentWalletId();

    if (walletId == null) {
      return;
    }

    final locationData = location ?? getLocationFromState();

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
    LocationModel? location,
  ) async {
    if (selectedCategory == null) return;    

    final double value = _parseAmount(amount);
    if (value == 0) return;

    final walletId = await _getCurrentWalletId();

    if (walletId == null) {
      return;
    }

    final locationData = location ?? getLocationFromState();

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

  Future<Position?> getCurrentLocation({bool isAutoInit = false}) async {
    if (isLocationEnabled == false) {
      return null;
    }
    final geoPos = await _locationService.getCurrentPosition();

    if (isAutoInit && _currentPosition != null) {
      return _currentPosition;
    }

    if (geoPos != null) {
      if (!isAutoInit) _selectedAddress = null;
      return _currentPosition = Position(geoPos.longitude, geoPos.latitude);
    } else {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await _storageService.saveLocationStatus(false);
        _isLocationEnabled = false;
        notifyListeners();
      }
    }
    return null;
  }

  void updateLocation(Position position, String addressName) {
    _currentPosition = position;
    _selectedAddress = addressName;
    notifyListeners();
  }

  LocationModel getLocationFromState() {
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
