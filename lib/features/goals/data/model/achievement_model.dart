import 'package:tozher/features/goals/domain/entity/achievement.dart';

class AchievementModel {
  final String id;
  final String title;
  final bool isDone;

  const AchievementModel({
    required this.id,
    required this.title,
    required this.isDone,
  });

  Achievement toEntity() => Achievement(
    id: id,
    title: title,
    isDone: isDone,
  );

  factory AchievementModel.fromEntity(Achievement entity) => AchievementModel(
    id: entity.id,
    title: entity.title,
    isDone: entity.isDone,
  );

  factory AchievementModel.fromMap(Map<String, dynamic> map, String documentId) {
    return AchievementModel(
      id: documentId,
      title: map['title'] as String,
      isDone: map['is_done'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'is_done': isDone,
    };
  }
}
