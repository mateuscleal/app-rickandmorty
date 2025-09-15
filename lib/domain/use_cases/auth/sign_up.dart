import '../../../data/repositories/authentication/auth_repository.dart';
import '../../models/user.dart';

class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<UserModel?> call(String email, String password, String displayName) async {
    final dto = await repository.signUp(email, password, displayName);
    return dto?.toDomain();
  }
}
