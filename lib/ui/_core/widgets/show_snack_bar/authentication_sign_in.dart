import 'package:flutter/material.dart';

void authenticationSignIn (BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text('E-mail ou senha incorretos'),
      ),
      duration: Duration(seconds: 2),
    ),
  );
}
