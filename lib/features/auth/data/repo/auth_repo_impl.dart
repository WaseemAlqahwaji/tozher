import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tozher/features/auth/data/source/auth_source.dart';
import 'package:tozher/features/auth/domain/repo/auth_repo.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/core/error/error_converter.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore;
  final AuthSource _authSource;

  AuthRepoImpl({
    required FirebaseFirestore firestore,
    required AuthSource authSource,
  }) : _authSource = authSource,
       _firestore = firestore;

  @override
  Future<Either<Failure, UserCredential>> login(
    String email,
    String password,
  ) async {
    return ErrorConverter.safeCall(() async {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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

      _firestore.collection('users').doc(res.user?.uid).set({
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return res;
    });
  }
}
