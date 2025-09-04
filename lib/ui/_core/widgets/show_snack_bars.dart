import 'package:flutter/material.dart';

class ShowSnackBars {
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

  void authenticationPasswordReset (BuildContext context, bool success) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: success ? Colors.green : Colors.red,
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(success ? 'Link de redefinição enviado com sucesso!' : 'E-mail inválido'),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

}