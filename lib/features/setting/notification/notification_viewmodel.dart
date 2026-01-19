import 'package:flutter/cupertino.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/services/notification_service.dart';

class NotificationViewModel extends ChangeNotifier {
  final LocalStorageService _storage = LocalStorageService();
  final NotificationService _notificationService = NotificationService();

  bool _isNotificationsEnabled = false;
  bool get isNotificationsEnabled => _isNotificationsEnabled;

  Future<void> init(BuildContext context) async {
    await loadNotificationState();
    if (_isNotificationsEnabled) {
      if (context.mounted) {
        await _notificationService.scheduleDailyNotification(context);
      }
    }
  }

  Future<void> loadNotificationState() async {
    _isNotificationsEnabled = await _storage.getNotificationStatus();
    notifyListeners();
  }

  Future<void> toggleNotification(bool value, BuildContext context) async {
    _isNotificationsEnabled = value;
    notifyListeners();

    if (value) {
      final granted = await _notificationService.requestPermissions();
      if (granted) {
        if (context.mounted) {
          await _notificationService.scheduleDailyNotification(context);
          await _storage.saveNotificationStatus(true);
        }
      } else {
        _isNotificationsEnabled = false;
        await _storage.saveNotificationStatus(false);
        notifyListeners();
      }
    } else {
      await _notificationService.cancelNotifications();
      await _storage.saveNotificationStatus(false);
    }
  }
}
