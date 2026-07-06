import 'package:tozher/features/auth/domain/params/auth_create_user_params.dart';

class AuthCreateUserModel {
  final String email;
  final String fullname;
  final String username;
  final String password;

  AuthCreateUserModel({
    required this.email,
    required this.password,
    required this.fullname,
    required this.username,
  });
}

extension AuthCreateUserModelExtension on AuthCreateUserParams {
  AuthCreateUserModel toModel() {
    return AuthCreateUserModel(
      email: email,
      password: password,
      fullname: fullname,
      username: username,
    );
  }
}