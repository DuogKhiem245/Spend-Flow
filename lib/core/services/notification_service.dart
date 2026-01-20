import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:spend_flow/assets/l10n/app_localizations.dart';
import 'package:spend_flow/core/services/local_storage_service.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    String timeZoneName;
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      final String rawTimezone = timezoneInfo.identifier;

      timeZoneName = rawTimezone;
    } catch (e) {
      debugPrint(
        "Error getting local timezone: $e, using fallback America/New_York.",
      );
      timeZoneName = 'America/New_York';
    }

    try {
      final regex = RegExp(r'([A-Za-z]+/[A-Za-z_]+)');
      final match = regex.firstMatch(timeZoneName);

      if (match != null) {
        timeZoneName = match.group(0)!;
      }

      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      debugPrint(
        "Error setting timezone '$timeZoneName'. Using fallback Asia/Ho_Chi_Minh.",
      );

      try {
        tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
      } catch (_) {
        tz.setLocalLocation(tz.getLocation('UTC'));
      }
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<bool> requestPermissions() async {
    bool? isAndroidGranted = false;
    bool? isIOSGranted = false;

    final androidImplementation = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidImplementation != null) {
      isAndroidGranted = await androidImplementation
          .requestNotificationsPermission();
    }

    final iosImplementation = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    if (iosImplementation != null) {
      isIOSGranted = await iosImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    final storage = LocalStorageService();

    if (await storage.getNotificationStatus() == null) {
      await storage.saveNotificationStatus(
        (isAndroidGranted ?? false) || (isIOSGranted ?? false),
      );
    }

    return (isAndroidGranted ?? false) || (isIOSGranted ?? false);
  }

  Future<void> scheduleDailyNotification(BuildContext context) async {
    final storage = LocalStorageService();
    final bool? isEnabled = await storage.getNotificationStatus();

    if (isEnabled != true) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      l10n.reminder_title,
      l10n.reminder_body,
      _nextInstanceOf8PM(),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily Reminders',
          channelDescription: 'Daily reminders to log your expenses',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  tz.TZDateTime _nextInstanceOf8PM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      20,
      00,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
