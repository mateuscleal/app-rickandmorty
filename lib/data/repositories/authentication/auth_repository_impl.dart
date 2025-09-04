import 'package:app/data/services/firebase_auth_service.dart';

import '../../../domain/models/user.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<UserModel?> signIn(String email, String password) async {
    final user = await _service.signIn(email, password);
    return user != null ? UserModel(id: user.uid, email: user.email!) : null;
  }

  @override
  Future<UserModel?> signUp(String email, String password) async {
    final user = await _service.signUp(email, password);
    return user != null ? UserModel(id: user.uid, email: user.email!) : null;
  }

  @override
  Future<void> sendEmailVerification() async => await _service.sendEmailVerification();

  @override
  Future<bool> isEmailVerified() async => await _service.isEmailVerified();

  @override
  Future<bool> checkIfEmailExists(String email) async => await _service.checkIfEmailExists(email);

  @override
  Future<void> sendPasswordResetEmail(String email) async => await _service.sendPasswordResetEmail(email);

  @override
  Stream<UserModel?> authStateChanges() {
    return _service.authStateChanges().map(
      (user) => user != null ? UserModel(id: user.uid, email: user.email!, displayName: user.displayName) : null,
    );
  }

  @override
  Future<bool> reloadUser() async => await _service.reloadUser();

  @override
  Future<void> signOut() => _service.signOut();
}
