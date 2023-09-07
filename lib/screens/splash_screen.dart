import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_chat/api/apis.dart';

import 'home_screen.dart';
import 'auth/login_screen.dart';

late Size mediaQuery;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //changing navigation bar back to normal
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      //Changing navigation bar color back to normal
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      if (APIs.auth.currentUser != null) {
        //if user is not null or is loged in, the user will directly go to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        //else he or she will signin for entering
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
      //Changing the screens to home screen
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Welcome to We Chat'),
        // ),
        body: Stack(
      children: [
        // Animation with Position
        Positioned(
            top: mediaQuery.height * 0.18,
            // if isAnimate is true, then it will move from extreme right to middle
            right: mediaQuery.width * 0.25,
            width: mediaQuery.width * 0.5,
            child: Image.asset('images/comment.png')),
        Positioned(
            top: mediaQuery.height * 0.8,
            left: mediaQuery.width * 0.02,
            width: mediaQuery.width,
            height: mediaQuery.height * 0.07,
            child: const Text('Made with love in India',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 19, color: Colors.black87, letterSpacing: .5))),
      ],
    ));
  }
}
