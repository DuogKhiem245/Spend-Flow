import 'dart:async';
import 'dart:math';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/ai_service.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/general_service/language_service.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/screen/ai_preview/ai_preview_overview_view.dart';
import 'package:spend_flow/screen/transaction/add_transaction/add_transaction_view.dart';

class VoiceInputViewModel extends ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();
  final AIService _aiService = AIService();
  final LocalStorageService _localStorageService = LocalStorageService();

  bool _isListening = false;
  bool _isSpeechEnabled = false;
  String _lastWords = '';

  bool _isProcessing = false;
  bool _isDisposed = false;

  List<double> heights = List.filled(7, 20.0);
  Timer? _waveTimer;
  final Random _random = Random();

  bool get isListening => _isListening;
  String get lastWords => _lastWords;
  bool get isSpeechEnabled => _isSpeechEnabled;
  bool get isProcessing => _isProcessing;

  Future<void> initSpeech() async {
    try {
      _isSpeechEnabled = await _speechToText.initialize(
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            _isListening = false;
            _stopWaveAnimation();
            _safeNotifyListeners();
          }
        },
        onError: (errorNotification) {
          _isListening = false;
          _stopWaveAnimation();
          _safeNotifyListeners();
        },
      );
      _safeNotifyListeners();
    } catch (e) {
      debugPrint("Error initializing speech: $e");
    }
  }

  Future<bool> _checkPermission(BuildContext context) async {
    var status = await Permission.microphone.status;
    if (status.isGranted) {
      return true;
    }

    debugPrint("Microphone permission status: $status");

    if (status.isPermanentlyDenied) {
      debugPrint("Microphone permission permanently denied.");
      if (context.mounted) {
        _showPermissionDialog(context);
      }
      return false;
    }

    final result = await Permission.microphone.request();
    if (result.isGranted) {
      return true;
    }

    if (result.isDenied || result.isPermanentlyDenied) {
      if (context.mounted) {
        _showPermissionDialog(context);
      }
      return false;
    }

    return false;
  }

  void _showPermissionDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.permission_required_voice_input,
      message: l10n.permission_required_voice_input_description,
      icon: 'mic.fill',
      actions: [
        AlertAction(
          title: l10n.cancel,
          style: AlertActionStyle.cancel,
          onPressed: () => {},
        ),
        AlertAction(
          title: l10n.settings,
          style: AlertActionStyle.primary,
          onPressed: () {
            openAppSettings();
          },
        ),
      ],
    );
  }

  Future<void> startListening(BuildContext context, String localeId) async {
    final hasPermission = await _checkPermission(context);
    if (!hasPermission) return;

    if (!_isSpeechEnabled) {
      await initSpeech();
    }

    if (_isSpeechEnabled) {
      _isListening = true;
      _lastWords = '';
      _startWaveAnimation();
      _safeNotifyListeners();

      await _speechToText.listen(
        onResult: (result) {
          _lastWords = result.recognizedWords;
          _safeNotifyListeners();
        },
        localeId: localeId,
        // listenFor: const Duration(seconds: 45), // Optional: limit listening duration
        listenOptions: SpeechListenOptions(
          cancelOnError: true,
          listenMode: ListenMode.confirmation,
        ),
      );
    }
  }

  void toggleListening(BuildContext context, String localeId) {
    if (_isListening) {
      stopListening();
      processVoiceInput(context);
    } else {
      startListening(context, localeId);
    }
  }

  Future<void> stopListening() async {
    _isListening = false;
    _stopWaveAnimation();
    await _speechToText.stop();
    _safeNotifyListeners();
  }

  Future<void> processVoiceInput(BuildContext context) async {
    if (_lastWords.isEmpty) return;
    final l10n = AppLocalizations.of(context)!;

    try {
      _isProcessing = true;
      _safeNotifyListeners();

      final categories = CategoryData.getAll();
      final currentLanguage = LanguageService().locale.languageCode;
      final currentWalletId = await _localStorageService.getCurrentWalletId();

      final aiResult = await _aiService.analyzeText(
        _lastWords,
        categories,
        currentLanguage,
      );

      final List results = aiResult['results'] ?? [];

      if (results.isEmpty) {
        throw Exception(l10n.error_ai_request);
      }

      final List<TransactionModel> parsedTransactions = [];

      for (var item in results) {
        final String actionType = item['actionType']?.toString() ?? "";
        final data = Map<String, dynamic>.from(item['data'] ?? {});

        if (actionType == "TRANSACTION") {
          parsedTransactions.add(
            TransactionModel.fromAIResponse(
              aiData: data,
              availableCategories: categories,
              currentWalletId: currentWalletId,
            ),
          );
        }
      }

      if (!context.mounted) return;

      if (parsedTransactions.isEmpty) {
        throw Exception(l10n.error_ai_request);
      }

      bool? isSaved = false;

      if (parsedTransactions.length == 1) {
        isSaved = await Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) =>
                AddTransactionPage(transactionData: parsedTransactions.first),
          ),
        );
      } else {
        isSaved = await Navigator.pushReplacement(
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
      debugPrint("Error processing voice input: $e");
      if (context.mounted) {
        _showErrorDialog(context, l10n);
      }
    } finally {
      _isProcessing = false;
      _safeNotifyListeners();
    }
  }

  void _showErrorDialog(BuildContext context, AppLocalizations l10n) {
    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.error,
      message: l10n.voice_input_error,
      icon: 'mic.slash.fill',
      actions: [
        AlertAction(
          title: l10n.close,
          style: AlertActionStyle.primary,
          onPressed: () {
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }

  void _startWaveAnimation() {
    _waveTimer?.cancel();
    _waveTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      for (int i = 0; i < heights.length; i++) {
        heights[i] = 20.0 + _random.nextInt(50).toDouble();
      }
      _safeNotifyListeners();
    });
  }

  void _stopWaveAnimation() {
    _waveTimer?.cancel();
    heights = List.filled(7, 20.0);
    _safeNotifyListeners();
  }

  void _safeNotifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _waveTimer?.cancel();
    _speechToText.cancel();
    super.dispose();
  }
}
