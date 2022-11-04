import 'package:flutter/material.dart';

void errorAlert(BuildContext context, String errMsg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.up,
    elevation: 10,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100, right: 20, left: 20),
    backgroundColor: Colors.red,
    content: Text(errMsg),
  ));
}
