import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_screen.dart';
import 'done.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  int? _resendToken; // Добавленная переменная для хранения resendToken

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Авторизація")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Будь ласка, введіть номер мобільного телефону",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Номер телефону',
                prefixText: '+380 ',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: Text('Далі'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Войти без авторизации'),
              onPressed: () {
                // Переход на экран done.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Done()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyPhoneNumber() async {
    setState(() {
      _isLoading = true;
    });
    final phoneNumber = '+380${_phoneNumberController.text.trim()}';
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        await _setLoggedInFlag();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Done()),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _isLoading = false;
        });
        _showErrorDialog(e.message);
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          _isLoading = false;
          _resendToken = resendToken; // Обновление resendToken
        });
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OTPScreen(verificationId: verificationId)),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _isLoading = false;
        });
      },
      timeout: Duration(seconds: 60),
      forceResendingToken: _resendToken, // Использование _resendToken
    );
  }

  Future<void> _setLoggedInFlag() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
  }

  void _showErrorDialog(String? message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Помилка'),
        content: Text(message ?? 'Сталася невідома помилка'),
        actions: <Widget>[
          TextButton(
            child: Text('ОК'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
