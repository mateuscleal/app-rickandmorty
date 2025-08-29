import 'package:flutter/material.dart';

import '../../_core/theme/app_colors.dart';
import 'sign_in.dart';
import 'sign_up.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({super.key});

  final ValueNotifier<bool> isSignIn = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ValueListenableBuilder<bool>(
        valueListenable: isSignIn,
        builder: (context, value, child) => Stack(
          children: [
            Stack(
              children: [
                Positioned(top: 10, left: 0, child: Image.asset('assets/gif/giphy.gif', fit: BoxFit.fill)),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.background.withValues(alpha: 0.5),
                  ),
                ),
                Positioned(
                  top: -20,
                  left: 80,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: isSignIn.value ? 350 : 200,
                    width: MediaQuery.of(context).size.width - 150,
                    child: Image.asset('assets/images/logo_rm_home_sbg.png'),
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              margin: EdgeInsets.only(top: isSignIn.value ? 250 : 150),
              duration: Duration(milliseconds: 500),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - (isSignIn.value ? 250 : 100),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Offstage(
                      offstage: !isSignIn.value,
                      child: SignIn(isSignIn: isSignIn),
                    ),
                    Offstage(
                      offstage: isSignIn.value,
                      child: SignUp(isSignIn: isSignIn),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
