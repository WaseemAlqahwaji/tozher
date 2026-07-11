import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/core/presentation/widgets/loading_widget.dart';
import 'package:tozher/features/posts/domain/entity/post.dart';
import 'package:tozher/features/posts/presentation/cubit/post_get_cubit.dart';
import 'package:tozher/features/posts/presentation/widgets/post_item.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';

class PostPage extends StatefulWidget {
  final String? filterInterestName;
  final List<String>? userInterestNames;

  const PostPage({super.key, this.filterInterestName, this.userInterestNames});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final postGetCubit = getIt<PostGetCubit>();

  @override
  void initState() {
    super.initState();
    postGetCubit.getPosts();
  }

  List<Post> _filterPosts(List<Post> posts) {
    if (widget.filterInterestName == null) return posts;

    // "For Me" – filter by user's interests
    if (widget.filterInterestName == '__for_me__') {
      final userInterests = widget.userInterestNames ?? [];
      if (userInterests.isEmpty) return posts;
      return posts
          .where(
            (p) =>
                p.interestName != null &&
                userInterests.contains(p.interestName),
          )
          .toList();
    }

    // Filter by specific interest
    return posts
        .where((p) => p.interestName == widget.filterInterestName)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);

    return BlocBuilder<PostGetCubit, BaseState<List<Post>>>(
      bloc: postGetCubit,
      builder: (context, state) {
        if (state.isInProgress) {
          return const Center(child: LoadingWidget());
        }

        if (state.isFailure) {
          return Center(child: Text(strings.errorHappend));
        }

        final posts = _filterPosts(state.item ?? []);

        if (posts.isEmpty) {
          return Center(child: Text(strings.noPostsYet));
        }

        return RefreshIndicator(
          onRefresh: () async => postGetCubit.getPosts(),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: posts.length,
            itemBuilder: (context, index) => PostItem(post: posts[index]),
          ),
        );
      },
    );
  }
}
