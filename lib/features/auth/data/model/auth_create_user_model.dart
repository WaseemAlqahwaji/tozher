
class AuthCreateUserModel {
  final String email;
  final String password;

  AuthCreateUserModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
} 

