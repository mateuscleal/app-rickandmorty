import 'package:flutter/foundation.dart';

import '../../../data/repositories/authentication/auth_repository.dart';
import '../../../domain/models/user.dart';

enum AuthMode {signUp, signIn}

class AuthViewModel extends ChangeNotifier {
  AuthRepository? _repo;
  AuthMode _authMode = AuthMode.signUp;
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;

  bool get isLoading => _isLoading;

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
      return {
        'user': false,
        'verified': false,
      };
    }
    final verified = await _repo!.isEmailVerified();
    return {
      'user': user,
      'verified': verified,
    };
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    await _repo!.signUp(email, password);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async => _repo!.signOut();

  Future<void> sendEmailVerification() async {
    _isLoading = true;
    notifyListeners();
    await _repo!.sendEmailVerification();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> checkEmailVerified() async {
    _isLoading = true;
    notifyListeners();
    final verified = await _repo!.isEmailVerified();
    _isLoading = false;
    notifyListeners();
    return verified;
  }

  Future<void> reloadUser() async {
    await _repo!.reloadUser();
  }

  void toggleAuthMode() {
    _authMode = _authMode == AuthMode.signIn ? AuthMode.signUp : AuthMode.signIn;
    notifyListeners();
  }
}
