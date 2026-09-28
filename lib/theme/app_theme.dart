import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.lightPink,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.cyan,
        primary: AppColors.cyan,
        secondary: AppColors.pink,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkTeal,
        foregroundColor: AppColors.lightPink,
        elevation: 0,
      ),
      fontFamily: 'FacebookSans',
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontVariations: [FontVariation('wght', 600)],
          color: AppColors.darkTeal,
        ),
        titleMedium: TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontVariations: [FontVariation('wght', 600)],
          color: AppColors.darkTeal,
        ),
      ),
    );
  }
}