import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint(FirebaseAuthException(code: e.code, message: e.message).toString());
      return null;
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint(FirebaseAuthException(code: e.code, message: e.message).toString());
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
      debugPrint(FirebaseAuthException(code: e.code, message: e.message).toString());
      return;
    }
  }

  Future<bool> isEmailVerified() async {
    try {
      if (_auth.currentUser == null) return false;
      await _auth.currentUser!.reload();
      return _auth.currentUser?.emailVerified ?? false;
    } on FirebaseAuthException catch (e) {
      debugPrint(FirebaseAuthException(code: e.code, message: e.message).toString());
      return false;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      debugPrint(FirebaseAuthException(code: e.code, message: e.message).toString());
      return;
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
      debugPrint(FirebaseAuthException(code: e.code, message: e.message).toString());
      return false;
    }
  }

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async => _auth.signOut();

  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
