import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/model/budget_model.dart';
import 'package:spend_flow/core/services/ai_service.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/language_service.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/features/budget/add_budget/add_budget_view.dart';
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
          debugPrint('Speech Status: $status');
          if (status == 'done' || status == 'notListening') {
            _isListening = false;
            _stopWaveAnimation();
            notifyListeners();
          }
        },
        onError: (errorNotification) {
          debugPrint('Speech Error: $errorNotification');
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

      final aiResult = await _aiService.analyzeText(_lastWords, categories, currentLanguage);

      if (aiResult['actionType'] == null ||
          aiResult['data'] == null) {
        throw Exception(
          l10n.error_ai_request,
        );
      }

      final currentWalletId = await _localStorageService.getCurrentWalletId();

      final actionType = aiResult['actionType']?.toString();
      final data = Map<String, dynamic>.from(aiResult['data']);

      if (!context.mounted) return;

      if (actionType == "TRANSACTION") {
        final transaction = TransactionModel.fromAIResponse(
          aiData: data,
          availableCategories: categories,
          currentWalletId: currentWalletId,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AddTransactionPage(transactionData: transaction),
          ),
        );
      } else if (actionType == "BUDGET") {
        final budgetData = BudgetModel.fromAIResponse(
          aiData: data,
          availableCategories: categories,
          currentWalletId: currentWalletId,
        );
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AddBudgetView(
              budgetToEdit: budgetData,
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: Text(AppLocalizations.of(context)!.error),
            content: Text("${l10n.voice_input_error}: $e"),
            actions: [
              CupertinoDialogAction(
                child: Text(AppLocalizations.of(context)!.close),
                onPressed: () => Navigator.pop(ctx),
              ),
            ],
          ),
        );
      }
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
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
