import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_mobile/core/enum/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) => ThemeNotifier());

class Palette {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const greyColor = Color.fromRGBO(26, 39, 45, 1); // secondary color
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
    ),
    primaryColor: redColor,
    // backgroundColor: drawerColor,
    // will be used as alternative background color
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: redColor,
    // backgroundColor: whiteColor,
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  EThemeMode _mode;
  EThemeMode get mode => _mode;
  ThemeNotifier({EThemeMode mode = EThemeMode.dark})
      : _mode = mode,
        super(Palette.darkModeAppTheme) {
    getTheme();
  }

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = EThemeMode.light;
      state = Palette.lightModeAppTheme;
    } else {
      _mode = EThemeMode.dark;
      state = Palette.darkModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == EThemeMode.dark) {
      _mode = EThemeMode.light;
      state = Palette.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = EThemeMode.dark;
      state = Palette.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
