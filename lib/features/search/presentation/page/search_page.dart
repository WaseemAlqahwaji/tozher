import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tozher/features/auth/data/model/user_model.dart';
import 'package:tozher/features/auth/presentation/cubit/user_search_cubit.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/posts/domain/entity/post.dart';
import 'package:tozher/features/posts/presentation/cubit/post_get_cubit.dart';
import 'package:tozher/features/posts/presentation/widgets/post_item.dart';
import 'package:tozher/injection.dart';
import 'package:tozher/theme/app_colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  final _postGetCubit = getIt<PostGetCubit>();
  final _userSearchCubit = getIt<UserSearchCubit>();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _postGetCubit.getPosts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (_tabController.index == 0) {
      // Posts tab – re-fetch all and filter client-side
      _postGetCubit.getPosts();
    } else {
      _userSearchCubit.search(query);
    }
  }

  List<Post> _filterPosts(List<Post> posts, String query) {
    if (query.trim().isEmpty) return posts;
    final q = query.toLowerCase();
    return posts.where((p) => p.title.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearch,
            decoration: InputDecoration(
              hintText: 'Search for goals, friends, or inspiration...',
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.textSecondary,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        _searchController.clear();
                        _onSearch('');
                      },
                    )
                  : null,
              filled: true,
              fillColor: AppColors.surfaceSecondary.withValues(alpha: 0.3),
              contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Tab bar
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.surfaceSecondary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TabBar(
            controller: _tabController,
            onTap: (_) => _onSearch(_searchController.text),
            indicator: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: AppColors.textOnPrimary,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'Posts'),
              Tab(text: 'Users'),
            ],
          ),
        ),

        Gap(10.h),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [_buildPostsTab(), _buildUsersTab()],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Posts Tab
  // ---------------------------------------------------------------------------
  Widget _buildPostsTab() {
    return BlocBuilder<PostGetCubit, BaseState<List<Post>>>(
      bloc: _postGetCubit,
      builder: (context, state) {
        if (state.isInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        final allPosts = state.item ?? [];
        final posts = _filterPosts(allPosts, _searchController.text);

        if (posts.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search_off,
                  size: 48.sp,
                  color: AppColors.textSecondary.withValues(alpha: 0.4),
                ),
                Gap(8.h),
                Text(
                  'No posts found',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.only(bottom: 16.h),
          itemCount: posts.length,
          itemBuilder: (_, i) => PostItem(post: posts[i]),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Users Tab
  // ---------------------------------------------------------------------------
  Widget _buildUsersTab() {
    return BlocBuilder<UserSearchCubit, BaseState<List<UserModel>>>(
      bloc: _userSearchCubit,
      builder: (context, state) {
        if (state.isInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        final users = state.item ?? [];
        final query = _searchController.text.trim();

        if (query.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_search,
                  size: 48.sp,
                  color: AppColors.textSecondary.withValues(alpha: 0.4),
                ),
                Gap(8.h),
                Text(
                  'Search for users',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        if (users.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search_off,
                  size: 48.sp,
                  color: AppColors.textSecondary.withValues(alpha: 0.4),
                ),
                Gap(8.h),
                Text(
                  'No users found',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount: users.length,
          separatorBuilder: (_, _) => Gap(8.h),
          itemBuilder: (_, i) => _buildUserTile(users[i]),
        );
      },
    );
  }

  Widget _buildUserTile(UserModel user) {
    final theme = Theme.of(context);
    final fullName = user.fullname ?? 'User';
    final username = user.username ?? '';

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
          CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            child: Text(
              fullName.isNotEmpty ? fullName[0].toUpperCase() : '?',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (username.isNotEmpty)
                  Text(
                    '@$username',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13.sp,
                    ),
                  ),
              ],
            ),
          ),
          if (user.interestIds != null && user.interestIds!.isNotEmpty)
            Text(
              '${user.interestIds!.length} interests',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}
