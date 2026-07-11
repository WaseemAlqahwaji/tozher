import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_login_cubit.dart';
import 'package:tozher/features/core/constants/app_constants.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_builder.dart';
import 'package:tozher/features/interests/domain/entity/interest.dart';
import 'package:tozher/features/interests/presentation/cubit/interest_get_cubit.dart';
import 'package:tozher/features/interests/presentation/cubit/interests_get_user_cubit.dart';
import 'package:tozher/features/posts/presentation/pages/post_page.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';
import 'package:tozher/routing/route_paths.dart';
import 'package:tozher/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _interestGetCubit = getIt<InterestGetCubit>();
  final _userInterestsCubit = getIt<InterestsGetUserCubit>();

  /// null = "All", "__for_me__" = "For Me", otherwise = interest name
  String? _selectedFilter;
  List<Interest> _allInterests = [];
  List<Interest> _userInterests = [];

  @override
  void initState() {
    super.initState();
    _interestGetCubit.getInterests();
    final uid = getIt<AuthLoginCubit>().state.item?.uid;
    if (uid != null) {
      _userInterestsCubit.getInterests(uid);
    }
  }

  void _onFilterSelected(String? filter) {
    setState(() => _selectedFilter = filter);
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RoutePaths.addPost),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.pagePadding),
          child: Column(
            children: [
              // Interest chips
              ReusableBlocBuilder<InterestGetCubit, List<Interest>>(
                cubit: _interestGetCubit,
                onRetry: _interestGetCubit.getInterests,
                builder: (context, state) {
                  _allInterests = state.item ?? [];
                  return _buildChipsRow(strings, theme);
                },
              ),
              Gap(8.h),
              // User interests loading (background)
              ReusableBlocBuilder<InterestsGetUserCubit, List<Interest>>(
                cubit: _userInterestsCubit,
                onRetry: () {
                  final uid = getIt<AuthLoginCubit>().state.item?.uid;
                  if (uid != null) _userInterestsCubit.getInterests(uid);
                },
                builder: (context, state) {
                  _userInterests = state.item ?? [];
                  return const SizedBox.shrink();
                },
              ),
              // Posts with filter
              PostPage(
                filterInterestName: _selectedFilter,
                userInterestNames: _selectedFilter == '__for_me__'
                    ? _userInterests.map((i) => i.name).toList()
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChipsRow(S strings, ThemeData theme) {
    final chips = <Widget>[];

    // "All" chip
    chips.add(
      _buildChip(
        label: strings.all,
        isSelected: _selectedFilter == null,
        onTap: () => _onFilterSelected(null),
        theme: theme,
      ),
    );

    // "For Me" chip
    chips.add(Gap(8.w));
    chips.add(
      _buildChip(
        label: strings.forMe,
        isSelected: _selectedFilter == '__for_me__',
        onTap: () => _onFilterSelected('__for_me__'),
        theme: theme,
      ),
    );

    // Interest chips
    for (final interest in _allInterests) {
      chips.add(Gap(8.w));
      chips.add(
        _buildChip(
          label: '${interest.icon} ${interest.name}',
          isSelected: _selectedFilter == interest.name,
          onTap: () => _onFilterSelected(interest.name),
          theme: theme,
        ),
      );
    }

    return SizedBox(
      height: 50.h,
      child: ListView(scrollDirection: Axis.horizontal, children: chips),
    );
  }

  Widget _buildChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return ChoiceChip(
      selected: isSelected,
      onSelected: (_) => onTap(),
      label: Text(label),
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.textOnPrimary : AppColors.textPrimary,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: AppColors.surfaceSecondary.withValues(alpha: 0.3),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
