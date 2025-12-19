import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/services/notification_service.dart';

class NotificationViewmodel extends ChangeNotifier {
  bool _isNotificationsEnabled = false;

  bool get isNotificationsEnabled => _isNotificationsEnabled;

  Future<void> loadNotificationState() async {
    final savedState = await LocalStorageService().getNotificationStatus();
    _isNotificationsEnabled = savedState;
    notifyListeners();
  }

  Future<void> toggleNotification(bool value) async {
    final service = NotificationService();

    _isNotificationsEnabled = value;
    notifyListeners();

    await LocalStorageService().saveNotificationStatus(value);

    if (value) {
      final granted = await service.requestPermissions();
      if (granted) {
        await service.scheduleDailyNotification();
      } else {
        _isNotificationsEnabled = false;
        notifyListeners();
        await LocalStorageService().saveNotificationStatus(false);
      }
    } else {
      await service.cancelNotifications();
    }
  }
}
