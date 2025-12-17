import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceInputViewModel extends ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();

  bool _isListening = false;
  bool _isSpeechEnabled = false;
  String _lastWords = '';

  List<double> heights = List.filled(7, 20.0);
  Timer? _waveTimer;
  final Random _random = Random();

  bool get isListening => _isListening;
  String get lastWords => _lastWords;
  bool get isSpeechEnabled => _isSpeechEnabled;

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

  void toggleListening(String localeId) {
    if (_isListening) {
      stopListening();
    } else {
      startListening(localeId);
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

  void confirmInput(BuildContext context) {
    stopListening();
    if (_lastWords.isNotEmpty) {
      Navigator.pop(context, _lastWords);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _waveTimer?.cancel();
    _speechToText.cancel();
    super.dispose();
  }
}
