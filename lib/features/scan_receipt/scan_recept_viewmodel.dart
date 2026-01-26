import 'dart:convert';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/model/location_model.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/ai_service.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/core/services/general_service/language_service.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/features/ai_preview/ai_preview_overview_view.dart';
import 'package:spend_flow/features/transaction/add_transaction/add_transaction_view.dart';

class ScanReceiptViewModel extends ChangeNotifier {
  CameraController? controller;
  Future<void>? initializeControllerFuture;

  final AIService _aiService = AIService();

  List<CategoryModel> categories = [];

  bool _isFlashOn = false;
  bool get isFlashOn => _isFlashOn;

  bool _isTakingPicture = false;
  bool get isTakingPicture => _isTakingPicture;

  bool _isScanning = false;
  bool get isScanning => _isScanning;

  void setCategories(List<CategoryModel> categories) {
    this.categories = categories;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      final firstCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      initializeControllerFuture = controller!.initialize();
      notifyListeners();
    } catch (e) {
      debugPrint("Camera init error: $e");
    }
  }

  Future<void> takePicture(BuildContext context) async {
    if (controller == null ||
        !controller!.value.isInitialized ||
        _isTakingPicture ||
        _isScanning) {
      return;
    }

    try {
      _isTakingPicture = true;
      notifyListeners();

      await initializeControllerFuture;
      final image = await controller!.takePicture();

      if (!context.mounted) return;

      await _processAndAnalyzeImage(context, image.path);
    } catch (e) {
      debugPrint("Error taking picture: $e");
    } finally {
      _isTakingPicture = false;
      notifyListeners();
    }
  }

  Future<void> pickFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null && context.mounted) {
        await _processAndAnalyzeImage(context, image.path);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> _processAndAnalyzeImage(
    BuildContext context,
    String imagePath,
  ) async {
    try {
      _isScanning = true;
      notifyListeners();

      final Uint8List? compressedBytes =
          await FlutterImageCompress.compressWithFile(
            imagePath,
            minWidth: 1024,
            minHeight: 1024,
            quality: 70,
            format: CompressFormat.jpeg,
          );

      if (compressedBytes == null) throw Exception("Image compression failed");

      String base64Image = base64Encode(compressedBytes);
      List<CategoryModel> currentCategories = CategoryData.getAll();
      final currentLanguage = LanguageService().locale.languageCode;
      final currentWalletId = await LocalStorageService().getCurrentWalletId();

      final dynamic rawResponse = await _aiService.analyzeImage(
        base64Image,
        currentCategories,
        currentLanguage,
      );

      final fullMap = Map<String, dynamic>.from(rawResponse);
      final List results = fullMap['results'] ?? [];

      if (results.isEmpty) {
        throw Exception("No data found in AI response");
      }

      final List<TransactionModel> parsedTransactions = [];
      Map<String, Map<String, double>?> locationCache = {};
      final DateTime today = DateTime.now().copyWith(
        hour: 23,
        minute: 59,
        second: 59,
      );

      for (var item in results) {
        final String actionType = item['actionType']?.toString() ?? "";
        final data = Map<String, dynamic>.from(item['data'] ?? {});

        if (actionType == "TRANSACTION") {
          var transaction = TransactionModel.fromAIResponse(
            aiData: data,
            availableCategories: currentCategories,
            currentWalletId: currentWalletId,
          );

          if (transaction.date.isAfter(today)) {
            continue;
          }

          if (transaction.location.address != null) {
            final addr = transaction.location.address!;
            Map<String, double>? coords;
            if (locationCache.containsKey(addr)) {
              coords = locationCache[addr];
            } else {
              coords = await getCoordinatesFromAddress(addr);
              locationCache[addr] = coords; 
            }

            if (coords != null) {
              transaction = transaction.copyWith(
                location: LocationModel(
                  address: addr,
                  latitude: coords['latitude'],
                  longitude: coords['longitude'],
                ),
              );
            }
          }
          parsedTransactions.add(transaction);
        }
      }

      if (parsedTransactions.isEmpty) {
        throw Exception("No valid transactions found in receipt");
      }

      HapticFeedback.mediumImpact();
      if (!context.mounted) return;

      bool? isSaved = false;

      if (parsedTransactions.length == 1) {
        isSaved = await Navigator.push<bool>(
          context,
          CupertinoPageRoute(
            builder: (context) =>
                AddTransactionPage(transactionData: parsedTransactions.first),
          ),
        );
      } else {
        isSaved = await Navigator.push<bool>(
          context,
          CupertinoPageRoute(
            builder: (context) =>
                AIPreviewOverviewView(transactions: parsedTransactions),
          ),
        );
      }

      if (context.mounted && isSaved == true) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      HapticFeedback.vibrate();
      if (context.mounted) {
        _showErrorDialog(context);
      }
    } finally {
      _isScanning = false;
      notifyListeners();
    }
  }

  Future<Map<String, double>?> getCoordinatesFromAddress(String address) async {
    if (address.isEmpty) return null;

    final apiKey = dotenv.env['GOONG_API_KEY'] ?? '';
 
    final encodedAddress = Uri.encodeComponent(address);
    final langCode = LanguageService().currentLanguageCode;

    final url = Uri.parse(
      "https://rsapi.goong.io/Geocode?address=$encodedAddress&api_key=$apiKey&language=$langCode",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          final location = data['results'][0]['geometry']['location'];
          return {"latitude": location['lat'], "longitude": location['lng']};
        } else {
          debugPrint("Goong Status: ${data['status']}");
        }
      }
    } catch (e) {
      debugPrint("Goong Geocoding Error: $e");
    }
    return null;
  }

 void _showErrorDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.error,
      message:
          l10n.scan_receipt_error,
      icon: 'doc.text.viewfinder', 
      actions: [
        AlertAction(
          title: l10n.close,
          style: AlertActionStyle.primary,
          onPressed: () {},
        ),
      ],
    );
  }

  Future<void> toggleFlash() async {
    if (controller == null) return;
    try {
      FlashMode newMode = _isFlashOn ? FlashMode.off : FlashMode.torch;
      await controller!.setFlashMode(newMode);
      _isFlashOn = !_isFlashOn;
      notifyListeners();
    } catch (e) {
      debugPrint("Error toggling flash: $e");
    }
  }

  void handleLifecycleChange(AppLifecycleState state) {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }
}
