import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';
import 'package:tozher/features/goals/presentation/widgets/goal_item.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/theme/app_colors.dart';

class GoalList extends StatefulWidget {
  final List<Goal> goals;
  const GoalList({super.key, required this.goals});

  @override
  State<GoalList> createState() => _GoalListState();
}

class _GoalListState extends State<GoalList> {
  @override
  Widget build(BuildContext context) {
    if (widget.goals.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => GoalItem(goal: widget.goals[index]),
      separatorBuilder: (context, index) => Gap(16.h),
      itemCount: widget.goals.length,
    );
  }

  Widget _buildEmptyState() {
    final strings = S.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.flag_outlined,
            size: 64.sp,
            color: AppColors.textSecondary.withValues(alpha: 0.4),
          ),
          Gap(12.h),
          Text(
            strings.noGoalsYet,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(4.h),
          Text(
            strings.noGoalsYetSubtitle,
            style: TextStyle(
              color: AppColors.textSecondary.withValues(alpha: 0.6),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
