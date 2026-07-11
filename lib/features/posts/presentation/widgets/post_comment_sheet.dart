import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_login_cubit.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/posts/domain/entity/post_comment.dart';
import 'package:tozher/features/posts/domain/params/post_comment_add_params.dart';
import 'package:tozher/features/posts/presentation/cubit/post_comment_add_cubit.dart';
import 'package:tozher/features/posts/presentation/cubit/post_comments_get_cubit.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';
import 'package:tozher/theme/app_colors.dart';

class PostCommentSheet extends StatefulWidget {
  final String postId;

  const PostCommentSheet({super.key, required this.postId});

  @override
  State<PostCommentSheet> createState() => _PostCommentSheetState();
}

class _PostCommentSheetState extends State<PostCommentSheet> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final PostCommentAddCubit _addCubit;
  late final PostCommentsGetCubit _getCubit;

  @override
  void initState() {
    super.initState();
    _addCubit = getIt<PostCommentAddCubit>();
    _getCubit = getIt<PostCommentsGetCubit>();
    _getCubit.getComments(widget.postId);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _submitComment() {
    if (!_formKey.currentState!.validate()) return;

    final userId = getIt<AuthLoginCubit>().state.item!.uid!;
    final params = PostCommentAddParams(
      userId: userId,
      postId: widget.postId,
      text: _textController.text.trim(),
    );

    _addCubit.addComment(params);
    _textController.clear();

    // Refresh comments after adding
    _getCubit.getComments(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              // Drag handle
              Container(
                margin: EdgeInsets.only(top: 10.h, bottom: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Text(
                      strings.comments,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),

              Gap(8.h),

              // Comments list
              Expanded(
                child:
                    BlocBuilder<
                      PostCommentsGetCubit,
                      BaseState<List<PostComment>>
                    >(
                      bloc: _getCubit,
                      builder: (context, state) {
                        return _buildBody(scrollController, state);
                      },
                    ),
              ),

              // Divider + Input
              Divider(height: 1.h, color: AppColors.surfaceSecondary),
              _buildCommentInput(theme),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(
    ScrollController scrollController,
    BaseState<List<PostComment>> state,
  ) {
    if (state.isInProgress) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.isFailure && state.failure != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 40.sp, color: AppColors.error),
            Gap(8.h),
            Text(
              state.failure!.message,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            Gap(8.h),
            TextButton(
              onPressed: () => _getCubit.getComments(widget.postId),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final comments = state.item ?? [];

    if (comments.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 48.sp,
              color: AppColors.textSecondary.withValues(alpha: 0.4),
            ),
            Gap(8.h),
            Text(
              S.of(context).noCommentsYet,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: comments.length,
      separatorBuilder: (_, _) => Gap(8.h),
      itemBuilder: (context, index) {
        final comment = comments[index];
        return _CommentBubble(comment: comment);
      },
    );
  }

  Widget _buildCommentInput(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _textController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: S.of(context).writeComment,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  isDense: true,
                ),
                textInputAction: TextInputAction.send,
                onFieldSubmitted: (_) => _submitComment(),
              ),
            ),
            Gap(8.w),
            IconButton(
              icon: Icon(Icons.send_rounded, color: AppColors.primary),
              onPressed: _submitComment,
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentBubble extends StatelessWidget {
  final PostComment comment;
  const _CommentBubble({required this.comment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentUserId = getIt<AuthLoginCubit>().state.item?.uid;
    final isMine = currentUserId == comment.userId;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.8.sw),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isMine
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.surfaceSecondary.withValues(alpha: 0.3),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMine ? const Radius.circular(16) : Radius.zero,
            bottomRight: isMine ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Text(comment.text, style: theme.textTheme.bodyMedium),
      ),
    );
  }
}
