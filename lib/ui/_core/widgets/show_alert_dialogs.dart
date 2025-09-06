import 'package:app/ui/_core/widgets/show_snack_bars.dart';
import 'package:flutter/material.dart';

import '../../authentication/view_model/auth_view_model.dart';

ShowSnackBars showSnackBars = ShowSnackBars();

class ShowAlertDialogs {

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
          title: const Text("Esqueci minha senha"),
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
                  return "Informe um e-mail";
                }
                if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                  return "E-mail inválido";
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
                      child: const Text("Cancelar", style: TextStyle(fontSize: 16)),
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
                          final result = await authViewModel.checkIfEmailExists(email);
                          if (result) {
                            await authViewModel.sendPasswordResetEmail(email);
                            // ignore: use_build_context_synchronously
                            showSnackBars.authenticationPasswordReset(context, true);
                          } else {
                            // ignore: use_build_context_synchronously
                            showSnackBars.authenticationPasswordReset(context, false);
                          }
                          navigator.pop();
                        }
                      },
                      child: const Text("Enviar", style: TextStyle(fontSize: 16)),
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
}