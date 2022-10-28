import 'package:flutter/material.dart';
import "../recipes/kitchen.dart";

class LoginParam extends StatefulWidget {
  final String field;
  const LoginParam(this.field, {super.key});
  @override
  State<StatefulWidget> createState() => _LoginParamState();
}

class _LoginParamState extends State<LoginParam> {
  String paramValue = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 100,
        child: Column(children: <Widget>[
          Text(widget.field,
              style: const TextStyle(fontSize: 20, color: Colors.white)),
          TextField(
            onChanged: ((value) => setState(() {
                  paramValue = value.toString();
                })),
            decoration: InputDecoration(
                fillColor: Colors.white54,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          )
        ]));
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login',
              style: TextStyle(
                fontSize: 35,
                color: Colors.blueAccent,
              )),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            const LoginParam("Username"),
            const LoginParam("Password"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Kitchen()));
                },
                child: const Text("Submit"))
          ],
        ));
  }
}
