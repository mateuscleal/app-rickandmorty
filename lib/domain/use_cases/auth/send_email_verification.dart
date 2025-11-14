import '../../../data/repositories/authentication/auth_repository.dart';

class SendEmailVerification {
  final AuthRepository repository;

  SendEmailVerification(this.repository);

  Future<void> call() async {
    return await repository.sendEmailVerification();
  }
}
