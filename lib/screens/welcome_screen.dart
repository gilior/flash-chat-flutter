import 'package:flash_chat/conponents/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'WelcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
      ),
//      upperBound: 100.0,
    );

    //Curves.decelerate animation
    //-----------------------------------------
//    animation =        CurvedAnimation(parent: animationController, curve: Curves.decelerate);

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(animationController);

    // animation- start to end or end to start
    //---------------------------------------------
//    animationController.reverse(from: 1.0);
    animationController.forward();

    // infinte animation
    //------------------------
//    animation.addStatusListener((status) {
//      print(status);
//      if (status == AnimationStatus.completed) {
//        animationController.reverse(from: 1.0);
//      } else if (status == AnimationStatus.dismissed) {
//        animationController.forward();
//      }
//    });
    animationController.addListener(() {
      setState(() {});
//      print(animation.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
//      backgroundColor: Colors.red.withOpacity(animationController.value),   // animate color
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
//                    height: animation.value * 100,  animate height
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            RoundedButton('Register', Colors.blueAccent, () {
              Navigator.pushNamed(context, RegistrationScreen.id);
            }),
          ],
        ),
      ),
    );
  }
}
