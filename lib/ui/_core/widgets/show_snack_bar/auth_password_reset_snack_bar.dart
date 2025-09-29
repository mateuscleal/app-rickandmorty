import 'package:flutter/material.dart';

void authPasswordResetSnackBar (BuildContext context, bool success) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: success ? Colors.green : Colors.red,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(success ? 'Reset link sent successfully!' : 'Invalid email'),
      ),
      duration: Duration(seconds: 2),
    ),
  );
}
