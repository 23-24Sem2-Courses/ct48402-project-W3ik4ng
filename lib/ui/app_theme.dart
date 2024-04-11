import 'package:flutter/material.dart';

class AppTheme {
  static TextTheme lightTextTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = const TextTheme(
      bodyLarge: TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ));

  static ThemeData light() {
    return ThemeData(brightness: Brightness.light, textTheme: lightTextTheme);
  }

  static ThemeData dark() {
    return ThemeData(brightness: Brightness.dark, textTheme: darkTextTheme);
  }
}
