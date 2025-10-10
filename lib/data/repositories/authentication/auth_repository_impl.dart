import 'package:app/data/services/firebase_auth_service.dart';

import '../../../domain/models/password_reset_result.dart';
import '../../model/user_dto.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<UserDto?> signIn(String email, String password) async {
    final user = await _service.signIn(email, password);
    if (user != null) {
      return UserDto.fromMap({
        'id': user.uid,
        'email': user.email!,
        'emailVerified': user.emailVerified,
        'displayName': user.displayName ?? '',
      });
    }
    return null;
  }

  @override
  Future<UserDto?> signUp(String email, String password, String displayName) async {
    final user = await _service.signUp(email, password);
    if (user != null) {
      await user.updateDisplayName(displayName);
      return UserDto.fromMap({
        'id': user.uid,
        'email': user.email!,
        'emailVerified': user.emailVerified,
        'displayName': user.displayName ?? displayName,
      });
    }
    return null;
  }

  @override
  Future<void> sendEmailVerification() async => await _service.sendEmailVerification();

  @override
  Future<bool> isEmailVerified() async => await _service.isEmailVerified();

  @override
  Future<PasswordResetResult> sendPasswordResetEmail(String email) async {
    return await _service.sendPasswordResetEmail(email);
  }

  @override
  Future<void> signOut() => _service.signOut();
}
