import '../../../data/repositories/authentication/auth_repository.dart';
import 'sign_in.dart';
import 'sign_up.dart';
import 'send_email_verification.dart';
import 'check_email_verified.dart';
import 'send_password_reset_email.dart';
import 'sign_out.dart';

class AuthUseCases {
  final AuthRepository repository;
  late final SignIn signIn;
  late final SignUp signUp;
  late final SendEmailVerification sendEmailVerification;
  late final CheckEmailVerified checkEmailVerified;
  late final SendPasswordResetEmail sendPasswordResetEmail;
  late final SignOut signOut;

  AuthUseCases(this.repository) {
    signIn = SignIn(repository);
    signUp = SignUp(repository);
    sendEmailVerification = SendEmailVerification(repository);
    checkEmailVerified = CheckEmailVerified(repository);
    sendPasswordResetEmail = SendPasswordResetEmail(repository);
    signOut = SignOut(repository);
  }
}