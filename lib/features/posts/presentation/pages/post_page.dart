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
  const PostPage({super.key});

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

        final posts = state.item ?? [];

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
