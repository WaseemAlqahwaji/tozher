import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tozher/features/auth/data/model/user_model.dart';
import 'package:tozher/features/auth/domain/params/auth_update_profile_params.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> login(String email, String password);

  Future<Either<Failure, UserCredential>> register(String email, String password);

  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> updateProfile(AuthUpdateProfileParams params);

  Future<Either<Failure, List<UserModel>>> searchUsers(String query);

  // Future<Either<Failure, UserModel>> getProfile();

  Stream<User?> get userStream;
}
