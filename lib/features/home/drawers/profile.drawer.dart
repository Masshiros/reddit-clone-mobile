import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/enum/enums.dart';
import 'package:reddit_mobile/features/auth/controller/auth.controller.dart';
import 'package:reddit_mobile/theme/palette.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends ConsumerStatefulWidget {
  const ProfileDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends ConsumerState<ProfileDrawer> {
  void navigateToUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void toggleTheme(WidgetRef ref) {
    setState(() {
      ref.watch(themeProvider.notifier).toggleTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.profilePic),
              radius: 70,
            ),
            const SizedBox(height: 10),
            Text(
              'u/${user.name}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            ListTile(
              title: const Text('My Profile'),
              leading: const Icon(Icons.person),
              onTap: () => navigateToUserProfile(context, user.uid),
            ),
            ListTile(
              title: const Text('Log Out'),
              leading: Icon(
                Icons.logout,
                color: Palette.redColor,
              ),
              onTap: () {
                logOut(ref);
              },
            ),
            Switch.adaptive(
              value: ref.watch(themeProvider.notifier).mode == EThemeMode.dark,
              onChanged: (val) => toggleTheme(ref),
            ),
          ],
        ),
      ),
    );
  }
}
