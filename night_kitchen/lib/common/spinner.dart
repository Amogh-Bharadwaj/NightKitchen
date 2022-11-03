import 'package:flutter/material.dart';

Widget spinner(bool loading) {
  return loading
      ? const Center(
          child: CircularProgressIndicator(
          color: Colors.white,
        ))
      : Container();
}
