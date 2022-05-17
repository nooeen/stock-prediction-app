import 'package:flutter/material.dart';
import 'package:folio/screens/main/main.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalStorage myStorage = LocalStorage('fintech');
  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    _login() async {
      await myStorage.ready;

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
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              duration: const Duration(milliseconds: 500),
              type: PageTransitionType.rightToLeft,
              child: const MainScreen(),
            ),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login Failed. Please Check Your Credentials."),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black,
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            alignment: Alignment.topCenter,
            child: ListView(
              children: [
                SizedBox(
                    height: 200.0,
                    width: 200.0,
                    child: Stack(
                      children: const [
                        Text('Let\'s',
                            style: TextStyle(
                              fontFamily: 'Trueno',
                              fontSize: 100.0,
                              fontWeight: FontWeight.w900,
                            )),
                        Positioned(
                            top: 80.0,
                            child: Text('Login',
                                style: TextStyle(
                                  fontFamily: 'Trueno',
                                  fontSize: 100.0,
                                  fontWeight: FontWeight.w900,
                                ))),
                      ],
                    )),
                const SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontFamily: 'Trueno',
                      ),
                      helperStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    autofillHints: const [AutofillHints.password],
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "Trueno",
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontFamily: "Trueno",
                      ),
                      helperStyle: TextStyle(color: Colors.black),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 120),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () {
                      _login();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
