class UserEntity {
  final String uid;
  final String email;
  final String? fullname;
  final int? age;
  final String? gender;
  final int? points;
  final String? role;

  UserEntity({
    required this.uid,
    required this.email,
    this.fullname,
    this.age,
    this.gender,
    this.points,
    this.role,
  });
}
