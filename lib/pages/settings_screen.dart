import 'package:flutter/material.dart';
import 'notifications_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Налаштування'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Вийти'),
            onTap: () {
              // Здесь должен быть код для выхода из сессии
            },
          ),
          ListTile(
            title: Text('Уведомления'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
