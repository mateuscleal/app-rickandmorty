import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../../domain/models/password_reset_result.dart';


class FirebaseAuthService {
  final logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      logger.e(FirebaseAuthException(code: e.code, message: e.message));
      return null;
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      return result.user;
    } on FirebaseAuthException catch (e) {
      logger.e(FirebaseAuthException(code: e.code, message: e.message));
      return null;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      logger.e(FirebaseAuthException(code: e.code, message: e.message));
      return;
    }
  }

  Future<bool> isEmailVerified() async {
    try {
      if (_auth.currentUser == null) return false;
      await _auth.currentUser!.reload();
      return _auth.currentUser?.emailVerified ?? false;
    } on FirebaseAuthException catch (e) {
      logger.e(FirebaseAuthException(code: e.code, message: e.message));
      return false;
    }
  }

  Future<PasswordResetResult> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return PasswordResetResult.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' || e.code == 'user-not-found') {
        return PasswordResetResult.userNotFoundOrUnknown;
      } else if (e.code == 'network-request-failed') {
        return PasswordResetResult.networkError;
      } else {
        return PasswordResetResult.userNotFoundOrUnknown;
      }
    }
  }

  Future<bool> reloadUser() async {
    try {
      if (_auth.currentUser != null) {
        await _auth.currentUser!.reload();
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      logger.e(FirebaseAuthException(code: e.code, message: e.message));
      return false;
    }
  }

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async => _auth.signOut();
}
