import 'package:app/routing/app_routes.dart';
import 'package:app/ui/authentication/widgets/step_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../_core/theme/app_colors.dart';
import '../view_model/auth_view_model.dart';

class EmailSentScreen extends StatefulWidget {
  const EmailSentScreen({super.key});

  @override
  State<EmailSentScreen> createState() => _EmailSentScreenState();
}

class _EmailSentScreenState extends State<EmailSentScreen> {
  final _buttonController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) => Scaffold(
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
              Lottie.asset(
                'assets/json/email_animation_rm.json',
                width: 200,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    StepItemWidget(
                      number: 1,
                      title: 'Cheque seu e-mail',
                      subtitle: 'Abra a caixa de entrada e procure o\ne-mail de verificação.',
                    ),
                    SizedBox(height: 12),
                    StepItemWidget(
                      number: 2,
                      title: 'Clique no link de verificação',
                      subtitle: 'O link confirma seu e-mail automaticamente.',
                    ),
                    SizedBox(height: 12),
                    StepItemWidget(
                      number: 3,
                      title: 'Volte aqui para continuar',
                      subtitle: 'Ao confirmar, toque em "Verificar agora" no app.',
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RoundedLoadingButton(
                  color: AppColors.background,
                  controller: _buttonController,
                  resetAfterDuration: true,
                  resetDuration: Duration(seconds: 1, milliseconds: 500),
                  onPressed: () async {
                    final snackBar = ScaffoldMessenger.of(context);
                    final navigator = Navigator.of(context);
                    await authViewModel.checkEmailVerified();
                    if (authViewModel.isVerified) {
                      navigator.pushNamedAndRemoveUntil(AppRoutes.mainScaffold, (routes) => false);
                      _buttonController.success();
                    } else {
                      _buttonController.error();
                      snackBar.clearSnackBars();
                      snackBar.showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('E-mail não verificado'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text("Verificar agora"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
