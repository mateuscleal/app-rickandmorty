import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../routing/app_routes.dart';
import '../../_core/theme/app_colors.dart';
import '../view_model/auth_view_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.authViewModel});


  final AuthViewModel authViewModel;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textController = List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  final focus = FocusScope.of(context);
                  widget.authViewModel.toggleAuthMode();
                  _formKey.currentState!.reset();
                  if (!focus.hasPrimaryFocus) {
                    focus.unfocus();
                  }
                  for (var element in textController) {
                    element.clear();
                  }
                },
                icon: Icon(Icons.close_outlined, color: AppColors.textTertiary),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text(
                  "Create your login",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textTertiary),
                ),
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: textController[0],
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "First Name",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: textController[1],
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                ),
                // Email TextField
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: textController[2],
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
                    controller: textController[3],
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Colors.black),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, TelefoneInputFormatter()],
                    decoration: InputDecoration(
                      labelText: "Cell phone",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your cell phone';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    obscureText: true,
                    controller: textController[4],
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
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'Password must contain at least one uppercase letter';
                      }
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Password must contain at least one number';
                      }
                      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Password must contain at least one special character';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    obscureText: true,
                    controller: textController[5],
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Confirm your password",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != textController[4].text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final focus = FocusScope.of(context);
                      final navigator = Navigator.of(context);
                      if (!focus.hasPrimaryFocus) {
                        focus.unfocus();
                      }
                      if (_formKey.currentState!.validate()) {
                        await widget.authViewModel.signUp(textController[2].text, textController[5].text);
                        await widget.authViewModel.sendEmailVerification();
                        navigator.pushNamed(AppRoutes.verifyEmail);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.background,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("Sign Up", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
