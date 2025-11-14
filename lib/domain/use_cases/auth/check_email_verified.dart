import '../../../data/repositories/authentication/auth_repository.dart';

class CheckEmailVerified {
  final AuthRepository repository;

  CheckEmailVerified(this.repository);

  Future<bool> call() async {
    return await repository.isEmailVerified();
  }
}
