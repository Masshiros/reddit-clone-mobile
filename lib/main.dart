import 'package:flutter/material.dart';
import 'package:reddit_mobile/theme/palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Palette.darkModeAppTheme,
      home: const SizedBox(),
      debugShowCheckedModeBanner: false,
    );
  }
}
