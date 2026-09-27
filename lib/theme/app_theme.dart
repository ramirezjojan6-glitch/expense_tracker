import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      textTheme: TextTheme(
        titleLarge: GoogleFonts.fredoka(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTeal,
        ),
        titleMedium: GoogleFonts.fredoka(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTeal,
        ),
      ),
    );
  }
}