import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:night_kitchen/common/auth_field.dart';
import 'package:night_kitchen/common/spinner.dart';
import 'package:night_kitchen/common/error_alert.dart';
import "package:night_kitchen/features/recipes/kitchen.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  String authError(err) {
    if (err == "user-not-found") {
      return "No such email registered.";
    } else if (err == "wrong-password") {
      return "You have entered the wrong password.";
    } else if (err == "user-disabled") {
      return "This user has been disabled";
    } else if (err == "invalid-email") {
      return "Enter a valid email address.";
    }
    return "An error occurred. Please fill all credentials.";
  }

  void toggleSpin(spin) {
    setState(() {
      loading = spin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 28, 37, 53),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 40),
            child: Column(children: <Widget>[
              SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text('Login',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 35,
                                  color: Color.fromARGB(255, 105, 160, 255),
                                )),
                          )),
                      const Text("WHO'S COOKING?",
                          style: TextStyle(
                              color: Color.fromARGB(233, 159, 210, 246),
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      AuthParam(
                          "Email address", double.infinity, emailController),
                      AuthParam(
                          "Password", double.infinity, passwordController),
                      const Text(
                          "Your password is protected and invisible to us.",
                          style:
                              TextStyle(fontSize: 13, color: Colors.white24)),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            30,
                            0,
                            30,
                          ),
                          child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(10),
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.greenAccent),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10)),
                                      textStyle: MaterialStateProperty.all(
                                          const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Kanit')),
                                      backgroundColor: MaterialStateProperty.all(
                                          const Color.fromARGB(
                                              255, 44, 146, 54))),
                                  onPressed: () async {
                                    toggleSpin(true);
                                    final nav = Navigator.of(context);
                                    String email = emailController.text.trim();
                                    String password =
                                        passwordController.text.trim();
                                    try {
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                        email: email,
                                        password: password,
                                      );
                                      nav.pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              const Kitchen()));
                                    } on FirebaseAuthException catch (err) {
                                      errorAlert(context, authError(err.code));
                                    }
                                    toggleSpin(false);
                                  },
                                  child: loading
                                      ? spinner(loading)
                                      : const Text("Enter")))),
                    ],
                  )),
            ])));
  }
}
