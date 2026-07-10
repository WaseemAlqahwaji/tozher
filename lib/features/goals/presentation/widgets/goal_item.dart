import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:tozher/features/core/presentation/widgets/loading_widget.dart';
import 'package:tozher/features/goals/data/model/achievement_model.dart';
import 'package:tozher/features/goals/data/source/goal_source.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';
import 'package:tozher/features/goals/domain/params/toggle_achievement_params.dart';
import 'package:tozher/features/goals/domain/params/update_goal_visibility_params.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_toggle_achievement_cubit.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_update_visibility_cubit.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';

class GoalItem extends StatefulWidget {
  final Goal goal;
  const GoalItem({super.key, required this.goal});

  @override
  State<GoalItem> createState() => _GoalItemState();
}

class _GoalItemState extends State<GoalItem> {
  late bool _isPrivate;
  bool _isExpanded = false;
  bool _isTogglingVisibility = false;
  List<AchievementModel> _achievements = [];
  bool _isLoadingAchievements = false;

  @override
  void initState() {
    super.initState();
    _isPrivate = widget.goal.isPrivate;
  }

  Future<void> _loadAchievements() async {
    setState(() => _isLoadingAchievements = true);
    final source = getIt<GoalSource>();
    final result = await source.getAchievements(
      widget.goal.userId,
      widget.goal.id,
    );
    setState(() {
      _achievements = result;
      _isLoadingAchievements = false;
    });
  }

  void _toggleVisibility() {
    final newIsPrivate = !_isPrivate;
    setState(() {
      _isPrivate = newIsPrivate;
      _isTogglingVisibility = true;
    });

    final cubit = getIt<GoalUpdateVisibilityCubit>();
    cubit.updateGoalVisibility(
      UpdateGoalVisibilityParams(
        userId: widget.goal.userId,
        goalId: widget.goal.id,
        isPrivate: newIsPrivate,
      ),
    );

    cubit.stream.firstWhere((s) => !s.isInProgress).then((_) {
      if (mounted) {
        setState(() => _isTogglingVisibility = false);
      }
    });
  }

  void _toggleAchievement(AchievementModel achievement) {
    final cubit = getIt<GoalToggleAchievementCubit>();
    final newIsDone = !achievement.isDone;

    setState(() {
      _achievements = _achievements.map((a) {
        if (a.id == achievement.id) {
          return AchievementModel(
            id: a.id,
            goalId: a.goalId,
            title: a.title,
            isDone: newIsDone,
          );
        }
        return a;
      }).toList();
    });

    cubit.toggleAchievement(
      ToggleAchievementParams(
        userId: widget.goal.userId,
        goalId: widget.goal.id,
        achievementId: achievement.id,
        isDone: newIsDone,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.goal.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                if (_isTogglingVisibility)
                  const SizedBox(width: 24, height: 24, child: LoadingWidget())
                else
                  GestureDetector(
                    onTap: _toggleVisibility,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isPrivate
                                  ? Icons.lock_outline
                                  : Icons.public_outlined,
                            ),
                            Gap(8.w),
                            Text(_isPrivate ? "Private" : "Public"),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Text(widget.goal.description),
            Gap(8.h),
            Row(
              children: [
                Icon(Icons.date_range),
                Gap(8.w),
                Expanded(
                  child: Text(
                    DateFormat(
                      'yyyy-MM-dd',
                    ).format(widget.goal.createdAt.toDate()),
                  ),
                ),
              ],
            ),
            Gap(8.h),
            ExpansionTile(
              title: Text(
                strings.keyAchievements,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              initiallyExpanded: _isExpanded,
              onExpansionChanged: (expanded) async {
                setState(() => _isExpanded = expanded);
                if (expanded && _achievements.isEmpty) {
                  await _loadAchievements();
                }
              },
              children: [
                if (_isLoadingAchievements)
                  const LoadingWidget()
                else if (_achievements.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      strings.noAchievementsYet,
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  ..._achievements.map((achievement) {
                    return ListTile(
                      title: Text(achievement.title),
                      trailing: GestureDetector(
                        onTap: () => _toggleAchievement(achievement),
                        child: Icon(
                          achievement.isDone
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: achievement.isDone
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      ),
                    );
                  }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
