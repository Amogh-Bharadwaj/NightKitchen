import 'package:flutter/material.dart';
import "../recipes/kitchen.dart";
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class LoginParam extends StatelessWidget {
  final String field;
  final TextEditingController paramController;
  const LoginParam(this.field, this.paramController, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        child: TextField(
            obscureText: field == "Password" ? true : false,
            controller: paramController,
            style: const TextStyle(
                fontFamily: "Kanit", height: 1.0, color: Colors.white),
            decoration: InputDecoration(
                hintText: field,
                hintStyle:
                    const TextStyle(color: Colors.white38, fontFamily: 'Kanit'),
                fillColor: const Color.fromRGBO(10, 20, 41, 1),
                filled: true,
                enabledBorder: const UnderlineInputBorder())));
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;
  Future<String> handleRegister(String email, String password) async {
    String go = "An error occurred!";
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      go = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        go = "Password is too weak!";
      } else if (e.code == 'email-already-in-use') {
        go = "Email address already in use!";
      }
    } catch (e) {}

    return go;
  }

  String authError(err) {
    if (err == "user-not-found") {
      return "No such email registered.";
    } else if (err == "wrong-password") {
      return "You have entered the wrong password.";
    } else if (err == "user-disabled") {
      return "This user has been disabled";
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
    Widget loadingCircle = loading
        ? const SizedBox(
            width: 60.0,
            height: 60.0,
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          )
        : Container();
    return Scaffold(
        appBar: AppBar(
            title: const Center(
                child: Text('Login',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 105, 160, 255),
                    ))),
            backgroundColor: const Color.fromARGB(255, 20, 22, 26)),
        body: Column(children: <Widget>[
          SizedBox(
              height: 300,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LoginParam("Email address", emailController),
                  LoginParam("Password", passwordController),
                  ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(10),
                          shadowColor:
                              MaterialStateProperty.all(Colors.greenAccent),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 17, fontFamily: 'Kanit')),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 14, 173, 30))),
                      onPressed: () async {
                        toggleSpin(true);
                        final nav = Navigator.of(context);
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          nav.pushReplacement(MaterialPageRoute(
                              builder: (context) => const Kitchen()));
                        } on FirebaseAuthException catch (err) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            behavior: SnackBarBehavior.floating,
                            dismissDirection: DismissDirection.up,
                            elevation: 10,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height - 100,
                                right: 20,
                                left: 20),
                            backgroundColor: Colors.red,
                            content: Text(authError(err.code)),
                          ));
                        }
                        toggleSpin(false);
                      },
                      child: const Text("Enter")),
                ],
              )),
          loadingCircle
        ]));
  }
}
