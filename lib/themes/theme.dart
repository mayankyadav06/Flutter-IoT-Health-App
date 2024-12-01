import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.cyan.shade100,
    primary: Colors.cyan.shade300,
    secondary: Colors.black, // for texts and border
  ),
  appBarTheme: AppBarTheme(color: Colors.cyan.shade400),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade800,
      primary: Colors.grey.shade900,
      secondary: Colors.white),
  appBarTheme: AppBarTheme(color: Colors.black54),
);
