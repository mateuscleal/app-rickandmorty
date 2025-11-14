import '../../domain/models/user.dart';

class UserDto {
  final String id;
  final String email;
  final String displayName;
  final bool emailVerified;

  UserDto({required this.id, required this.email, required this.emailVerified, required this.displayName});

  factory UserDto.fromMap(Map<String, dynamic> data) {
    return UserDto(
      id: data['id'],
      email: data['email'],
      emailVerified: data['emailVerified'],
      displayName: data['displayName'],
    );
  }

  UserModel toDomain() {
    return UserModel(
      id: id,
      email: email,
      emailVerified: emailVerified,
      displayName: displayName,
    );
  }
}
