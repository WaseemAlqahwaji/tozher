import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_login_cubit.dart';
import 'package:tozher/features/posts/domain/entity/post.dart';
import 'package:tozher/features/posts/domain/params/post_like_params.dart';
import 'package:tozher/features/posts/domain/params/post_share_params.dart';
import 'package:tozher/features/posts/domain/params/post_support_params.dart';
import 'package:tozher/features/posts/presentation/cubit/post_like_cubit.dart';
import 'package:tozher/features/posts/presentation/cubit/post_share_cubit.dart';
import 'package:tozher/features/posts/presentation/cubit/post_support_cubit.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';

class PostItem extends StatefulWidget {
  final Post post;
  const PostItem({super.key, required this.post});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  late bool _isLiked;
  late bool _isSupported;
  late int _likeCount;
  late int _supportCount;
  late int _shareCount;

  @override
  void initState() {
    super.initState();
    _isLiked = false;
    _isSupported = false;
    _likeCount = widget.post.likeCount;
    _supportCount = widget.post.supportCount;
    _shareCount = widget.post.shareCount;
  }

  void _toggleLike() {
    final userId = getIt<AuthLoginCubit>().state.item!.uid!;
    final cubit = getIt<PostLikeCubit>();
    final params = PostLikeParams(userId: userId, postId: widget.post.id);

    if (_isLiked) {
      setState(() {
        _isLiked = false;
        _likeCount--;
      });
      cubit.unlikePost(params);
    } else {
      setState(() {
        _isLiked = true;
        _likeCount++;
      });
      cubit.likePost(params);
    }
  }

  void _toggleSupport() {
    final userId = getIt<AuthLoginCubit>().state.item!.uid!;
    final cubit = getIt<PostSupportCubit>();
    final params = PostSupportParams(userId: userId, postId: widget.post.id);

    setState(() {
      _isSupported = !_isSupported;
      _supportCount += _isSupported ? 1 : -1;
    });
    cubit.supportPost(params);
  }

  void _sharePost() {
    final userId = getIt<AuthLoginCubit>().state.item!.uid!;
    final cubit = getIt<PostShareCubit>();
    final params = PostShareParams(userId: userId, postId: widget.post.id);

    setState(() => _shareCount++);
    cubit.sharePost(params);
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final theme = Theme.of(context);
    final post = widget.post;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Avatar + Name
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: theme.primaryColor.withValues(alpha: .2),
                  child: Text(
                    post.userFullName.isNotEmpty
                        ? post.userFullName[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Gap(10.w),
                Text(
                  post.userFullName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Gap(8.h),

            // Title
            Text(post.title, style: theme.textTheme.bodyLarge),
            Gap(8.h),

            // Interest badge
            if (post.interestName != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.emoji_events,
                      size: 14.sp,
                      color: theme.primaryColor,
                    ),
                    Gap(4.w),
                    Text(
                      post.interestName!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

            // Photos
            if (post.photos.isNotEmpty) ...[
              Gap(10.h),
              SizedBox(
                height: 180.h,
                child: PageView.builder(
                  itemCount: post.photos.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImage(
                        imageUrl: post.photos[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (_, _) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (_, _, _) => Icon(
                          Icons.broken_image,
                          size: 48.sp,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            Gap(10.h),

            // Counters row
            Row(
              children: [
                _CounterLabel(icon: Icons.favorite, count: _likeCount),
                Gap(16.w),
                _CounterLabel(
                  icon: Icons.chat_bubble_outline,
                  count: post.commentCount,
                ),
                const Spacer(),
                Text(
                  '$_supportCount ${strings.supports}',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
                Gap(8.w),
                Text(
                  '$_shareCount ${strings.shares}',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
            Gap(8.h),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionButton(
                  icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : null,
                  onTap: _toggleLike,
                ),
                _ActionButton(
                  icon: Icons.chat_bubble_outline,
                  onTap: () {
                    // TODO: open comment sheet
                  },
                ),
                _ActionButton(
                  icon: _isSupported
                      ? Icons.volunteer_activism
                      : Icons.volunteer_activism_outlined,
                  color: _isSupported ? theme.primaryColor : null,
                  onTap: _toggleSupport,
                ),
                _ActionButton(icon: Icons.share_outlined, onTap: _sharePost),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CounterLabel extends StatelessWidget {
  final IconData icon;
  final int count;
  const _CounterLabel({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: Colors.grey),
        Gap(4.w),
        Text(
          '$count',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;
  const _ActionButton({required this.icon, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: Icon(icon), color: color, onPressed: onTap);
  }
}
