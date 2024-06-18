import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/common/error-text.dart';
import 'package:reddit_mobile/core/common/loading.dart';
import 'package:reddit_mobile/features/community/controller/community.controller.dart';
import 'package:routemaster/routemaster.dart';

class CommunityDrawer extends ConsumerWidget {
  const CommunityDrawer({super.key});
  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.create),
              title: const Text("Create new community"),
              onTap: () => navigateToCreateCommunity(context),
            ),
            ref.watch(getUserCommunitiesProvider).when(
                data: (communities) {
                  // print(communities);
                  return Expanded(
                    child: ListView.builder(
                        itemCount: communities.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(communities[index].avatar),
                            ),
                            title: Text("r/${communities[index].name}"),
                          );
                        }),
                  );
                },
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => const Loading()),
          ],
        ),
      ),
    );
  }
}
