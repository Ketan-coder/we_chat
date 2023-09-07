import 'dart:io';
// import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../api/apis.dart';
import '../../helper/dialouge.dart';
import '../home_screen.dart';

late Size mediaQuery;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  _handleGoogleBtnClick() {
    // Showing progress bar
    Dialouge.showProgressBar(context);

    _signInWithGoogle().then((user) {
      // Hide progress bar
      Navigator.pop(context);

      if (user != null){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    });
  }

//question mark indicates a function can return null
  Future<UserCredential?> _signInWithGoogle() async {
    try {
      //checking for the internet
      await InternetAddress.lookup('google.com');

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      // showing the message if there is no internet
      Dialouge.showSnackBar(context, 'Something went wrong(Check your Internet Connection)');
      return null;
    }
  }

  // sign out function
  _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to We Chat'),
        ),
        body: Stack(
          children: [
            // Animation with Position
            AnimatedPositioned(
                top: mediaQuery.height * 0.15,
                // if isAnimate is true, then it will move from extreme right to middle
                right: _isAnimate
                    ? mediaQuery.width * 0.25
                    : -mediaQuery.width * 0.5,
                width: mediaQuery.width * 0.5,
                duration: const Duration(milliseconds: 1000),
                child: Image.asset('images/comment.png')),
            Positioned(
                top: mediaQuery.height * 0.7,
                left: mediaQuery.width * 0.05,
                width: mediaQuery.width * 0.9,
                height: mediaQuery.height * 0.07,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade300,
                        shape: const StadiumBorder(),
                        elevation: 1),
                    onPressed: () {
                      _handleGoogleBtnClick();
                    },
                    icon: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Image.asset(
                          'images/google.png',
                          height: mediaQuery.height * 0.3,
                        )),
                    label: const Text(
                      'Sign in with Google',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ))),
          ],
        ));
  }
}
