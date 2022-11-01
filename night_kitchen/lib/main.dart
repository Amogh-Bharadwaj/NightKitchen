import 'package:flutter/material.dart';
import "features/auth/login.dart";
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  runApp(MaterialApp(
      theme: ThemeData(
        fontFamily: 'Kanit',
        scaffoldBackgroundColor: const Color.fromARGB(255, 28, 37, 53),
      ),
      home: LoginScreen()));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
