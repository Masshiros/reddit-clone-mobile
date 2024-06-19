import 'package:flutter/material.dart';
import 'package:reddit_mobile/theme/palette.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends StatelessWidget {
  final String name;
  const ModToolsScreen(this.name, {super.key});
  void navigateToEditCommunity(BuildContext context, String name) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Mod Tools",
            style: TextStyle(
              color: Palette.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.add_moderator),
              title: const Text("Add Moderators"),
              onTap: () => navigateToEditCommunity(context, name),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit community"),
              onTap: () {},
            )
          ],
        ));
  }
}
