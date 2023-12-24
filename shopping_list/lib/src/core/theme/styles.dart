import 'package:flutter/material.dart';

class Styles {
  static ThemeData get materialTheme2 {
    return ThemeData(
      useMaterial3: false,
      primarySwatch: Colors.green,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
      ),
    );
  }

  static ThemeData get materialTheme3 {
    return ThemeData(
      useMaterial3: true,
      primaryColor: Colors.green,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.green,
        onPrimary: Colors.white,
        secondary: Colors.yellow,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.green,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
