import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService() {
    init();
  }

  void init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleCurfewNotification() async {
    var scheduledTime = _nextInstanceOfTenPM();
    var androidDetails = AndroidNotificationDetails(
      'curfew_channel_id',
      'Комендантский час',
      channelDescription: 'Уведомление о начале комендантского часа',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Комендантский час',
      'Комендантский час начался. Пожалуйста, оставайтесь дома.',
      scheduledTime,
      platformDetails,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  void showInstantCurfewNotification() async {
    var androidDetails = AndroidNotificationDetails(
      'instant_curfew_channel_id',
      'Моментальное уведомление о комендантском часе',
      channelDescription: 'Моментальное уведомление о начале комендантского часа',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Комендантский час',
      'Комендантский час начался. Пожалуйста, оставайтесь дома.',
      platformDetails,
    );
  }

  tz.TZDateTime _nextInstanceOfTenPM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, 22);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}