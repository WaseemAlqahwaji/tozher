import 'package:cloud_firestore/cloud_firestore.dart';

class AuthSource {
  final FirebaseFirestore _firestore;
  final String collectionName = 'users';

  AuthSource(this._firestore);

  Future<void> createUser() async {
    final user = _firestore.collection(collectionName).doc();
    await user.set({
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
