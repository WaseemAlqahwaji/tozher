import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tozher/features/interests/data/model/interest_add_model.dart';
import 'package:tozher/features/interests/data/model/interest_model.dart';
import 'package:tozher/features/interests/data/model/interest_update_model.dart';
import 'package:tozher/features/interests/domain/params/interest_add_params.dart';
import 'package:tozher/features/interests/domain/params/interest_update_params.dart';

class InterestSource {
  final String collectionName = 'interests';
  final FirebaseFirestore _firestore;

  InterestSource(this._firestore);

  Future<List<InterestModel>> getInterests() async {
    final snapshot = await _firestore.collection(collectionName).get();
    return snapshot.docs.map((doc) => InterestModel.fromMap(doc.data(), doc.id)).toList();
  }

  Future<void> addInterest(InterestAddParams interestAddParams) async {
    await _firestore.collection(collectionName).add(interestAddParams.toModel().toMap());
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
}
