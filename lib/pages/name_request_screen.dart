import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'done.dart';

class NameRequestScreen extends StatefulWidget {
  const NameRequestScreen({super.key});

  @override
  _NameRequestScreenState createState() => _NameRequestScreenState();
}

class _NameRequestScreenState extends State<NameRequestScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Введите ваше имя'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Имя'),
            ),
            ElevatedButton(
              onPressed: _saveName,
              child: Text('Сохранить и продолжить'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _nameController.text);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Done()));
  }
}
