
class UserModel {
  final String email;
  final String? fullname;
  final String? username;
  final int? age;
  final String? gender;
  final int? points;
  final String? role;
  bool? emailVerified;
  String? uid;

  UserModel({
    required this.email,
    this.fullname,
    this.username,
    this.age,
    this.gender,
    this.points,
    this.role,
    this.emailVerified,
    this.uid,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      fullname: map['fullname'],
      username: map['username'],
      age: map['age'],
      gender: map['gender'],
      points: map['points'],
      role: map['role'],
      emailVerified: map['emailVerified'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullname': fullname,
      'username': username,
      'age': age,
      'gender': gender,
      'points': points,
      'role': role,
      'emailVerified': emailVerified,
    };
  }

  bool isProfileCompleted() {
    return gender != null &&
        fullname != null &&
        username != null &&
        age != null;
  }
}
