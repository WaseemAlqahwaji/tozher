import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tozher/features/goals/data/model/goal_model.dart';

class GoalSource {
  final String collectionName = 'goals';
  final FirebaseFirestore _firestore;
  GoalSource(this._firestore);

  Future<List<GoalModel>> getGoals() async {
    final snapshot = await _firestore.collection(collectionName).get();
    return snapshot.docs.map((doc) => GoalModel.fromMap(doc.data())).toList();
  }

  Future<void> addGoal(GoalModel goalModel) async {
    await _firestore.collection(collectionName).add(goalModel.toMap());
  }

  Future<void> updateGoal(GoalModel goalModel) async {
    await _firestore.collection(collectionName).doc(goalModel.id).update(goalModel.toMap());
  }

  Future<void> deleteGoal(String goalId) async {
    await _firestore.collection(collectionName).doc(goalId).delete();
  }
}