import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/ai_service.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/language_service.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/features/ai_preview/ai_preview_overview_view.dart';
import 'package:spend_flow/features/transaction/add_transaction/add_transaction_view.dart';

class VoiceInputViewModel extends ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();
  final AIService _aiService = AIService();
  final LocalStorageService _localStorageService = LocalStorageService();

  bool _isListening = false;
  bool _isSpeechEnabled = false;
  String _lastWords = '';

  bool _isProcessing = false;

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
            notifyListeners();
          }
        },
        onError: (errorNotification) {
          _isListening = false;
          _stopWaveAnimation();
          notifyListeners();
        },
      );
      notifyListeners();
    } catch (e) {
      debugPrint("Error initializing speech: $e");
    }
  }

  Future<void> startListening(String localeId) async {
    if (!_isSpeechEnabled) {
      await initSpeech();
    }

    if (_isSpeechEnabled) {
      _isListening = true;
      _lastWords = '';
      _startWaveAnimation();
      notifyListeners();

      await _speechToText.listen(
        onResult: (result) {
          _lastWords = result.recognizedWords;
          notifyListeners();
        },
        localeId: localeId,
        listenFor: const Duration(seconds: 45),
        listenOptions: SpeechListenOptions(
          cancelOnError: true,
          listenMode: ListenMode.confirmation,
        ),
      );
    }
  }

  Future<void> stopListening() async {
    _isListening = false;
    _stopWaveAnimation();
    await _speechToText.stop();
    notifyListeners();
  }

  void toggleListening(BuildContext context, String localeId) {
    if (_isListening) {
      stopListening();
      processVoiceInput(context);
    } else {
      startListening(localeId);
    }
  }

  Future<void> processVoiceInput(BuildContext context) async {
    if (_lastWords.isEmpty) return;
    final l10n = AppLocalizations.of(context)!;

    try {
      _isProcessing = true;
      notifyListeners();

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
      if (context.mounted) {
        debugPrint("Error processing voice input: $e");
        _showErrorDialog(context, l10n);
      }
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }

  void _showErrorDialog(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(l10n.error),
        content: Text(l10n.voice_input_error),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.close),
            onPressed: () => Navigator.pop(ctx),
          ),
        ],
      ),
    );
  }

  void _startWaveAnimation() {
    _waveTimer?.cancel();
    _waveTimer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      for (int i = 0; i < heights.length; i++) {
        heights[i] = 20.0 + _random.nextInt(50).toDouble();
      }
      notifyListeners();
    });
  }

  void _stopWaveAnimation() {
    _waveTimer?.cancel();
    heights = List.filled(7, 20.0);
    notifyListeners();
  }

  @override
  void dispose() {
    _waveTimer?.cancel();
    _speechToText.cancel();
    super.dispose();
  }
}
