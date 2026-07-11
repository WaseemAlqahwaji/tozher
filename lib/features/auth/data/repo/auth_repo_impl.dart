import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tozher/features/auth/data/model/auth_create_user_model.dart';
import 'package:tozher/features/auth/data/model/user_model.dart';
import 'package:tozher/features/auth/data/source/auth_source.dart';
import 'package:tozher/features/auth/domain/params/auth_update_profile_params.dart';
import 'package:tozher/features/auth/domain/repo/auth_repo.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/core/error/error_converter.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthSource _authSource;

  AuthRepoImpl({
    required AuthSource authSource,
  }) : _authSource = authSource;

  @override
  Future<Either<Failure, UserModel>> login(
    String email,
    String password,
  ) async {
    return ErrorConverter.safeCall(() async {
      final res = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await _authSource.userProfile(res.user!.uid);
      user.emailVerified = res.user!.emailVerified;
      user.uid = res.user!.uid;
      return user;
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return ErrorConverter.safeCall(() async {
      return await _firebaseAuth.signOut();
    });
  }

  @override
  Stream<User?> get userStream => _firebaseAuth.authStateChanges();

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) {
    return ErrorConverter.safeCall(() async {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    });
  }

  @override
  Future<Either<Failure, UserCredential>> register(
    String email,
    String password,
  ) {
    return ErrorConverter.safeCall(() async {
      final res = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await res.user?.sendEmailVerification();
      await _authSource.createUser(
        AuthCreateUserModel(
          email: email,
          password: password,
        ),
        res.user!.uid,
      );
      return res;
    });
  }

  @override
  Future<Either<Failure, void>> updateProfile(AuthUpdateProfileParams params) {
    return ErrorConverter.safeCall(() async {
      await _authSource.updateProfile(params);
    });
  }

  @override
  Future<Either<Failure, List<UserModel>>> searchUsers(String query) {
    return ErrorConverter.safeCall(() async {
      return await _authSource.searchUsers(query);
    });
  }

  @override
  Future<Either<Failure, UserModel>> getProfile(String uid) async {
    return ErrorConverter.safeCall(() async {
      return await _authSource.userProfile(uid);
    });
  }
}
