import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tozher/features/auth/data/source/auth_source.dart';
import 'package:tozher/features/interests/data/model/interest_add_model.dart';
import 'package:tozher/features/interests/data/model/interest_model.dart';
import 'package:tozher/features/interests/data/model/interest_update_model.dart';
import 'package:tozher/features/interests/data/model/interests_user_add_model.dart';
import 'package:tozher/features/interests/data/model/interests_user_remove_model.dart';
import 'package:tozher/features/interests/domain/params/interest_add_params.dart';
import 'package:tozher/features/interests/domain/params/interest_update_params.dart';

class InterestSource {
  final String collectionName = 'interests';
  final FirebaseFirestore _firestore;
  final AuthSource source;

  InterestSource(this._firestore, this.source);

  Future<List<InterestModel>> getInterests() async {
    final snapshot = await _firestore.collection(collectionName).get();
    return snapshot.docs
        .map((doc) => InterestModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> addInterest(InterestAddParams interestAddParams) async {
    await _firestore
        .collection(collectionName)
        .add(interestAddParams.toModel().toMap());
  }

  Future<void> updateInterest(InterestUpdateParams interestUpdateParams) async {
    await _firestore
        .collection(collectionName)
        .doc(interestUpdateParams.id)
        .update(interestUpdateParams.toModel().toMap());
  }

  Future<void> deleteInterest(String interestId) async {
    await _firestore.collection(collectionName).doc(interestId).delete();
  }

  Future<void> addUserInterests(InterestsUserAddModel model) async {
    final userDoc = _firestore.collection(source.collectionName).doc(model.uid);
    await userDoc.update({
      collectionName: FieldValue.arrayUnion([model.interestsIds]),
    });
  }

  Future<void> removeUserInterests(InterestsUserRemoveModel model) async {
    final userDoc = _firestore.collection(source.collectionName).doc(model.uid);
    await userDoc.update({
      collectionName: FieldValue.arrayRemove([model.interestsIds]),
    });
  }

  Future<List<InterestModel>> getUserInterests(String uid) async {
    final userDoc = await _firestore
        .collection(source.collectionName)
        .doc(uid)
        .get();
    final List<dynamic>? interestIds = userDoc.data()?[collectionName];
    if (interestIds == null || interestIds.isEmpty) return [];

    final interestsSnapshot = await _firestore
        .collection(collectionName)
        .where(FieldPath.documentId, whereIn: interestIds)
        .get();

    List<InterestModel> interestsModels = [];
    interestsSnapshot.docs.map((interests) {
      interestsModels.add(
        InterestModel.fromMap(interests.data(), interests.id),
      );
    });
    return interestsModels;
  }
}
