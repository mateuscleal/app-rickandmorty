import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:app/ui/authentication/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../../routing/app_routes.dart';
import '../../_core/widgets/show_dialogs/show_dialog_password_reset.dart';
import '../../_core/widgets/show_snack_bar/auth_sign_in_snack_bar.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.authViewModel});

  final AuthViewModel authViewModel;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  /// Variables
  final _formKey = GlobalKey<FormState>();
  final _focusNodes = List.generate(2, (index) => FocusNode());
  final _obscureText = List.generate(2, (index) => ValueNotifier<bool>(true));

  /// Controllers
  final _textController = List.generate(2, (index) => TextEditingController());
  final _buttonController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textTertiary),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: TextFormField(
                focusNode: _focusNodes[0],
                controller: _textController[0],
                textInputAction: TextInputAction.next,
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Email",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(left: 12),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                ),
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_focusNodes[1]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 60,
              child: ValueListenableBuilder(
                valueListenable: _obscureText[0],
                builder: (context, value, child) {
                  return TextFormField(
                    obscureText: value,
                    focusNode: _focusNodes[1],
                    controller: _textController[1],
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () => _obscureText[0].value = !value,
                        child: Icon(
                          !value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _buttonController.start();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, bottom: 10),
              child: GestureDetector(
                onTap: () => showAlertDialogPasswordReset(
                  context: context,
                  formKey: GlobalKey<FormState>(),
                  emailController: TextEditingController(),
                  authViewModel: widget.authViewModel,
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "I forgot my password",
                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textTertiary, fontSize: 14),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: RoundedLoadingButton(
                color: AppColors.background,
                controller: _buttonController,
                resetAfterDuration: true,
                resetDuration: Duration(seconds: 2),
                completionDuration: Duration(milliseconds: 500),
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  if (_formKey.currentState!.validate()) {
                    final userModel = await widget.authViewModel.signIn(
                      _textController[0].text,
                      _textController[1].text,
                    );
                    if (userModel != null && userModel.emailVerified) {
                      _buttonController.success();
                      navigator.pushNamedAndRemoveUntil(AppRoutes.mainScaffold, (route) => false);
                    } else if (userModel != null && !userModel.emailVerified) {
                      _buttonController.success();
                      await navigator.pushNamed(AppRoutes.verifyEmail);
                      _buttonController.reset();
                    } else {
                      _buttonController.error();
                      if (context.mounted) {
                        authSignInSnackBar(context);
                      }
                    }
                  } else {
                    _buttonController.error();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text("Sign In", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
            Divider(color: Colors.grey),
            Center(
              child: TextButton(
                onPressed: () {
                  widget.authViewModel.toggleAuthMode();
                  _formKey.currentState?.reset();
                  _textController[0].clear();
                  _textController[1].clear();
                },
                child: Text.rich(
                  TextSpan(
                    text: "Don't have a login? ",
                    style: TextStyle(color: AppColors.textTertiary, fontSize: 14, fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(
                        text: "Create here",
                        style: TextStyle(color: AppColors.textTertiary, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
