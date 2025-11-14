import '../../../domain/models/password_reset_result.dart';
import '../../model/user_dto.dart';

abstract class AuthRepository {
  Future<UserDto?> signIn(String email, String password);

  Future<UserDto?> signUp(String email, String password, String displayName);

  Future<void> sendEmailVerification();

  Future<bool> isEmailVerified();

  Future<PasswordResetResult> sendPasswordResetEmail(String email);

  Future<void> signOut();
}
