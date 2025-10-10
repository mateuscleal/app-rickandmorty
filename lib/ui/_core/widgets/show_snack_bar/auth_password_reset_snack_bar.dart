import 'package:flutter/material.dart';

import '../../../../domain/models/password_reset_result.dart';

void authPasswordResetSnackBar(BuildContext context, PasswordResetResult result) {
  ScaffoldMessenger.of(context).clearSnackBars();

  late final String message;
  late final Color backgroundColor, textColor;

  switch (result) {
    case PasswordResetResult.success:
      message = "If the email is registered,\nyou’ll receive a password reset link.";
      backgroundColor = Colors.white;
      textColor = Colors.green;
      break;
    case PasswordResetResult.networkError:
      message = "Network error.\nPlease check your connection and try again.";
      backgroundColor = Colors.orange;
      textColor = Colors.white;
      break;
    case PasswordResetResult.userNotFoundOrUnknown:
      message = "Unable to send password reset email.\nPlease try again later.";
      backgroundColor = Colors.red;
      textColor = Colors.white;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(message, textAlign: TextAlign.center, style: TextStyle(color: textColor, fontSize: 16)),
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
