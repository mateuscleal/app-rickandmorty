import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

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
  final _focusNodes = List.generate(6, (index) => FocusNode());
  final _obscureText = List.generate(2, (index) => ValueNotifier<bool>(true));

  final _textController = List.generate(6, (index) => TextEditingController());
  final _buttonController = RoundedLoadingButtonController();

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
                  for (var element in _textController) {
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
                    focusNode: _focusNodes[0],
                    controller: _textController[0],
                    textInputAction: TextInputAction.next,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: "First Name",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_focusNodes[1]),
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
                    focusNode: _focusNodes[1],
                    controller: _textController[1],
                    textInputAction: TextInputAction.next,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_focusNodes[2]),
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
                    focusNode: _focusNodes[2],
                    controller: _textController[2],
                    textInputAction: TextInputAction.next,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: "Email",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_focusNodes[3]),
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
                    focusNode: _focusNodes[3],
                    controller: _textController[3],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, TelefoneInputFormatter()],
                    decoration: InputDecoration(
                      labelText: "Cell phone",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_focusNodes[4]),
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
                  child: ValueListenableBuilder(
                    valueListenable: _obscureText[0],
                    builder: (context, value, child) {
                      return TextFormField(
                        obscureText: value,
                        focusNode: _focusNodes[4],
                        controller: _textController[4],
                        textInputAction: TextInputAction.next,
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
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ),
                        onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_focusNodes[5]),
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
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: ValueListenableBuilder(
                    valueListenable: _obscureText[1],
                    builder: (context, value, child) {
                      return TextFormField(
                        obscureText: value,
                        focusNode: _focusNodes[5],
                        controller: _textController[5],
                        textInputAction: TextInputAction.done,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          labelText: "Confirm your password",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(left: 12),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () => _obscureText[1].value = !value,
                            child: Icon(
                              !value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                          _buttonController.start();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _textController[4].text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: RoundedLoadingButton(
                    color: AppColors.background,
                    controller: _buttonController,
                    resetAfterDuration: true,
                    resetDuration: Duration(seconds: 3),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      final navigator = Navigator.of(context);
                      if (_formKey.currentState!.validate()) {
                        await widget.authViewModel.signUp(
                          _textController[2].text,
                          _textController[5].text,
                          "${_textController[0].text.trim()} ${_textController[1].text.trim()}",
                        );
                        await widget.authViewModel.sendEmailVerification();
                        await navigator.pushNamed(AppRoutes.verifyEmail);
                        widget.authViewModel.toggleAuthMode();
                        _cleanTextFields();
                      }
                    },
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

  void _cleanTextFields() {
    for (int i = 0; i < 6; i++) {
      _textController[i].clear();
      _focusNodes[i].unfocus();
    }
  }
}
