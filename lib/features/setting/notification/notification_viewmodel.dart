import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/data_service/local_storage_service.dart';
import 'package:spend_flow/core/services/general_service/notification_service.dart';

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

    AdaptiveAlertDialog.show(
      context: context,
      title: l10n.notification_permission_denied,
      message: l10n.notification_permission_denied_description,
      icon: 'bell.badge.fill',
      actions: [
        AlertAction(
          title: l10n.cancel,
          style: AlertActionStyle.cancel,
          onPressed: () => Navigator.pop(context),
        ),
        AlertAction(
          title: l10n.settings,
          style: AlertActionStyle.primary,
          onPressed: () async {
            await openAppSettings();
          },
        ),
      ],
    );
  }
}
