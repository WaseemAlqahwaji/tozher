class AuthUpdateProfileParams {
  final String uid;
  final String fullname;
  final String username;
  final int age;
  final String gender;
  final int points;
  final String role;

  AuthUpdateProfileParams({
    required this.fullname,
    required this.username,
    required this.age,
    required this.gender,
    required this.points,
    required this.role,
    required this.uid,
  });
}
