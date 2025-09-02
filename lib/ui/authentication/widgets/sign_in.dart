import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:app/ui/authentication/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';

import '../../../routing/app_routes.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.authViewModel});

  final AuthViewModel authViewModel;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textController = List.generate(2, (index) => TextEditingController());

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
                autofocus: true,
                controller: textController[0],
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Email",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(left: 12),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                ),
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
              child: TextFormField(
                autofocus: true,
                obscureText: true,
                controller: textController[1],
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(left: 12),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10, bottom: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "I forgot my password",
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textTertiary, fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final focus = FocusScope.of(context);
                  final navigator = Navigator.of(context);
                  final snackBar = ScaffoldMessenger.of(context);
                  focus.unfocus();
                  if (_formKey.currentState!.validate()) {
                    final userData = await widget.authViewModel.signIn(
                      textController[0].text,
                      textController[1].text,
                    );

                    debugPrint(userData.toString());

                    if (userData['user'] && userData['verified']) {
                      navigator.pushNamedAndRemoveUntil(AppRoutes.mainScaffold, (route) => false);
                      return;
                    } else if (userData['user'] && !userData['verified']) {
                      navigator.pushNamed(AppRoutes.verifyEmail);
                    } else {
                      snackBar.showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Invalid email or password'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
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
                  textController[0].clear();
                  textController[1].clear();
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
