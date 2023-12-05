import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'done.dart';
import 'name_request_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  const OTPScreen({super.key, required this.verificationId});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Код авторизації")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: 'КОД',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _signInWithOTP,
              child: Text('Увійти'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithOTP() async {
    try {
      final authCredential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpController.text.trim(),
      );
      await _auth.signInWithCredential(authCredential);
      await _checkAndNavigate();
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  Future<void> _checkAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName');
    if (userName == null || userName.isEmpty) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NameRequestScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Done()));
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ошибка'),
        content: Text(message),
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