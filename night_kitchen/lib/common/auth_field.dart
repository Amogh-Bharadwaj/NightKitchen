import 'package:flutter/material.dart';

class AuthParam extends StatelessWidget {
  final String field;
  final double length;
  final TextEditingController paramController;
  const AuthParam(this.field, this.length, this.paramController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: SizedBox(
            width: length,
            child: TextField(
                obscureText: field == "Password" ? true : false,
                controller: paramController,
                style: const TextStyle(
                    fontFamily: "Kanit", height: 1.0, color: Colors.white),
                decoration: InputDecoration(
                    hintText: field,
                    hintStyle: const TextStyle(
                        color: Colors.white38, fontFamily: 'Kanit'),
                    fillColor: const Color.fromRGBO(10, 20, 41, 1),
                    filled: true,
                    enabledBorder: const UnderlineInputBorder()))));
  }
}
