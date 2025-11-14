import 'package:flutter/material.dart';

import '../../../../domain/models/password_reset_result.dart';
import '../../../authentication/view_model/auth_view_model.dart';
import '../show_snack_bar/auth_password_reset_snack_bar.dart';

void showAlertDialogPasswordReset({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController emailController,
  required AuthViewModel authViewModel,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        title: const Text("I forgot my password"),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: emailController,
            style: TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              labelText: "Email",
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 12),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
              if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                return "Enter a valid email";
              }
              return null;
            },
          ),
        ),
        actionsPadding: EdgeInsets.only(top: 10),
        actions: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 100,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("Cancel", style: TextStyle(fontSize: 16)),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: RotatedBox(quarterTurns: 1, child: Divider(color: Colors.grey, height: 20)),
                ),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    onPressed: () async {
                      final focusScope = FocusScope.of(context);
                      focusScope.unfocus();
                      if (formKey.currentState!.validate()) {
                        final email = emailController.text.trim();
                        final navigator = Navigator.of(context);
                        final result = await authViewModel.sendPasswordResetEmail(email);
                        if (result == PasswordResetResult.success) {
                          if (context.mounted) {
                            authPasswordResetSnackBar(context, result);
                          }
                        } else {
                          if (context.mounted) {
                            authPasswordResetSnackBar(context, result);
                          }
                        }
                        navigator.pop();
                      }
                    },
                    child: const Text("Submit", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
