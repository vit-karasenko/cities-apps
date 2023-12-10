import 'package:flutter/material.dart';
import 'notification_service.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool curfewReminder = false;
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
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
              // Здесь можно добавить логику включения/выключения уведомлений
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                _notificationService.showInstantNotification();
              },
              child: Text('Тестировать уведомление'),
            ),
          ),
        ],
      ),
    );
  }
}
