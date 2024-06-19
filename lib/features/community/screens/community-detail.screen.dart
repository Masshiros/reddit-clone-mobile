import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/common/error-text.dart';
import 'package:reddit_mobile/core/common/loading.dart';
import 'package:reddit_mobile/features/auth/controller/auth.controller.dart';
import 'package:reddit_mobile/features/community/controller/community.controller.dart';
import 'package:routemaster/routemaster.dart';

class CommunityDetailScreen extends ConsumerWidget {
  final String name;
  const CommunityDetailScreen(this.name, {super.key});

  void navigateToModToolsScreen(BuildContext context, String name) {
    Routemaster.of(context).push('/mod-tools/${name}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final uid = user.uid;
    return Scaffold(
      body: ref.watch(getCommunityByNameProvider(name)).when(
            data: (community) {
              return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 150,
                        floating: true,
                        snap: true,
                        flexibleSpace: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.network(
                                community.banner,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            Align(
                              alignment: Alignment.topLeft,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(community.avatar),
                                radius: 35,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'r/${community.name}',
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                community.mods.contains(uid)
                                    ? OutlinedButton(
                                        onPressed: () {
                                          navigateToModToolsScreen(
                                            context,
                                            community.name,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                        ),
                                        child: const Text('Mod Tools'),
                                      )
                                    : OutlinedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                        ),
                                        child: Text(
                                            community.members.contains(uid)
                                                ? 'Joined'
                                                : 'Join'),
                                      )
                              ],
                            )
                          ]),
                        ),
                      )
                    ];
                  },
                  body: const Center(
                    child: Text("Community Posts"),
                  ));
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loading(),
          ),
    );
  }
}
