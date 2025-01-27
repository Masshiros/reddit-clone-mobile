import 'package:flutter/material.dart';
import 'package:reddit_mobile/features/auth/screens/login.screen.dart';
import 'package:reddit_mobile/features/community/screens/add-mods.screen.dart';
import 'package:reddit_mobile/features/community/screens/community-detail.screen.dart';
import 'package:reddit_mobile/features/community/screens/create-community.screen.dart';
import 'package:reddit_mobile/features/community/screens/edit-community.screen.dart';
import 'package:reddit_mobile/features/community/screens/mod-tools.screen.dart';
import 'package:reddit_mobile/features/home/screens/home.screen.dart';
import 'package:reddit_mobile/features/posts/screens/add-post-type.screen.dart';
import 'package:reddit_mobile/features/posts/screens/add-post.screen.dart';
import 'package:reddit_mobile/features/profile/screens/edit-profile.screen.dart';
import 'package:reddit_mobile/features/profile/screens/profile.screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute =
    RouteMap(routes: {'/': (_) => const MaterialPage(child: LoginScreen())});
final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  '/r/:name': (route) =>
      MaterialPage(child: CommunityDetailScreen(route.pathParameters['name']!)),
  '/mod-tools/:name': (route) =>
      MaterialPage(child: ModToolsScreen(route.pathParameters['name']!)),
  '/edit-community/:name': (route) =>
      MaterialPage(child: EditCommunityScreen(route.pathParameters['name']!)),
  '/add-mods/:name': (route) =>
      MaterialPage(child: AddModsScreen(route.pathParameters['name']!)),
  '/u/:uid': (routeData) => MaterialPage(
        child: UserProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/edit-profile/:uid': (routeData) => MaterialPage(
        child: EditProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/add-post/:type': (routeData) => MaterialPage(
        child: AddPostTypeScreen(
          type: routeData.pathParameters['type']!,
        ),
      ),
});
