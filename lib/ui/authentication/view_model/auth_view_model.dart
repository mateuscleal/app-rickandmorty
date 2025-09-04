import 'package:flutter/foundation.dart';

import '../../../data/repositories/authentication/auth_repository.dart';
import '../../../domain/models/user.dart';

enum AuthMode { signUp, signIn }

class AuthViewModel extends ChangeNotifier {
  AuthRepository? _repo;
  AuthMode _authMode = AuthMode.signUp;
  UserModel? _currentUser;
  bool _isLoading = false, _isVerified = false;

  UserModel? get currentUser => _currentUser;

  bool get isLoading => _isLoading;

  bool get isVerified => _isVerified;

  bool get isSignIn => _authMode == AuthMode.signIn;

  void init(AuthRepository repo) {
    _repo ??= repo;
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final user = await _repo!.signIn(email, password);
    _isLoading = false;
    notifyListeners();
    if (user == null) {
      return {'user': false, 'verified': false};
    }
    final verified = await _repo!.isEmailVerified();
    return {'user': true, 'verified': verified};
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    await _repo!.signUp(email, password);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendEmailVerification() async {
    await _repo!.sendEmailVerification();
    notifyListeners();
  }

  Future<void> checkEmailVerified() async {
    _isVerified = await _repo!.isEmailVerified();
    notifyListeners();
  }

  Future<bool> checkIfEmailExists(String email) async {
    return await _repo!.checkIfEmailExists(email);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _repo!.sendPasswordResetEmail(email);
    notifyListeners();
  }

  Future<void> reloadUser() async {
    await _repo!.reloadUser();
    notifyListeners();
  }

  Future<void> signOut() async => _repo!.signOut();

  void toggleAuthMode() {
    _authMode = (_authMode == AuthMode.signIn) ? AuthMode.signUp : AuthMode.signIn;
    notifyListeners();
  }
}
