import 'package:flutter/material.dart';

class Kitchen extends StatelessWidget {
  const Kitchen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen',
            style: TextStyle(
              fontSize: 35,
              color: Colors.blueAccent,
            )),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
    );
  }
}
