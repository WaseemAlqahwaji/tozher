import 'package:flutter/material.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_login_cubit.dart';
import 'package:tozher/features/core/constants/app_constants.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_builder.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_get_cubit.dart';
import 'package:tozher/features/goals/presentation/widgets/goal_list.dart';
import 'package:tozher/injection.dart';

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
                        Text("Track Progress"),
                        Text(
                          "My Goals",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("+ Add Goal")),
                ],
              ),
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
