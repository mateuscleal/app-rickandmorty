class UserModel {
  final String id;
  final String email;
  final String displayName;
  final bool emailVerified;

  UserModel({required this.id, required this.email, required this.emailVerified, required this.displayName});
}
