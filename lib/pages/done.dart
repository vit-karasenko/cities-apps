import 'package:flutter/material.dart';

class NotificationItem {
  final String date;
  final String message;

  NotificationItem({required this.date, required this.message});
}

class Done extends StatefulWidget {
  const Done({super.key});

  @override
  _DoneState createState() => _DoneState();
}

class _DoneState extends State<Done> {
  List<NotificationItem> notifications = [
    // Обновите эти данные, чтобы они соответствовали вашим реальным уведомлениям
    NotificationItem(
      date: "Вчора", // "Yesterday" in Ukrainian
      message: "Маєте автівку? Додайте авто, щоб паркуватися без проблем і не боятися евакуаторів.",
    ),
    // Предполагается, что добавлены другие уведомления
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Done'),
        backgroundColor: Colors.red, // Измените цвет фона AppBar
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            color: Colors.white, // Установите цвет фона для Card
            elevation: 4.0, // Поднятие тени карты
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  notification.date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black, // Цвет текста
                  ),
                ),
              ),
              subtitle: Text(
                notification.message,
                style: TextStyle(fontSize: 16.0, color: Colors.grey), // Цвет текста подзаголовка
              ),
              trailing: Icon(Icons.more_vert, color: Colors.grey), // Иконка для действий с уведомлением
            ),
          );
        },
      ),
    );
  }
}
