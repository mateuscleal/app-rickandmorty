import '../../../data/repositories/authentication/auth_repository.dart';

class CheckIfEmailExists {
  final AuthRepository repository;

  CheckIfEmailExists(this.repository);

  Future<bool> call(String email) async {
    return await repository.checkIfEmailExists(email);
  }
}
