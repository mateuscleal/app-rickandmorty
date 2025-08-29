import 'package:flutter/material.dart';

import '../../_core/theme/app_colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.isSignIn});

  final ValueNotifier<bool> isSignIn;

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
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 25,
          children: [
            Text(
              "Create your login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textTertiary),
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: textController[0],
                decoration: InputDecoration(
                  labelText: "First Name",
                  filled: true,
                  fillColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
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
              height: 50,
              child: TextFormField(
                controller: textController[1],
                decoration: InputDecoration(
                  labelText: "Last Name",
                  filled: true,
                  fillColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
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
              height: 50,
              child: TextFormField(
                controller: textController[2],
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
            SizedBox(
              height: 50,
              child: TextFormField(
                obscureText: true,
                controller: textController[3],
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
            SizedBox(
              height: 50,
              child: TextFormField(
                obscureText: true,
                controller: textController[4],
                decoration: InputDecoration(
                  labelText: "Confirm your password",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  return null;
                },
              ),
            ),

            SizedBox(
              height: 50,
              child: TextFormField(
                controller: textController[5],
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Cell phone",
                  filled: true,
                  fillColor: Colors.white,
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

            /// Sign Up Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.isSignIn.value = !widget.isSignIn.value;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text("Sign Up", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
