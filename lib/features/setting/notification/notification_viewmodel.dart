import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:spend_flow/core/services/notification_service.dart';

class NotificationViewModel extends ChangeNotifier {
  static final NotificationViewModel _instance =
      NotificationViewModel._internal();
  factory NotificationViewModel() => _instance;
  NotificationViewModel._internal();

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
    final status = await _notificationService.requestPermissions();
    if (status == false) {
      await _storage.saveNotificationStatus(false);
      _isNotificationsEnabled = false;
      notifyListeners();
      return;
    }
    await _storage.saveNotificationStatus(status);
    _isNotificationsEnabled = status;
    notifyListeners();
  }

  Future<void> toggleNotification(bool value, BuildContext context) async {
    if (value) {
      final granted = await _notificationService.requestPermissions();
      if (!granted && context.mounted) {
        _showOpenNotificationSettingsDialog(context);
        notifyListeners();
      }
      return;
    }

    await _storage.saveNotificationStatus(value);
    _isNotificationsEnabled = value;
    if (value) {
      if (context.mounted) {
        await _notificationService.scheduleDailyNotification(context);
      }
    } else {
      await _notificationService.cancelNotifications();
    }
    await _storage.saveNotificationStatus(value);
    _isNotificationsEnabled = value;
    notifyListeners();
  }

  void _showOpenNotificationSettingsDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(l10n.notification_permission_denied),
        content: Text(l10n.notification_permission_denied_description),
        actions: [
          CupertinoDialogAction(
            child: Text(l10n.cancel),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text(l10n.settings),
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
          ),
        ],
      ),
    );
  }
}
