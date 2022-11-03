import 'package:flutter/material.dart';
import 'package:night_kitchen/features/auth/login.dart';
import 'package:night_kitchen/features/auth/register.dart';

class GateScreen extends StatelessWidget {
  const GateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            heightFactor: 100,
            widthFactor: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("lib/common/logo.png",
                    height: 200, width: 300, scale: 1.5),
                const SizedBox(
                    width: 300,
                    child: Text(
                      "Accompanying you in your midnight trip to the fridge.",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 177, 222, 253)),
                    )),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: SizedBox(
                        width: 300,
                        child: Text(
                          "\"Hunger knows no friend but its feeder.\" \n ~ Aristophanes",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 114, 142, 159)),
                        ))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
                    child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(10),
                                shadowColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 45, 109, 192)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                        fontSize: 17, fontFamily: 'Kanit')),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 64, 101, 155))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()));
                            },
                            child: const Text("Register")))),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(10),
                                shadowColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 45, 192, 177)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                        fontSize: 17, fontFamily: 'Kanit')),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 34, 149, 126))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: const Text("Log in"))))
              ],
            )));
  }
}
