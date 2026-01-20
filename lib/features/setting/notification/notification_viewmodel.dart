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
    final savedStatus = await _storage.getNotificationStatus();
    _isNotificationsEnabled = savedStatus!;
    notifyListeners();
  }

  Future<void> toggleNotification(bool value, BuildContext context) async {
    await _storage.saveNotificationStatus(value);
    _isNotificationsEnabled = value;
    if (value) {
      if (context.mounted) {
        await _notificationService.scheduleDailyNotification(context);
      }
    } else {
      await _notificationService.cancelNotifications();
    }
    notifyListeners();
  }
}
