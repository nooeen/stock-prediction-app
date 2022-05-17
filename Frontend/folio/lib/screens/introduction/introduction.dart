import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:folio/screens/authentication/login.dart';
import 'package:folio/screens/authentication/register.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            Text('Welcome to',
                                style: TextStyle(
                                  fontFamily: 'Trueno',
                                  fontSize: 55.0,
                                  fontWeight: FontWeight.w900,
                                )),
                            Positioned(
                                top: 50.0,
                                child: Text('Folio',
                                    style: TextStyle(
                                      fontFamily: 'Trueno',
                                      fontSize: 100.0,
                                      fontWeight: FontWeight.w900,
                                    ))),
                          ],
                        )),
                    const SizedBox(height: 350),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                duration: const Duration(milliseconds: 500),
                                type: PageTransitionType.rightToLeft,
                                child: const RegisterScreen(),
                              ));
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
                                "Register",
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
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                              duration: const Duration(milliseconds: 500),
                              type: PageTransitionType.rightToLeft,
                              child: const LoginScreen(),
                            ));
                      },
                      child: const Center(
                          child: Text("Or login",
                              style: TextStyle(
                                  fontFamily: "Trueno", fontSize: 18))),
                    )
                  ],
                ))),
      ),
    );
  }
}
