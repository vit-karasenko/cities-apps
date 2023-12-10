import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/Login.dart';
import 'pages/done.dart';
import 'pages/notification_service.dart'; // Убедитесь, что путь к файлу верный

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final NotificationService _notificationService = NotificationService();
  _notificationService.init(); // Инициализация сервиса уведомлений
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthChecker(),
    );
  }
}

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  _AuthCheckerState createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (FirebaseAuth.instance.currentUser != null && isLoggedIn) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Done()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}