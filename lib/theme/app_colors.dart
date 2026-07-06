import 'package:flutter/material.dart';

class AppColors {
  // -- Tozher Palette -------------------------------------------------------
  // 1 – Backgrounds, cards, light areas
  static const Color background = Color(0xFFF4F9F9);
  // 2 – Secondary surfaces, hover states, dividers
  static const Color surfaceSecondary = Color(0xFFF1D1D0);
  // 3 – Primary buttons, active icons, links, app bar
  static const Color primary = Color(0xFFA53366);
  // 4 – Accents, highlights, badges, progress bars
  static const Color accent = Color(0xFFFBACCC);

  // -- Semantic -------------------------------------------------------------
  static const Color textPrimary = Color(0xFF2D2D2D);
  static const Color textOnPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF6B6B6B);

  static const Color success = Color(0xFF4BB543);
  static const Color error = Color(0xFFDE5A50);

  // -- Dark (kept for dark theme) -------------------------------------------
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1F1F1F);
  static const Color darkText = Colors.white;

  // -- Legacy aliases (for backward compatibility) --------------------------
  static const Color primaryColor = primary;
  static const Color secondColor = accent;
  static const Color lightBackgroundColor = background;
  static const Color darkBackgroundColor = darkBackground;
  static const Color lightItemBackgroundColor = surfaceSecondary;
  static const Color darkItemBackgroundColor = darkSurface;
  static const Color lightTextColor = textPrimary;
  static const Color darkTextColor = darkText;
  static const Color lightSurfaceColor = background;
  static const Color greenSuccessColor = success;
  static const Color redErrorColor = error;
}
