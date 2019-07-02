import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/conponents/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email;

  String pwd;

  bool show_spinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: show_spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  pwd = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton('Log In', Colors.blueAccent, () async {
                try {
                  setState(() {
                    show_spinner = true;
                  });
                  final FirebaseUser user =
                      await _auth.signInWithEmailAndPassword(
                    email: 'a@a.com',
                    password: '1q2w3e',
                  );
                  setState(() {
                    show_spinner = false;
                  });
                  if (user != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } on Exception catch (e) {
                  // TODO
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
