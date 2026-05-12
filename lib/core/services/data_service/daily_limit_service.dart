import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_flow/main.dart';

class DailyLimitService {
  static const String _keyLastDate = 'last_usage_date';
  static const String _keyVoiceCount = 'voice_usage_count';

  final _premiumViewModel = premiumViewModel;

  Future<void> _checkAndResetDailyCounts() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDate = prefs.getString(_keyLastDate);
    final today = DateTime.now().toIso8601String().split('T')[0];

    if (lastDate != today) {
      await prefs.setString(_keyLastDate, today);
      await prefs.setInt(_keyVoiceCount, 0); 
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

  Future<void> grantAdReward({bool resetCompletely = false}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyVoiceCount, 0);
  }
}
