import 'package:flutter/material.dart';
import 'notification_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool curfewReminder = false;
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Уведомления1'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('Напоминание о комендантском времени'),
            value: curfewReminder,
            onChanged: (bool value) {
              setState(() {
                curfewReminder = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () => _notificationService.showInstantCurfewNotification(),
              child: Text('Моментальное уведомление о комендантском часе'),
            ),
          ),
        ],
      ),
    );
  }
}
