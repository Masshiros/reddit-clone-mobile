import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/common/error-text.dart';
import 'package:reddit_mobile/core/common/loading.dart';
import 'package:reddit_mobile/core/common/post-card.dart';
import 'package:reddit_mobile/features/auth/controller/auth.controller.dart';
import 'package:reddit_mobile/features/community/controller/community.controller.dart';
import 'package:reddit_mobile/features/posts/controller/post.controller.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;

    if (!isGuest) {
      return ref.watch(getUserCommunitiesProvider).when(
            data: (communities) =>
                ref.watch(userPostsProvider(communities)).when(
                      data: (data) {
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final post = data[index];
                            return PostCard(post: post);
                          },
                        );
                      },
                      error: (error, stackTrace) {
                        return ErrorText(
                          error: error.toString(),
                        );
                      },
                      loading: () => const Loading(),
                    ),
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loading(),
          );
    }
    return Scaffold();
  }
}
