import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_login_cubit.dart';
import 'package:tozher/features/core/constants/app_constants.dart';
import 'package:tozher/features/core/helpers/validation_helper.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_listner.dart';
import 'package:tozher/features/goals/domain/params/achievement_add_params.dart';
import 'package:tozher/features/goals/domain/params/goal_add_params.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_add_cubit.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_get_cubit.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';

class GoalAddPage extends StatefulWidget {
  final GoalGetCubit goalGetCubit;
  const GoalAddPage({super.key, required this.goalGetCubit});

  @override
  State<GoalAddPage> createState() => GoalAddPageState();
}

class GoalAddPageState extends State<GoalAddPage> {
  late TextEditingController goalNameController;
  late TextEditingController descriptionConroller;
  late TextEditingController dateController;
  late TextEditingController remiderDateConroller;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool isPublic = true;
  List<TextEditingController> achievementControllers = [];
  final addGoalCubit = getIt<GoalAddCubit>();

  @override
  void initState() {
    goalNameController = TextEditingController();
    descriptionConroller = TextEditingController();
    dateController = TextEditingController();
    remiderDateConroller = TextEditingController();
    achievementControllers.add(TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    goalNameController.dispose();
    descriptionConroller.dispose();
    dateController.dispose();
    remiderDateConroller.dispose();
    for (final c in achievementControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.appName)),
      body: ReusableBlocListener<GoalAddCubit, void>(
        cubit: addGoalCubit,
        onSuccess: (value) {
          widget.goalGetCubit.getGoals(
            getIt<AuthLoginCubit>().state.item!.uid!,
          );
          context.pop();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppConstants.pagePadding),
            child: Form(
              key: key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.newGoal,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(strings.newGoalSubtitle),
                  Gap(16.h),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(strings.goalName),
                          Gap(4.h),
                          TextFormField(
                            controller: goalNameController,
                            decoration: InputDecoration(
                              hintText: strings.goalNameHint,
                            ),
                            validator: (value) {
                              if (ValidationHelper.isNullOrEmpty(value)) {
                                return strings.fieldRequired;
                              }
                              return null;
                            },
                          ),
                          Gap(8.h),

                          Text(strings.goalDescription),
                          Gap(4.h),
                          TextFormField(
                            controller: descriptionConroller,
                            decoration: InputDecoration(
                              hintText: strings.goalDescriptionHint,
                            ),
                            validator: (value) {
                              if (ValidationHelper.isNullOrEmpty(value)) {
                                return strings.fieldRequired;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                              Gap(8.w),
                              Expanded(
                                child: Text(
                                  strings.keyAchievements,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ],
                          ),
                          Gap(8.w),

                          Text(strings.goalDate),
                          Gap(4.h),
                          TextFormField(
                            controller: dateController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.date_range_outlined),
                              hintText: strings.goalDateHint,
                            ),
                            validator: (value) {
                              if (ValidationHelper.isNullOrEmpty(value)) {
                                return strings.fieldRequired;
                              }
                              return null;
                            },
                            readOnly: true,
                            onTap: () async {
                              final DateTime? value = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2038),
                              );

                              if (value != null) {
                                dateController.text = DateFormat(
                                  'yyyy-MM-dd',
                                ).format(value);
                                remiderDateConroller.text = "";
                              }
                            },
                          ),
                          Gap(8.h),

                          Text(strings.reminderDate),
                          Gap(4.h),
                          TextFormField(
                            controller: remiderDateConroller,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.date_range_outlined),
                              hintText: strings.reminderDateHint,
                            ),
                            validator: (value) {
                              if (ValidationHelper.isNullOrEmpty(value)) {
                                return strings.fieldRequired;
                              }
                              return null;
                            },
                            readOnly: true,
                            onTap: () async {
                              if (dateController.text.isNotEmpty) {
                                final DateTime? value = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse(dateController.text),
                                );

                                if (value != null) {
                                  remiderDateConroller.text = DateFormat(
                                    'yyyy-MM-dd',
                                  ).format(value);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.group_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Gap(8.w),
                                    Expanded(
                                      child: Text(
                                        strings.publicGoal,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(strings.publicGoalDescription),
                              ],
                            ),
                          ),

                          Gap(4.w),
                          Switch(
                            value: isPublic,
                            onChanged: (value) {
                              isPublic = !isPublic;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  // here implement Achievements List
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.stars_rounded,
                                color: Theme.of(context).primaryColor,
                              ),
                              Gap(8.w),
                              Expanded(
                                child: Text(
                                  strings.keyAchievements,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ],
                          ),
                          Gap(8.h),
                          ...achievementControllers.asMap().entries.map((
                            entry,
                          ) {
                            final index = entry.key;
                            final controller = entry.value;
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller,
                                      decoration: InputDecoration(
                                        hintText: strings.achievementHint(
                                          index + 1,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (ValidationHelper.isNullOrEmpty(
                                          value,
                                        )) {
                                          return strings.fieldRequired;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  if (achievementControllers.length > 1)
                                    IconButton(
                                      icon: Icon(Icons.remove_circle_outline),
                                      color: Colors.red,
                                      onPressed: () {
                                        controller.dispose();
                                        achievementControllers.removeAt(index);
                                        setState(() {});
                                      },
                                    ),
                                ],
                              ),
                            );
                          }),
                          Gap(8.h),
                          TextButton.icon(
                            onPressed: () {
                              achievementControllers.add(
                                TextEditingController(),
                              );
                              setState(() {});
                            },
                            icon: Icon(Icons.add_circle_outline),
                            label: Text(strings.addAchievement),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(16.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          addGoalCubit.addGoal(
                            GoalAddParams(
                              userId: getIt<AuthLoginCubit>().state.item!.uid!,
                              name: goalNameController.text,
                              description: descriptionConroller.text,
                              date: DateTime.parse(dateController.text),
                              reminderDate: DateTime.parse(
                                remiderDateConroller.text,
                              ),
                              status: "active",
                              isPrivate: !isPublic,
                              achievementAddParams: AchievementAddParams(
                                names: achievementControllers
                                    .map((e) => e.text)
                                    .toList(),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(strings.createGoal),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
