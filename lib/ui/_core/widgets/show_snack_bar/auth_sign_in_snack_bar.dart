import 'package:flutter/material.dart';

void authSignInSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text('Incorrect email or password'),
      ),
      duration: Duration(seconds: 2),
    ),
  );
}
