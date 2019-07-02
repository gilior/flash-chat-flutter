import 'package:flash_chat/conponents/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool show_spinner = false;
  String email;

  String pwd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = 'a@a.com';
    pwd = '1q2w3e';
  }

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
                keyboardType: TextInputType.emailAddress,
//              style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
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
              RoundedButton('Register', Colors.blueAccent, () async {
                try {
                  setState(() {
                    show_spinner = true;
                  });
                  final FirebaseUser user =
                      await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: pwd,
                  );
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
