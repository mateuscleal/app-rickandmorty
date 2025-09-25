import 'package:app/ui/authentication/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_core/theme/app_colors.dart';
import '../widgets/sign_in.dart';
import '../widgets/sign_up.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, authViewModel, child) => Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
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
                  left: 85,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: authViewModel.isSignIn ? 200 : 350,
                    width: MediaQuery.of(context).size.width - 150,
                    child: Image.asset('assets/images/logo_rm_home_sbg.png'),
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              margin: EdgeInsets.only(top: authViewModel.isSignIn ? 150 : 250),
              duration: Duration(milliseconds: 500),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - (authViewModel.isSignIn ? 100 : 250),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Offstage(
                      offstage: authViewModel.isSignIn,
                      child: SignIn(authViewModel: authViewModel),
                    ),
                    Offstage(
                      offstage: !authViewModel.isSignIn,
                      child: SignUp(authViewModel: authViewModel),
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
