import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/features/auth/screens/login.screen.dart';
import 'package:reddit_mobile/firebase_options.dart';
import 'package:reddit_mobile/routes.dart';
import 'package:reddit_mobile/theme/palette.dart';
import 'package:routemaster/routemaster.dart';
import 'dart:ui' as ui;
import 'firebase_options.dart'; //

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider:
        AndroidProvider.debug, // Use debug provider for development
    appleProvider: AppleProvider.debug, // Use debug provider for development
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: Palette.darkModeAppTheme,
      routerDelegate:
          RoutemasterDelegate(routesBuilder: (context) => loggedOutRoute),
      routeInformationParser: const RoutemasterParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
