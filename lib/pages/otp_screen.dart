import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'done.dart';

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
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Done()));
    } catch (e) {
      print(e);
    }
  }
}
