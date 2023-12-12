import 'package:flutter/material.dart';
import 'notifications_screen.dart';
import 'street_selection_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
              // Код для выхода из сессии
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
          ListTile(
            title: Text('Выбор улицы и дома'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StreetSelectionScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
