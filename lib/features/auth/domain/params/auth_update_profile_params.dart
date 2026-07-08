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
    this.points = 0,
    this.role = "user",
    required this.uid,
  });
}
