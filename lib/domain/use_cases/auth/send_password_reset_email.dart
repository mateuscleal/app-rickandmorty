import '../../../data/repositories/authentication/auth_repository.dart';
import '../../models/password_reset_result.dart';

class SendPasswordResetEmail {
  final AuthRepository repository;

  SendPasswordResetEmail(this.repository);

  Future<PasswordResetResult> call(String email) async {
    return await repository.sendPasswordResetEmail(email);
  }
}
