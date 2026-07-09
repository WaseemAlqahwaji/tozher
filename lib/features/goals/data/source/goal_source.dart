import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tozher/features/goals/data/model/achievement_model.dart';
import 'package:tozher/features/goals/data/model/goal_add_model.dart';
import 'package:tozher/features/goals/data/model/goal_model.dart';
import 'package:tozher/features/goals/data/model/goal_update_model.dart';

class GoalSource {
  final String collectionName = 'goals';
  final String achievementsCollectionName = 'achievements';
  final FirebaseFirestore _firestore;
  GoalSource(this._firestore);

  Future<List<GoalModel>> getGoals(String userId) async {
    final snapshot = await _firestore
        .collection(collectionName)
        .where('user_id', isEqualTo: userId)
        .get();
    return snapshot.docs.map((doc) => GoalModel.fromMap(doc.data())).toList();
  }

  Future<void> addGoal(GoalAddModel goalAddModel) async {
    await _firestore.collection(collectionName).add(goalAddModel.toMap());
  }

  Future<void> updateGoal(String goalId, GoalUpdateModel goalUpdateModel) async {
    await _firestore
        .collection(collectionName)
        .doc(goalId)
        .update(goalUpdateModel.toMap());
  }

  Future<void> deleteGoal(String goalId) async {
    await _firestore.collection(collectionName).doc(goalId).delete();
  }

  Future<void> updateGoalVisibility(String goalId, bool isPrivate) async {
    await _firestore.collection(collectionName).doc(goalId).update({
      'is_private': isPrivate,
    });
  }

  Future<List<AchievementModel>> getAchievements(String goalId) async {
    final snapshot = await _firestore
        .collection(collectionName)
        .doc(goalId)
        .collection(achievementsCollectionName)
        .get();
    return snapshot.docs
        .map((doc) => AchievementModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> addAchievement(String goalId, AchievementModel achievement) async {
    await _firestore
        .collection(collectionName)
        .doc(goalId)
        .collection(achievementsCollectionName)
        .add(achievement.toMap());
  }

  Future<void> toggleAchievement(
    String goalId,
    String achievementId,
    bool isDone,
  ) async {
    await _firestore
        .collection(collectionName)
        .doc(goalId)
        .collection(achievementsCollectionName)
        .doc(achievementId)
        .update({'is_done': isDone});
  }
}