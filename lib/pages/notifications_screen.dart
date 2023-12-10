import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool airRaidAlert = false;
  bool curfewReminder = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Уведомления'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('Уведомление о воздушной тревоге'),
            value: airRaidAlert,
            onChanged: (bool value) {
              setState(() {
                airRaidAlert = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Напоминание о комендантском времени'),
            value: curfewReminder,
            onChanged: (bool value) {
              setState(() {
                curfewReminder = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
