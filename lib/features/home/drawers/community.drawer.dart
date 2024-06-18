import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityDrawer extends ConsumerStatefulWidget {
  const CommunityDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommunityDrawerState();
}

class _CommunityDrawerState extends ConsumerState<CommunityDrawer> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Drawer(
        child: Column(
          children: [
            ListTile(
              title: Text("Create new community"),
            )
          ],
        ),
      ),
    );
  }
}
