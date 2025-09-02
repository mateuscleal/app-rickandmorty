import 'package:app/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../_core/theme/app_colors.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.textTertiary,
        title: Text('Verifique seu e-mail'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
      ),
      body: Center(
        child: Column(
          spacing: 25,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/json/email_animation_rm.json', width: 200, height: 200),
            Text(
              'Verifique seu e-mail para continuar',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            false
                ? CircularProgressIndicator(color: Colors.black, strokeWidth: 3)
                : ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(AppRoutes.mainScaffold);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    ),
                    child: Text("Continuar"),
                  ),
          ],
        ),
      ),
    );
  }
}
