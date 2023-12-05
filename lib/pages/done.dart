import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sidebar.dart'; // Импортируйте sidebar.dart
import 'package:sidebarx/sidebarx.dart';

class Done extends StatefulWidget {
  const Done({super.key});

  @override
  _DoneState createState() => _DoneState();
}

class _DoneState extends State<Done> {
  final SidebarXController _sidebarXController = SidebarXController(selectedIndex: 0);
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Гость';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Привет, $_userName'),
      ),
      drawer: Drawer(
        child: ExampleSidebarX(controller: _sidebarXController),
      ),
      body: Center(
        child: Text('Основной контент экрана Done'),
      ),
    );
  }
}