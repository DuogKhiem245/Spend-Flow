import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/main.dart';

class DailyLimitService {
  static const String _keyLastDate = 'last_usage_date';
  static const String _keyVoiceCount = 'voice_usage_count';
  static const String _keyScanCount = 'scan_usage_count';

  final _premiumViewModel = premiumViewModel;

  Future<void> _checkAndResetDailyCounts() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDate = prefs.getString(_keyLastDate);
    final today = DateTime.now().toIso8601String().split('T')[0];

    if (lastDate != today) {
      await prefs.setString(_keyLastDate, today);
      await prefs.setInt(_keyVoiceCount, 0); 
      await prefs.setInt(_keyScanCount, 0);
    }
  }

  Future<bool> canUseVoice() async {
    if (_premiumViewModel.isPremium) return true;

    await _checkAndResetDailyCounts();
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt(_keyVoiceCount) ?? 0;

    if (currentCount < 5) {
      await prefs.setInt(_keyVoiceCount, currentCount + 1);
      return true;
    }
    return false; 
  }

  Future<bool> canUseScan() async {
    if (_premiumViewModel.isPremium) return true;

    await _checkAndResetDailyCounts();
    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt(_keyScanCount) ?? 0;

    if (currentCount < 1) {
      await prefs.setInt(_keyScanCount, currentCount + 1);
      return true;
    }
    return false;
  }

  Future<void> grantAdReward(bool isVoice, {bool resetCompletely = false}) async {
    final prefs = await SharedPreferences.getInstance();
    if (isVoice) {
      await prefs.setInt(_keyVoiceCount, 0);
    } else {
      await prefs.setInt(_keyScanCount, 0);
    }
  }

  Future<void> refundScanCount() async {
    if (_premiumViewModel.isPremium) return; 

    final prefs = await SharedPreferences.getInstance();
    final currentCount = prefs.getInt(_keyScanCount) ?? 0;

    // Nếu số lượt đang > 0 thì trừ đi 1 để hoàn lại
    if (currentCount > 0) {
      await prefs.setInt(_keyScanCount, currentCount - 1);
    }
  }
}
