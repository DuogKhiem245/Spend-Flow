import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/ai_service.dart';
import 'package:spend_flow/core/model/category_model.dart';
import 'package:spend_flow/features/transaction/add_transaction/add_transaction_view.dart';

class ScanReceiptViewModel extends ChangeNotifier {
  CameraController? controller;
  Future<void>? initializeControllerFuture;

  final AIService _aiService = AIService();

  List<CategoryModel> _categories = [];

  bool _isFlashOn = false;
  bool get isFlashOn => _isFlashOn;

  bool _isTakingPicture = false;
  bool get isTakingPicture => _isTakingPicture;

  bool _isScanning = false;
  bool get isScanning => _isScanning;

  void setCategories(List<CategoryModel> categories) {
    _categories = categories;
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

      if (compressedBytes == null) {
        throw Exception("Image compression failed");
      }

      String base64Image = base64Encode(compressedBytes);

      List<CategoryModel> currentCategories = CategoryData.getAll();

      final aiResult = await _aiService.analyzeImage(
        base64Image,
        currentCategories,
      );

      if (!context.mounted) return;

      final transactionData = TransactionModel.fromAIResponse(
        aiData: aiResult,
        availableCategories: currentCategories,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AddTransactionPage(
            transactionData: transactionData,
          ),
        ),
      );
    } catch (e) {
      debugPrint("Error during scanning/analysis: $e");

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Lỗi xử lý: ${e.toString()}")));
      }
    } finally {
      _isScanning = false;
      notifyListeners();
    }
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
