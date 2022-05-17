import 'dart:async';
import 'dart:convert';
import 'package:folio/screens/introduction/introduction.dart';
import 'package:folio/screens/main/main.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalStorage myStorage = LocalStorage('fintech');

  @override
  void initState() {
    super.initState();
    loginCheck();
  }

  Future<void> loginCheck() async {
    await myStorage.ready;
    await myStorage.clear();

    final _email = await myStorage.getItem('Email');
    final _password = await myStorage.getItem('Password');

    const baseURL = 'http://127.0.0.1:8000/api';
    final url = Uri.parse('$baseURL/login/');

    Response response = await post(url, body: {
      'email': _email.toString(),
      'password': _password.toString(),
    });

    final responseJson = jsonDecode(response.body);
    final responseMessage = responseJson['message'];

    if (responseMessage == "Login Successful") {
      await myStorage.setItem("FirstName", responseJson['firstname']);
      await myStorage.setItem("LastName", responseJson['lastname']);
      await myStorage.setItem("Email", _email);
      await myStorage.setItem("Password", _password);
      await myStorage.setItem("CurrentValue", responseJson['portfoliovalue']);
      await myStorage.setItem("InvestedValue", responseJson['investedvalue']);
      await myStorage.setItem("Portfolio", responseJson['portfolio']);
      await myStorage.setItem("Change", responseJson['change']);
      await myStorage.setItem("MediumTerm", responseJson['medium']);
      await myStorage.setItem("LongTerm", responseJson['long']);
      await Future.delayed(const Duration(seconds: 5)).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              duration: const Duration(milliseconds: 500),
              type: PageTransitionType.rightToLeft,
              child: const MainScreen(),
            ),
            (route) => false);
      });
    } else {
      await Future.delayed(const Duration(seconds: 5)).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              duration: const Duration(milliseconds: 500),
              type: PageTransitionType.rightToLeft,
              child: const IntroductionScreen(),
            ),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 150,
          ),
        ],
      )),
    );
  }
}
