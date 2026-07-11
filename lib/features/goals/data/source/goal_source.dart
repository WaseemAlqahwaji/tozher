import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tozher/features/goals/data/model/achievement_model.dart';
import 'package:tozher/features/goals/data/model/goal_add_model.dart';
import 'package:tozher/features/goals/data/model/goal_model.dart';
import 'package:tozher/features/goals/data/model/goal_update_model.dart';

class GoalSource {
  static const String _usersCollection = 'users';
  static const String _goalsCollection = 'goals';
  static const String _achievementsCollection = 'achievements';
  final FirebaseFirestore _firestore;
  GoalSource(this._firestore);

  DocumentReference _goalDoc(String userId, String goalId) => _firestore
      .collection(_usersCollection)
      .doc(userId)
      .collection(_goalsCollection)
      .doc(goalId);

  DocumentReference _userDoc(String userId) =>
      _firestore.collection(_usersCollection).doc(userId);

  CollectionReference _goalsRef(String userId) => _firestore
      .collection(_usersCollection)
      .doc(userId)
      .collection(_goalsCollection);

  CollectionReference _achievementsRef(String userId, String goalId) =>
      _goalDoc(userId, goalId).collection(_achievementsCollection);

  Future<List<GoalModel>> getGoals(String userId) async {
    final snapshot = await _goalsRef(userId).get();

    final goalModels = <GoalModel>[];
    for (final doc in snapshot.docs) {
      final achievements = await getAchievements(userId, doc.id);
      goalModels.add(
        GoalModel.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
          achievements,
        ),
      );
    }

    return goalModels;
  }

  Future<void> addGoal(GoalAddModel goalAddModel) async {
    final batch = _firestore.batch();
    final userId = goalAddModel.userId;

    // Pre-generate goal document reference
    final goalDocRef = _goalsRef(userId).doc();
    batch.set(goalDocRef, goalAddModel.toMap());

    final goalId = goalDocRef.id;

    // Add all achievements in the same batch
    for (final achievementName in goalAddModel.achievementsNames) {
      final achievementRef = _achievementsRef(userId, goalId).doc();
      final achievement = AchievementModel.fromName(
        goalId: goalId,
        title: achievementName,
      );
      batch.set(achievementRef, achievement.toMap());
    }

    // Single atomic commit — all writes succeed or fail together
    await batch.commit();
  }

  Future<void> updateGoal(
    String userId,
    String goalId,
    GoalUpdateModel goalUpdateModel,
  ) async {
    await _goalDoc(userId, goalId).update(goalUpdateModel.toMap());
  }

  Future<void> deleteGoal(String userId, String goalId) async {
    await _goalDoc(userId, goalId).delete();
  }

  Future<void> updateGoalVisibility(
    String userId,
    String goalId,
    bool isPrivate,
  ) async {
    await _goalDoc(userId, goalId).update({'is_private': isPrivate});
  }

  Future<List<AchievementModel>> getAchievements(
    String userId,
    String goalId,
  ) async {
    final snapshot = await _achievementsRef(userId, goalId).get();
    return snapshot.docs
        .map(
          (doc) => AchievementModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList();
  }

  Future<void> addAchievement(
    String userId,
    String goalId,
    AchievementModel achievement,
  ) async {
    await _achievementsRef(userId, goalId).add(achievement.toMap());
  }

  Future<void> toggleAchievement(
    String userId,
    String goalId,
    String achievementId,
    bool isDone,
  ) async {
    final batch = _firestore.batch();

    // Update the achievement status
    batch.update(_achievementsRef(userId, goalId).doc(achievementId), {
      'is_done': isDone,
    });

    // Award or deduct points on the user document
    batch.update(_userDoc(userId), {
      'points': FieldValue.increment(isDone ? 10 : -10),
    });

    await batch.commit();
  }
}
