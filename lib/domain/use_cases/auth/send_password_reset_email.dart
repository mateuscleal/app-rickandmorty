import '../../../data/repositories/authentication/auth_repository.dart';

class SendPasswordResetEmail {
  final AuthRepository repository;

  SendPasswordResetEmail(this.repository);

  Future<void> call(String email) async {
    return await repository.sendPasswordResetEmail(email);
  }
}
