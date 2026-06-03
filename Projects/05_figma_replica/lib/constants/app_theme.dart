import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {

static ColorScheme getColor (context){
  return Theme.of(context).colorScheme;
} 

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    primaryColor: AppColors.primary,

    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),

    cardColor: AppColors.cardColor,
  );

  static ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF90CAF9),
    secondary: Color(0xFFB0BEC5),
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white,
  ),

  scaffoldBackgroundColor: DarkAppColors.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: DarkAppColors.appBar,
    foregroundColor: Colors.white,
  ),

  cardColor: DarkAppColors.cardColor,

  //dividerColor: DarkAppColors.border,

  // textTheme: const TextTheme(
  //   bodyLarge: TextStyle(
  //     color: DarkAppColors.textPrimary,
  //   ),
  //   bodyMedium: TextStyle(
  //     color: DarkAppColors.textSecondary,
  //   ),
  //   titleLarge: TextStyle(
  //     color: DarkAppColors.textPrimary,
  //     fontWeight: FontWeight.bold,
  //   ),
  // ),
);
}

