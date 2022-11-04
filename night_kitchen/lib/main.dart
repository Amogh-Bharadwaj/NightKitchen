import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:night_kitchen/features/auth/login.dart';
import 'package:night_kitchen/features/auth/register.dart';
import "features/auth/gate.dart";
import "features/recipes/kitchen.dart";
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  User? user = FirebaseAuth.instance.currentUser;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Kanit',
        scaffoldBackgroundColor: const Color.fromARGB(255, 28, 37, 53),
      ),
      initialRoute: user == null ? '/' : '/kitchen',
      routes: {
        '/': (context) => const GateScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/kitchen': (context) => const Kitchen(),
      }));
}
