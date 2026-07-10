import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';
import 'package:tozher/features/goals/presentation/widgets/goal_item.dart';

class GoalList extends StatefulWidget {
  final List<Goal> goals;
  const GoalList({super.key, required this.goals});

  @override
  State<GoalList> createState() => _GoalListState();
}

class _GoalListState extends State<GoalList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) =>
          GoalItem( goal: widget.goals[index]),
      separatorBuilder: (context, index) => Gap(16.h),
      itemCount: widget.goals.length,
    );
  }
}
