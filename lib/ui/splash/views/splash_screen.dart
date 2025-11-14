import 'dart:async';

import 'package:app/data/model/user_dto.dart';
import 'package:app/data/services/firebase_auth_service.dart';
import 'package:app/routing/app_routes.dart';
import 'package:app/ui/_core/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../authentication/view_model/auth_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final ValueNotifier progressNotifier = ValueNotifier(0.0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) async {
      progressNotifier.value += 0.05;

      if (progressNotifier.value >= 1.0) {
        timer.cancel();
        await _handleNavigation();
      }
    });
  }

  Future<void> _handleNavigation() async {
    final User? user = _firebaseAuthService.currentUser;
    final auth = context.read<AuthViewModel?>();

    if (user == null || !user.emailVerified) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.authentication);
    } else {
      auth?.setCurrentUser(
        UserDto.fromMap({
          'id': user.uid,
          'email': user.email!,
          'emailVerified': user.emailVerified,
          'displayName': user.displayName ?? '',
        }).toDomain(),
      );
      Navigator.of(context).pushReplacementNamed(AppRoutes.mainScaffold);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Container(
              width: 300,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/logo_rm_home.png')),
              ),
            ),
            SizedBox(
              width: 250,
              child: Text(
                '"Wubba Lubba Dub Dub!"\nWelcome to dimensions that even Rick never imagined.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: progressNotifier,
              builder: (context, progressValue, child) {
                return SizedBox(
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.5),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: progressValue,
                      backgroundColor: Colors.white,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    progressNotifier.dispose();
    super.dispose();
  }
}
