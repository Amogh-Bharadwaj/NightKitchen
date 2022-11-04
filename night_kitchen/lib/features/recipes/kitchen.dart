import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:night_kitchen/common/text_gradient.dart';

class Kitchen extends StatelessWidget {
  const Kitchen({super.key});

  void logOut(BuildContext context) async {
    NavigatorState nav = Navigator.of(context);
    await FirebaseAuth.instance.signOut();
    nav.pushNamedAndRemoveUntil("/", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Widget userMenuItem(String label, void Function() handler) {
      return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () {
          handler();
        },
        child: Text(label,
            style: const TextStyle(
                color: Color.fromARGB(255, 172, 210, 248), fontSize: 15)),
      );
    }

    return Scaffold(
        endDrawer: Drawer(
          width: 150,
          backgroundColor: const Color.fromARGB(255, 18, 27, 39),
          child: ListView(children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Image.asset("lib/common/logo_short.png",
                    width: 60, height: 60)),
            userMenuItem("Log out", () {
              logOut(context);
            }),
          ]),
        ),
        appBar: AppBar(
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          title: const GradientText(
            "My Recipes",
            style: TextStyle(fontSize: 25),
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 43, 174, 255), Colors.white]),
          ),
          backgroundColor: const Color.fromARGB(255, 28, 37, 53),
        ));
  }
}
