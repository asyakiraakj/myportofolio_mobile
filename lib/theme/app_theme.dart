import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/theme/app_colors.dart';

abstract final class AppTheme {
  static final dark = ThemeData(
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColors.primary500,
          brightness: Brightness.dark,
        ).copyWith(
          primary: AppColors.primary500,
          onPrimary: Colors.white,
          primaryContainer: AppColors.primary900,
          onPrimaryContainer: AppColors.primary100,
          secondary: AppColors.secondary500,
          onSecondary: Colors.white,
          secondaryContainer: AppColors.secondary900,
          onSecondaryContainer: AppColors.secondary100,
          surface: AppColors.background,
          onSurface: AppColors.text,
        ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary500,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.background,
    useMaterial3: true,
  );
}
