import 'package:tozher/features/auth/domain/params/auth_update_profile_params.dart';

class AuthUpdateProfileModel {
  final String fullname;
  final String username;
  final int age;
  final String gender;
  final int points;
  final String role;

  AuthUpdateProfileModel({
    required this.fullname,
    required this.username,
    required this.age,
    required this.gender,
    required this.points,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'username': username,
      'age': age,
      'gender': gender,
      'points': points,
      'role': role,
    };
  }
}

extension AuthToMap on AuthUpdateProfileParams {
  AuthUpdateProfileModel toModel() {
    return AuthUpdateProfileModel(
      fullname: fullname,
      username: username,
      age: age,
      gender: gender,
      points: points,
      role: role,
    );
  }
}
