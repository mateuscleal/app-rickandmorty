import '../../../domain/models/user.dart';

abstract class AuthRepository {
  Future<UserModel?> signIn(String email, String password);

  Future<UserModel?> signUp(String email, String password);

  Future<void> sendEmailVerification();

  Future<bool> isEmailVerified();

  Future<bool> checkIfEmailExists(String email);

  Future<void> sendPasswordResetEmail(String email);

  Stream<UserModel?> authStateChanges();

  Future<void> reloadUser();

  Future<void> signOut();
}
