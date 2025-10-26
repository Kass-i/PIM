import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
  brightness: Brightness.light,
);

final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
  brightness: Brightness.dark,
);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  brightness: Brightness.light,

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lightColorScheme.secondaryContainer,
    selectedItemColor: lightColorScheme.primary,
  ),
  appBarTheme: AppBarTheme(backgroundColor: lightColorScheme.inversePrimary),
  cardTheme: CardThemeData(color: lightColorScheme.secondaryContainer),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  brightness: Brightness.dark,

  scaffoldBackgroundColor: darkColorScheme.surface,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: darkColorScheme.onPrimaryFixed,
    selectedItemColor: darkColorScheme.onPrimaryContainer,
  ),
  appBarTheme: AppBarTheme(backgroundColor: darkColorScheme.onPrimaryFixed),
  cardTheme: CardThemeData(color: darkColorScheme.onPrimary),
);