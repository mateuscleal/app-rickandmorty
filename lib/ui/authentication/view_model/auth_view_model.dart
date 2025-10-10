import 'package:app/data/repositories/authentication/auth_repository_impl.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/models/password_reset_result.dart';
import '../../../domain/models/user.dart';
import '../../../domain/use_cases/auth/auth_usecases.dart';

enum AuthMode { signUp, signIn }

class AuthViewModel extends ChangeNotifier {
  late AuthRepositoryImpl _repository;
  late AuthUseCases _usecases;
  AuthMode _authMode = AuthMode.signUp;
  UserModel? _currentUser;
  bool _isLoading = false, _isVerified = false;

  UserModel? get currentUser => _currentUser;

  bool get isLoading => _isLoading;

  bool get isVerified => _isVerified;

  bool get isSignIn => _authMode == AuthMode.signIn;

  void init(AuthRepositoryImpl repo) {
    _repository = repo;
    _usecases = AuthUseCases(_repository);
  }

  Future<UserModel?> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    _currentUser = await _usecases.signIn(email, password);
    _isLoading = false;
    notifyListeners();
    return currentUser;
  }

  Future<void> signUp(String email, String password, String displayName) async {
    _isLoading = true;
    notifyListeners();
    _currentUser = await _usecases.signUp(email, password, displayName);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendEmailVerification() async {
    await _usecases.sendEmailVerification();
    notifyListeners();
  }

  Future<void> checkEmailVerified() async {
    _isVerified = await _usecases.checkEmailVerified();
    notifyListeners();
  }

  Future<PasswordResetResult> sendPasswordResetEmail(String email) async {
    final result = await _usecases.sendPasswordResetEmail(email);
    notifyListeners();
    return result;
  }

  Future<void> signOut() async => await _usecases.signOut();

  void setCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  void toggleAuthMode() {
    _authMode = (_authMode == AuthMode.signIn) ? AuthMode.signUp : AuthMode.signIn;
    notifyListeners();
  }
}
