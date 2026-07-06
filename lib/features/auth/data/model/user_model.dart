import 'package:tozher/features/auth/domain/entity/user_entity.dart';

class UserModel {
  final String uid;
  final String email;
  final String? fullname;
  final String? username;
  final int? age;
  final String? gender;
  final int? points;
  final String? role;

  UserModel({
    required this.uid,
    required this.email,
    this.fullname,
    this.username,
    this.age,
    this.gender,
    this.points,
    this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      fullname: map['fullname'],
      username: map['username'],
      age: map['age'],
      gender: map['gender'],
      points: map['points'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullname': fullname,
      'username': username,
      'age': age,
      'gender': gender,
      'points': points,
      'role': role,
    };
  }

  UserEntity toEntity() => UserEntity(
        uid: uid,
        email: email,
        fullname: fullname,
        age: age,
        gender: gender,
        points: points,
        role: role,
      );

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
        uid: entity.uid,
        email: entity.email,
        fullname: entity.fullname,
        age: entity.age,
        gender: entity.gender,
        points: entity.points,
        role: entity.role,
      );
}

extension UserEntityToModel on UserEntity {
  UserModel toModel() => UserModel.fromEntity(this);
}
