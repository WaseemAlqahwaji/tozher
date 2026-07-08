import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tozher/features/auth/data/model/auth_create_user_model.dart';
import 'package:tozher/features/auth/data/model/auth_update_profile_model.dart';
import 'package:tozher/features/auth/data/model/user_model.dart';
import 'package:tozher/features/auth/domain/params/auth_update_profile_params.dart';

class AuthSource {
  final FirebaseFirestore _firestore;
  final String collectionName = 'users';

  AuthSource(this._firestore);

  Future<void> createUser(
    AuthCreateUserModel authCreateUserModel,
    String uid,
  ) async {
    final user = _firestore.collection(collectionName).doc(uid);
    await user.set(authCreateUserModel.toMap());
  }

  Future<UserModel> userProfile(String uid) async {
    final user = await _firestore.collection(collectionName).doc(uid).get();
    if (!user.exists) {
      throw Exception("User not found");
    }
    return UserModel.fromMap(user.data()!);
  }

  Future<void> updateProfile(AuthUpdateProfileParams params) async {
    final docRef = FirebaseFirestore.instance
        .collection(collectionName)
        .doc(params.username);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists) {
      final userModel = params.toModel();
      final user = _firestore.collection(collectionName).doc(params.uid);
      await user.update(userModel.toMap());
    } else {
      throw Exception("username already taken");
    }
  }
}
