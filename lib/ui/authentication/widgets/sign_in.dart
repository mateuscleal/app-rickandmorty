import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../routing/app_routes.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.isSignIn});

  final ValueNotifier<bool> isSignIn;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textTertiary),
            ),
            SizedBox(height: 20),

            // Email TextField
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: textController[0],
                decoration: InputDecoration(
                  labelText: "Email",
                  filled: true,
                  fillColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: TextFormField(
                obscureText: true,
                controller: textController[1],
                decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: Colors.white,
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
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text("I forgot my password", style: TextStyle(color: AppColors.textTertiary, fontSize: 14)),
              ),
            ),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.mainScaffold);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text("Sign In", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),

            SizedBox(height: 10),
            Divider(color: Colors.grey),

            // Sign Up Link
            Center(
              child: TextButton(
                onPressed: () {
                  widget.isSignIn.value = !widget.isSignIn.value;
                  _formKey.currentState?.reset();
                },
                child: Text.rich(
                  TextSpan(
                    text: "Don't have a login? ",
                    style: TextStyle(color: Color(0xFF082D50), fontSize: 14, fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(
                        text: "Create here",
                        style: TextStyle(color: Color(0xFF082D50), fontSize: 14, fontWeight: FontWeight.bold),
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
