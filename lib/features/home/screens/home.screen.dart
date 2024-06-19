import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/features/auth/controller/auth.controller.dart';
import 'package:reddit_mobile/features/home/delegates/search-community.delegate.dart';
import 'package:reddit_mobile/features/home/drawers/community.drawer.dart';
import 'package:reddit_mobile/features/home/drawers/profile.drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  void displayCommunityDrawer(context) {
    Scaffold.of(context).openDrawer();
  }

  void displayProfileDrawer(context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => displayCommunityDrawer(context),
            icon: const Icon(Icons.menu),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchCommunityDelegate(ref));
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(
            width: 10,
          ),
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                displayProfileDrawer(context);
              },
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
              ),
            );
          }),
        ],
        title: const Text("Home"),
        centerTitle: false,
      ),
      drawer: const CommunityDrawer(),
      endDrawer: const ProfileDrawer(),
    );
  }
}
