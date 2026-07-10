import 'package:tozher/features/goals/domain/params/achievement_add_params.dart';

class AchievementAddModel {
  final List<String> names;

  AchievementAddModel({required this.names});
}

extension AchievementAddParamToModel on AchievementAddParams {
  AchievementAddModel toModel() => AchievementAddModel(names: names);
}
