import '../../../domain/models/user.dart';

abstract class AuthRepository {
  Future<UserModel?> signIn(String email, String password);

  Future<UserModel?> signUp(String email, String password);

  Future<void> signOut();

  Stream<UserModel?> authStateChanges();

  Future<void> sendEmailVerification();

  Future<bool> isEmailVerified();

  Future<void> reloadUser();
}
