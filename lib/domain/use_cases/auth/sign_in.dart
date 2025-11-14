import '../../models/user.dart';
import '../../../data/repositories/authentication/auth_repository.dart';

class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<UserModel?> call(String email, String password) async {
    final dto = await repository.signIn(email, password);
    return dto?.toDomain();
  }
}
