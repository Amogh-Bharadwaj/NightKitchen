import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 100,
        child: TextField(
          decoration: InputDecoration(
              fillColor: Colors.white54,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ));
  }
}
