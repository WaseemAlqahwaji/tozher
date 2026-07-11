import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_login_cubit.dart';
import 'package:tozher/features/core/constants/app_constants.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_builder.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_get_cubit.dart';
import 'package:tozher/features/goals/presentation/widgets/goal_list.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';
import 'package:tozher/routing/route_paths.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => GoalsPageState();
}

class GoalsPageState extends State<GoalsPage> {
  final getGoalsCubit = getIt<GoalGetCubit>();

  @override
  void initState() {
    getGoalsCubit.getGoals(getIt<AuthLoginCubit>().state.item!.uid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.pagePadding),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(strings.trackProgress),
                        Text(
                          strings.myGoals,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push(RoutePaths.addGoal, extra: getGoalsCubit);
                    },
                    child: Text(strings.addGoal),
                  ),
                ],
              ),
              Gap(16.h),
              ReusableBlocBuilder<GoalGetCubit, List<Goal>>(
                onRetry: () {
                  getGoalsCubit.getGoals(
                    getIt<AuthLoginCubit>().state.item!.uid!,
                  );
                },
                cubit: getGoalsCubit,
                builder: (context, state) {
                  return GoalList(goals: state.item!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
