import 'dart:async';
import 'dart:math';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/ai_service.dart';
import 'package:spend_flow/core/data/category_data.dart';
import 'package:spend_flow/core/model/transaction_model.dart';
import 'package:spend_flow/core/services/general_service/language_service.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/model/budget_model.dart';
import 'package:spend_flow/screen/ai_preview/ai_preview_overview_view.dart';
import 'package:spend_flow/screen/budget/add_budget/add_budget_view.dart';
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

  BuildContext? _currentContext;
  bool _isFromWidget = false;

  Future<void> initSpeech({BuildContext? context, bool isFromWidget = false}) async {
    _currentContext = context;
    _isFromWidget = isFromWidget;
    try {
      _isSpeechEnabled = await _speechToText.initialize(
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            _isListening = false;
            _stopWaveAnimation();
            _safeNotifyListeners();

            if (_lastWords.trim().isNotEmpty &&
                _currentContext != null &&
                _currentContext!.mounted &&
                !_isProcessing) {
              if (_isFromWidget) {
                processWidgetVoiceInput(_currentContext!);
              } else {
                processVoiceInput(_currentContext!);
              }
            }
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
    final prefs = await SharedPreferences.getInstance();
    final bool hasRequestedBefore =
        prefs.getBool('voice_requested_before') ?? false;

    final micStatus = await Permission.microphone.status;
    final speechStatus = await Permission.speech.status;

    if (micStatus.isGranted && speechStatus.isGranted) {
      return true;
    }

    if (!hasRequestedBefore) {
      // Lần đầu tiên: Chỉ yêu cầu quyền hệ thống, nếu từ chối thì KHÔNG hiện popup ép buộc
      await prefs.setBool('voice_requested_before', true);
      final statuses = await [
        Permission.microphone,
        Permission.speech,
      ].request();

      final isMicGranted = statuses[Permission.microphone]?.isGranted ?? false;
      final isSpeechGranted = statuses[Permission.speech]?.isGranted ?? false;

      if (isMicGranted && isSpeechGranted) {
        return true;
      }
      // Người dùng từ chối ở popup hệ thống -> Dừng lại, không làm gì cả
      return false;
    } else {
      // Các lần sau khi vào lại: Nếu chưa được cấp quyền thì hiện popup hướng dẫn vào Settings
      if (context.mounted) {
        _showPermissionDialog(context);
      }
      return false;
    }
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

  Future<void> startListening(
    BuildContext context,
    String localeId, {
    bool isFromWidget = false,
  }) async {
    _currentContext = context;
    _isFromWidget = isFromWidget;

    final hasPermission = await _checkPermission(context);
    if (!hasPermission) return;

    if (!_isSpeechEnabled && context.mounted) {
      await initSpeech(context: context, isFromWidget: isFromWidget);
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
        listenOptions: SpeechListenOptions(
          cancelOnError: true,
          listenMode: ListenMode.confirmation,
          localeId: localeId,
        ),
      );
    }
  }

  void toggleListening(
    BuildContext context,
    String localeId, {
    bool isFromWidget = false,
  }) {
    _currentContext = context;
    _isFromWidget = isFromWidget;
    if (_isListening) {
      stopListening();
      if (isFromWidget) {
        processWidgetVoiceInput(context);
      } else {
        processVoiceInput(context);
      }
    } else {
      startListening(context, localeId, isFromWidget: isFromWidget);
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

  Future<void> processWidgetVoiceInput(BuildContext context) async {
    if (_lastWords.isEmpty) return;
    final l10n = AppLocalizations.of(context)!;

    try {
      _isProcessing = true;
      _safeNotifyListeners();

      final categories = CategoryData.getAll();
      final currentLanguage = LanguageService().locale.languageCode;
      final currentWalletId = await _localStorageService.getCurrentWalletId();

      final aiResult = await _aiService.analyzeWidgetVoiceText(
        _lastWords,
        categories,
        currentLanguage,
      );

      final List results = aiResult['results'] ?? [];

      if (results.isEmpty) {
        throw Exception(l10n.error_ai_request);
      }

      final List<TransactionModel> parsedTransactions = [];
      BudgetModel? parsedBudget;

      for (var item in results) {
        final String actionType = item['actionType']?.toString() ?? "";
        final data = Map<String, dynamic>.from(item['data'] ?? {});

        if (actionType == "BUDGET") {
          final categoryId = data['categoryId']?.toString();
          final category = categories.firstWhere(
            (c) => c.id == categoryId,
            orElse: () => categories.first,
          );
          final amount = (data['amount'] as num?)?.toDouble() ?? 0.0;
          final dateStr = data['date']?.toString();
          final date = dateStr != null
              ? (DateTime.tryParse(dateStr) ?? DateTime.now())
              : DateTime.now();
          final note = data['note']?.toString() ?? '';

          parsedBudget = BudgetModel(
            category: category,
            total: amount,
            date: date,
            walletId: currentWalletId,
            note: note,
          );
          break;
        } else if (actionType == "TRANSACTION") {
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

      if (parsedBudget != null) {
        final isSaved = await Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => AddBudgetView(
              budgetToEdit: parsedBudget,
              isFromAI: true,
            ),
          ),
        );
        if (context.mounted && isSaved == true) {
          Navigator.pop(context, true);
        }
        return;
      }

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
      debugPrint("Error processing widget voice input: $e");
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
