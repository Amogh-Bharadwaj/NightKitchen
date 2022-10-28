import 'package:flutter/material.dart';
import "features/auth/login.dart";
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
      home: const LoginScreen(),
      theme: ThemeData(backgroundColor: const Color.fromARGB(255, 0, 0, 0))));
}
