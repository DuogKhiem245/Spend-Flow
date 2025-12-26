import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/ai_service.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/features/transaction/add_transaction/add_transaction_view.dart';

class VoiceInputViewModel extends ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();
  final AIService _aiService = AIService();

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

    try {
      _isProcessing = true;
      notifyListeners(); 

      final categories = CategoryData.getAll();

      final aiResult = await _aiService.analyzeText(_lastWords, categories);

      debugPrint("🔍 === KẾT QUẢ AI TRẢ VỀ ===");
      debugPrint("Raw Data: $aiResult");
      aiResult.forEach((key, value) {
        debugPrint(
          " 👉 Key: $key | Value: $value | Type: ${value?.runtimeType}",
        );
      });
      debugPrint("============================");

      if (!context.mounted) return;

      final transaction = TransactionModel.fromAIResponse(
        aiData: aiResult,
        availableCategories: categories,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AddTransactionPage(transactionData: transaction),
        ),
      );
    } catch (e) {
      debugPrint("Lỗi xử lý voice: $e");
      if (context.mounted) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: Text(AppLocalizations.of(context)!.error),
            content: Text("Không thể xử lý giọng nói: $e"),
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
