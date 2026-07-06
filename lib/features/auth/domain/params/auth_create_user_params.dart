class AuthCreateUserParams {
  final String email;
  final String fullname;
  final String username;
  final String password;

  AuthCreateUserParams({
    required this.email,
    required this.password,
    required this.fullname,
    required this.username,
  });
}