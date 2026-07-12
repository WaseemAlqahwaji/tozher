import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tozher/features/auth/data/model/user_model.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_login_cubit.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_logout_cubit.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_builder.dart';
import 'package:tozher/features/goals/domain/entity/goal.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_get_cubit.dart';
import 'package:tozher/features/interests/domain/entity/interest.dart';
import 'package:tozher/features/interests/presentation/cubit/interests_get_user_cubit.dart';
import 'package:tozher/features/posts/domain/entity/post.dart';
import 'package:tozher/features/posts/presentation/cubit/post_user_get_cubit.dart';
import 'package:tozher/features/posts/presentation/cubit/profile_support_stats_cubit.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';
import 'package:tozher/routing/route_names.dart';
import 'package:tozher/theme/app_colors.dart';

class AuthProfilePage extends StatefulWidget {
  const AuthProfilePage({super.key});

  @override
  State<AuthProfilePage> createState() => AuthProfilePageState();
}

class AuthProfilePageState extends State<AuthProfilePage>
    with SingleTickerProviderStateMixin {
  late final AuthLoginCubit _authLoginCubit;
  late final AuthLogoutCubit _authLogoutCubit;
  late final InterestsGetUserCubit _interestsCubit;
  late final PostUserGetCubit _postGetCubit;
  late final GoalGetCubit _goalGetCubit;
  late final ProfileSupportStatsCubit _statsCubit;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _authLoginCubit = getIt<AuthLoginCubit>();
    _authLogoutCubit = getIt<AuthLogoutCubit>();
    _interestsCubit = getIt<InterestsGetUserCubit>();
    _postGetCubit = getIt<PostUserGetCubit>();
    _goalGetCubit = getIt<GoalGetCubit>();
    _statsCubit = getIt<ProfileSupportStatsCubit>();
    _tabController = TabController(length: 2, vsync: this);

    _loadData();
  }

  void _loadData() {
    final user = _authLoginCubit.state.item;
    if (user?.uid != null) {
      _authLoginCubit.refreshUser(user!.uid!);
      _interestsCubit.getInterests(user.uid!);
      _postGetCubit.getPostsByUserId(user.uid!);
      _goalGetCubit.getGoals(user.uid!);
      _statsCubit.loadStats(user.uid!);
    }
  }

  /// Called externally (e.g. from HomeLayout) to refresh data
  void reloadData() => _loadData();

  void _showLogoutDialog(BuildContext context) {
    final strings = S.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(strings.logoutTitle),
        content: Text(strings.logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(strings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _authLogoutCubit.logout();
            },
            child: Text(
              strings.logout,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReusableBlocBuilder<AuthLoginCubit, UserModel>(
      cubit: _authLoginCubit,
      onRetry: _loadData,
      builder: (context, state) {
        final user = state.item;
        final strings = S.of(context);
        if (user == null) {
          return Center(child: Text(strings.noUserData));
        }
        return _buildProfileContent(user);
      },
    );
  }

  Widget _buildProfileContent(UserModel user) {
    return BlocListener<AuthLogoutCubit, BaseState>(
      bloc: _authLogoutCubit,
      listener: (context, state) {
        if (state.isSuccess == true) {
          context.goNamed(RouteNames.login);
        }
      },
      child: RefreshIndicator(
        onRefresh: () async => _loadData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Gap(20.h),
              _buildProfileHeader(user),
              Gap(20.h),
              _buildStatsRow(user),
              Gap(20.h),
              _buildInterestsSection(),
              Gap(16.h),
              _buildTabBar(),
              Gap(12.h),
              _buildTabContent(user),
              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Profile Header – avatar, name, handle, edit button
  // ---------------------------------------------------------------------------
  Widget _buildProfileHeader(UserModel user) {
    final strings = S.of(context);
    final fullName = user.fullname ?? 'User';
    final username = user.username ?? 'user';
    final age = user.age;

    return Column(
      children: [
        // Avatar
        CircleAvatar(
          radius: 50.r,
          backgroundColor: AppColors.primary.withValues(alpha: 0.15),
          child: Text(
            fullName.isNotEmpty ? fullName[0].toUpperCase() : '?',
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
        Gap(12.h),
        // Name & Age
        Text(
          age != null ? '$fullName, $age' : fullName,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        Gap(4.h),
        // Username handle
        Text(
          '@$username',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        Gap(16.h),
        // Edit Profile + Logout buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 140.w,
              child: OutlinedButton(
                onPressed: () {
                  context.pushNamed(
                    RouteNames.completeProfile,
                    extra: user.uid,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  strings.editProfile,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Gap(10.w),
            SizedBox(
              width: 140.w,
              child: OutlinedButton.icon(
                onPressed: () => _showLogoutDialog(context),
                icon: Icon(Icons.logout_rounded, size: 18.sp),
                label: Text(
                  strings.logout,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(10.h),
        // Change Interests button
        SizedBox(
          width: 290.w,
          child: OutlinedButton.icon(
            onPressed: () {
              context.pushNamed(RouteNames.addUserInterests);
            },
            icon: Icon(Icons.interests_rounded, size: 18.sp),
            label: Text(
              'Change Interests',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.accent,
              side: const BorderSide(color: AppColors.accent),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Stats Cards – Points, Supports, Supporting
  // ---------------------------------------------------------------------------
  Widget _buildStatsRow(UserModel user) {
    final strings = S.of(context);
    return ReusableBlocBuilder<ProfileSupportStatsCubit, ProfileSupportStats>(
      cubit: _statsCubit,
      onRetry: () => _statsCubit.loadStats(user.uid!),
      builder: (context, state) {
        final stats = state.item;

        return Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: strings.points,
                value: '${user.points ?? 0}',
                icon: Icons.stars_rounded,
                color: AppColors.primary,
              ),
            ),
            Gap(10.w),
            Expanded(
              child: _buildStatCard(
                title: strings.supports,
                value: '${stats?.supportsReceived ?? 0}',
                icon: Icons.favorite_rounded,
                color: AppColors.accent,
              ),
            ),
            Gap(10.w),
            Expanded(
              child: _buildStatCard(
                title: strings.supporting,
                value: '${stats?.supportingCount ?? 0}',
                icon: Icons.volunteer_activism_rounded,
                color: AppColors.success,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22.sp),
          Gap(6.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Gap(2.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Interests Section
  // ---------------------------------------------------------------------------
  Widget _buildInterestsSection() {
    final strings = S.of(context);
    return ReusableBlocBuilder<InterestsGetUserCubit, List<Interest>>(
      cubit: _interestsCubit,
      onRetry: () {
        final user = _authLoginCubit.state.item;
        if (user?.uid != null) {
          _interestsCubit.getInterests(user!.uid!);
        }
      },
      builder: (context, state) {
        final interests = state.item;
        if (interests == null || interests.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              strings.interests,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            Gap(8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: interests.map((interest) {
                return Chip(
                  label: Text(
                    '#${interest.name}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: AppColors.accent.withValues(alpha: 0.2),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Tab Bar – Posts | Public Goals
  // ---------------------------------------------------------------------------
  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.textOnPrimary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        dividerColor: Colors.transparent,
        tabs: [
          Tab(text: S.of(context).posts),
          Tab(text: S.of(context).publicGoals),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Tab Content
  // ---------------------------------------------------------------------------
  Widget _buildTabContent(UserModel user) {
    return SizedBox(
      height: 400.h,
      child: TabBarView(
        controller: _tabController,
        children: [_buildPostsTab(user), _buildGoalsTab(user)],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Posts Tab – Grid of post images
  // ---------------------------------------------------------------------------
  Widget _buildPostsTab(UserModel user) {
    final strings = S.of(context);
    return ReusableBlocBuilder<PostUserGetCubit, List<Post>>(
      cubit: _postGetCubit,
      onRetry: _loadData,
      builder: (context, state) {
        final userPosts = state.item ?? [];

        if (userPosts.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.photo_library_outlined,
                  size: 48.sp,
                  color: AppColors.textSecondary.withValues(alpha: 0.4),
                ),
                Gap(8.h),
                Text(
                  strings.noPostsYet,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 6.w,
            mainAxisSpacing: 6.h,
            childAspectRatio: 1,
          ),
          itemCount: userPosts.length,
          itemBuilder: (context, index) {
            final post = userPosts[index];
            return _buildPostGridTile(post);
          },
        );
      },
    );
  }

  Widget _buildPostGridTile(Post post) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: post.photos.isNotEmpty
          ? Image.network(
              post.photos.first,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _buildPlaceholderTile(),
            )
          : _buildPlaceholderTile(),
    );
  }

  Widget _buildPlaceholderTile() {
    return Container(
      color: AppColors.surfaceSecondary.withValues(alpha: 0.3),
      child: Icon(
        Icons.image_outlined,
        color: AppColors.textSecondary.withValues(alpha: 0.4),
        size: 28.sp,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Goals Tab – List of public goals
  // ---------------------------------------------------------------------------
  Widget _buildGoalsTab(UserModel user) {
    final strings = S.of(context);
    return ReusableBlocBuilder<GoalGetCubit, List<Goal>>(
      cubit: _goalGetCubit,
      onRetry: _loadData,
      builder: (context, state) {
        final allGoals = state.item ?? [];
        final publicGoals = allGoals
            .where((g) => g.userId == user.uid && !g.isPrivate)
            .toList();

        if (publicGoals.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.flag_outlined,
                  size: 48.sp,
                  color: AppColors.textSecondary.withValues(alpha: 0.4),
                ),
                Gap(8.h),
                Text(
                  strings.noPublicGoalsYet,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: publicGoals.length,
          separatorBuilder: (_, _) => Gap(8.h),
          itemBuilder: (context, index) {
            final goal = publicGoals[index];
            return _buildGoalTile(goal);
          },
        );
      },
    );
  }

  Widget _buildGoalTile(Goal goal) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.surfaceSecondary.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.flag_rounded,
              color: AppColors.primary,
              size: 20.sp,
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(2.h),
                Text(
                  goal.description,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: _goalStatusColor(goal.status).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              goal.status,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: _goalStatusColor(goal.status),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _goalStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppColors.success;
      case 'in progress':
        return AppColors.primary;
      case 'pending':
        return Colors.orange;
      default:
        return AppColors.textSecondary;
    }
  }
}
