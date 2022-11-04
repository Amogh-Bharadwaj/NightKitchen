import 'package:flutter/material.dart';
import 'package:night_kitchen/common/error_alert.dart';
import 'package:night_kitchen/common/spinner.dart';
import 'package:night_kitchen/common/auth_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  bool loading = false;
  String gender = "Male";

  String authError(err) {
    if (err == "weak-password") {
      return "Your password is too weak!";
    } else if (err == "email-already-in-use") {
      return "This email address is taken.";
    } else if (err == "invalid-email") {
      return "Invalid email address";
    }
    return "An error occurred. Please fill all credentials.";
  }

  String infoError(err) {
    if (err == "name-unreal") {
      return "Please enter a more realistic name.";
    }
    if (err == "age-unreal") {
      return "Please enter a realistic age.";
    }
    if (err == "gender-empty") {
      return "Please select a gender.";
    }
    return "An error occurred. Please re-enter the information.";
  }

  void toggleSpin(spin) {
    setState(() {
      loading = spin;
    });
  }

  void toggleGender(sex) {
    setState(() {
      gender = sex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 28, 37, 53),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Column(children: <Widget>[
              SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          child: SizedBox(
                              width: double.infinity,
                              child: Text('Register',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Color.fromARGB(255, 105, 160, 255),
                                  )))),
                      const Text("WHO'S COOKING?",
                          style: TextStyle(
                              color: Color.fromARGB(233, 159, 210, 246),
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      AuthParam("Name", double.infinity, nameController),
                      AuthParam(
                          "Email address", double.infinity, emailController),
                      AuthParam(
                          "Password", double.infinity, passwordController),
                      const Text(
                          "Your password is protected and invisible to us.",
                          style:
                              TextStyle(fontSize: 13, color: Colors.white24)),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                AuthParam(
                                    "Age",
                                    0.45 * MediaQuery.of(context).size.width,
                                    ageController),
                                SizedBox(
                                    width: 0.45 *
                                        MediaQuery.of(context).size.width,
                                    child: DropdownButtonFormField(
                                        dropdownColor:
                                            const Color.fromRGBO(10, 20, 41, 1),
                                        value: gender,
                                        decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromRGBO(10, 20, 41, 1)),
                                        items: ["Male", "Female"]
                                            .map((option) => DropdownMenuItem(
                                                value: option,
                                                child: Text(option,
                                                    style: const TextStyle(
                                                        color:
                                                            Colors.white38))))
                                            .toList(),
                                        onChanged: (value) =>
                                            toggleGender(value)))
                              ])),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            30,
                            0,
                            0,
                          ),
                          child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(10),
                                      shadowColor: MaterialStateProperty.all(
                                          Colors.greenAccent),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.fromLTRB(
                                              20, 10, 20, 10)),
                                      textStyle: MaterialStateProperty.all(
                                          const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Kanit')),
                                      backgroundColor: MaterialStateProperty.all(
                                          const Color.fromARGB(
                                              255, 44, 146, 54))),
                                  onPressed: () async {
                                    toggleSpin(true);
                                    final nav = Navigator.of(context);
                                    String email = emailController.text.trim();
                                    String password =
                                        passwordController.text.trim();
                                    try {
                                      String name = nameController.text.trim();

                                      if (name.length < 2 || name.length > 60) {
                                        throw const FormatException(
                                            "name-unreal");
                                      }

                                      int? age = int.tryParse(
                                          ageController.text.trim());
                                      if (age == null || age < 3 || age > 130) {
                                        throw const FormatException(
                                            "age-unreal");
                                      }

                                      String userGender = gender.trim();
                                      if (userGender.length < 3) {
                                        throw const FormatException(
                                            "gender-empty");
                                      }

                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                        email: email,
                                        password: password,
                                      );
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(email)
                                          .set({
                                        'Name': name,
                                        'Age': age,
                                        'Gender': userGender,
                                        'Email': email
                                      });
                                      nav.pushNamedAndRemoveUntil("/kitchen", (route) => false);
                                    } on FirebaseAuthException catch (err) {
                                      errorAlert(context, authError(err.code));
                                    } on FormatException catch (err) {
                                      errorAlert(
                                          context, infoError(err.message));
                                    } on FirebaseException catch (err) {
                                      errorAlert(context, err.code);
                                    }
                                    toggleSpin(false);
                                  },
                                  child: loading
                                      ? spinner(loading)
                                      : const Text("Enter")))),
                    ],
                  )),
            ])));
  }
}
