import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              24.0, 0, 24.0, MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email')),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password',
                    )),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  onPress: () async {
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  color: Colors.blueAccent,
                  title: 'Register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
