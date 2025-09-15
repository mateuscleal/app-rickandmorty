import '../../model/user_dto.dart';

abstract class AuthRepository {
  Future<UserDto?> signIn(String email, String password);

  Future<UserDto?> signUp(String email, String password, String displayName);

  Future<void> sendEmailVerification();

  Future<bool> isEmailVerified();

  Future<bool> checkIfEmailExists(String email);

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();
}
