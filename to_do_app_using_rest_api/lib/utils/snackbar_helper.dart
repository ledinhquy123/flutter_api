import 'package:flutter/material.dart';

void showMessage(BuildContext context, {required String message, required Color color}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold
      ),
    ),
    backgroundColor: color,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}