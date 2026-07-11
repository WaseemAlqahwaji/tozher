import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_login_cubit.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_builder.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_listner.dart';
import 'package:tozher/features/interests/domain/entity/interest.dart';
import 'package:tozher/features/interests/domain/params/interests_user_add_params.dart';
import 'package:tozher/features/interests/presentation/cubit/interest_get_cubit.dart';
import 'package:tozher/features/interests/presentation/cubit/interests_user_add_cubit.dart';
import 'package:tozher/injection.dart';
import 'package:tozher/routing/route_paths.dart';
import 'package:tozher/theme/app_colors.dart';

class InterestsUserAddPage extends StatefulWidget {
  final bool isOnboarding;

  const InterestsUserAddPage({super.key, this.isOnboarding = false});

  @override
  State<InterestsUserAddPage> createState() => _InterestsUserAddPageState();
}

class _InterestsUserAddPageState extends State<InterestsUserAddPage> {
  late final InterestGetCubit _allInterestsCubit;
  late final InterestsUserAddCubit _addCubit;

  /// Collects the IDs the user has checked.
  late final Set<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _allInterestsCubit = getIt<InterestGetCubit>();
    _addCubit = getIt<InterestsUserAddCubit>();

    // Read the user's existing interest IDs directly from the already-loaded
    // AuthLoginCubit state — no async loading, no race conditions.
    final existingIds = getIt<AuthLoginCubit>().state.item?.interestIds;
    _selectedIds = (existingIds != null) ? Set<String>.from(existingIds) : {};

    _allInterestsCubit.getInterests();
  }

  void _toggleInterest(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _save() {
    final loginCubit = getIt<AuthLoginCubit>();
    final uid = loginCubit.state.item?.uid;
    if (uid == null) return;

    _addCubit.addUserInterests(
      InterestsUserAddParams(uid: uid, interestsIds: _selectedIds.toList()),
    );

    // Update the in-memory user model so the onboarding check sees the change
    loginCubit.state.item?.interestIds = _selectedIds.toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Interests'), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _save,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Save Interests'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
      ),
      body: ReusableBlocBuilder<InterestGetCubit, List<Interest>>(
        cubit: _allInterestsCubit,
        onRetry: () => _allInterestsCubit.getInterests(),
        builder: (context, state) {
          final allInterests = state.item ?? [];

          if (allInterests.isEmpty) {
            return Center(
              child: Text(
                'No interests available',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }

          return ReusableBlocListener<InterestsUserAddCubit, void>(
            cubit: _addCubit,
            onSuccess: (_) {
              if (widget.isOnboarding) {
                context.pushReplacement(RoutePaths.home);
              } else {
                if (context.canPop()) context.pop();
              }
            },
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              itemCount: allInterests.length,
              separatorBuilder: (_, __) => Gap(4.h),
              itemBuilder: (context, index) {
                final interest = allInterests[index];
                final isSelected = _selectedIds.contains(interest.id);

                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.4)
                          : AppColors.surfaceSecondary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: CheckboxListTile(
                    value: isSelected,
                    onChanged: (_) => _toggleInterest(interest.id),
                    activeColor: AppColors.primary,
                    checkColor: AppColors.textOnPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    title: Text(
                      interest.name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: interest.icon.isNotEmpty
                        ? Text(
                            interest.icon,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          )
                        : null,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
