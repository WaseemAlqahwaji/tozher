import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tozher/theme/app_colors.dart';

class AppTheme {
  static const String primaryFontFamily = 'Montserrat';
  static const String secondaryFontFamily = 'Inter';

  // ---------------------------------------------------------------------------
  // Shared Input Decorations
  // ---------------------------------------------------------------------------
  static final InputDecorationTheme _lightInputDecoration = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    errorMaxLines: 3,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.surfaceSecondary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: AppColors.surfaceSecondary.withValues(alpha: 0.6),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.error, width: 2),
    ),
    hintStyle: TextStyle(
      color: AppColors.textSecondary.withValues(alpha: 0.7),
      fontSize: 14.sp,
    ),
  );

  static final InputDecorationTheme _darkInputDecoration = InputDecorationTheme(
    filled: true,
    errorMaxLines: 3,
    fillColor: AppColors.darkSurface,
    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    hintStyle: TextStyle(
      color: AppColors.darkText.withValues(alpha: 0.4),
      fontSize: 14.sp,
    ),
  );

  // ---------------------------------------------------------------------------
  // Light Theme – Tozher palette
  // ---------------------------------------------------------------------------
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      secondary: AppColors.accent,
      onSecondary: AppColors.textPrimary,
      surface: AppColors.background,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: primaryFontFamily,
      
      // -- App Bar ------------------------------------------------------------
      // Spec: background #F875AA with white icons
      appBarTheme: AppBarTheme(
        elevation: 10,
        // iconTheme: const IconThemeData(color: AppColors.textOnPrimary),
        titleTextStyle: TextStyle(
          fontFamily: secondaryFontFamily,
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
          letterSpacing: 0.5,
        ),
      ),

      // -- Bottom Navigation --------------------------------------------------
      // Spec: active tint #F875AA
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontFamily: primaryFontFamily,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: primaryFontFamily,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      // -- Buttons ------------------------------------------------------------
      // Spec: background #F875AA, text white
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.4),
          disabledForegroundColor: AppColors.textOnPrimary.withValues(
            alpha: 0.6,
          ),
          elevation: 0,
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontFamily: primaryFontFamily,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontFamily: primaryFontFamily,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: TextStyle(
            fontSize: 14.sp,
            fontFamily: primaryFontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // -- Progress Indicators ------------------------------------------------
      // Spec: progress bar color #FBACCC
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accent,
        linearTrackColor: AppColors.surfaceSecondary,
        circularTrackColor: AppColors.surfaceSecondary,
      ),

      // -- Cards --------------------------------------------------------------
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1,
        shadowColor: AppColors.primary.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      ),

      // -- Input Decoration ---------------------------------------------------
      inputDecorationTheme: _lightInputDecoration,
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: _lightInputDecoration,
      ),

      // -- Chips --------------------------------------------------------------
      chipTheme: ChipThemeData(
        showCheckmark: false,
        backgroundColor: AppColors.surfaceSecondary,
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          fontSize: 13.sp,
          fontFamily: primaryFontFamily,
          color: AppColors.textPrimary,
        ),
        secondaryLabelStyle: TextStyle(
          fontSize: 13.sp,
          fontFamily: primaryFontFamily,
          color: AppColors.textOnPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        side: BorderSide.none,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      ),

      // -- Tab Bar ------------------------------------------------------------
      tabBarTheme: TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
        labelStyle: TextStyle(
          fontFamily: primaryFontFamily,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: primaryFontFamily,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      // -- FAB ----------------------------------------------------------------
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 4,
      ),

      // -- Switch -------------------------------------------------------------
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return AppColors.surfaceSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withValues(alpha: 0.4);
          }
          return AppColors.textSecondary.withValues(alpha: 0.2);
        }),
      ),

      // -- Checkbox -----------------------------------------------------------
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.textOnPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      ),

      // -- Dialog -------------------------------------------------------------
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        titleTextStyle: TextStyle(
          fontFamily: secondaryFontFamily,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),

      // -- Snack Bar ----------------------------------------------------------
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: TextStyle(
          color: AppColors.textOnPrimary,
          fontSize: 14.sp,
          fontFamily: primaryFontFamily,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // -- Divider ------------------------------------------------------------
      dividerTheme: DividerThemeData(
        color: AppColors.surfaceSecondary,
        thickness: 1,
        space: 1,
      ),

      // -- Icon Theme ---------------------------------------------------------
      iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 24),

      // -- Text Theme ---------------------------------------------------------
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w700,
          fontFamily: secondaryFontFamily,
          color: AppColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
          fontFamily: secondaryFontFamily,
          color: AppColors.textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          fontFamily: secondaryFontFamily,
          color: AppColors.textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.w700,
          fontFamily: primaryFontFamily,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          fontFamily: primaryFontFamily,
          color: AppColors.textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          fontFamily: primaryFontFamily,
          color: AppColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          fontFamily: primaryFontFamily,
          color: AppColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          fontFamily: primaryFontFamily,
          color: AppColors.textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: primaryFontFamily,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          fontFamily: primaryFontFamily,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          fontFamily: primaryFontFamily,
          color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          fontFamily: primaryFontFamily,
          color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          fontFamily: primaryFontFamily,
          color: AppColors.primary,
        ),
        labelMedium: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          fontFamily: primaryFontFamily,
          color: AppColors.textPrimary,
        ),
        labelSmall: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: primaryFontFamily,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Dark Theme
  // ---------------------------------------------------------------------------
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      secondary: AppColors.accent,
      onSecondary: AppColors.textPrimary,
      surface: AppColors.darkBackground,
      onSurface: AppColors.darkText,
      error: AppColors.error,
      onError: AppColors.textOnPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: primaryFontFamily,

      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkText,
        iconTheme: const IconThemeData(color: AppColors.darkText),
        titleTextStyle: TextStyle(
          fontFamily: secondaryFontFamily,
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.darkText,
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkText.withValues(alpha: 0.5),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          fontFamily: primaryFontFamily,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: primaryFontFamily,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontFamily: primaryFontFamily,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      ),

      inputDecorationTheme: _darkInputDecoration,
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: _darkInputDecoration,
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accent,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedColor: AppColors.primary,
        labelStyle: TextStyle(
          fontSize: 13.sp,
          fontFamily: primaryFontFamily,
          color: AppColors.darkText,
        ),
        secondaryLabelStyle: TextStyle(
          fontSize: 13.sp,
          fontFamily: primaryFontFamily,
          color: AppColors.textOnPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        side: BorderSide.none,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return Colors.white54;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary.withValues(alpha: 0.4);
          }
          return Colors.white.withValues(alpha: 0.1);
        }),
      ),

      iconTheme: const IconThemeData(color: AppColors.darkText, size: 24),

      dividerTheme: const DividerThemeData(
        color: AppColors.darkSurface,
        thickness: 1,
        space: 1,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        titleTextStyle: TextStyle(
          fontFamily: secondaryFontFamily,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.darkText,
        ),
      ),

      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w700,
          fontFamily: secondaryFontFamily,
          color: AppColors.darkText,
        ),
        displayMedium: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
          fontFamily: secondaryFontFamily,
          color: AppColors.darkText,
        ),
        displaySmall: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          fontFamily: secondaryFontFamily,
          color: AppColors.darkText,
        ),
        headlineLarge: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.w700,
          fontFamily: primaryFontFamily,
          color: AppColors.darkText,
        ),
        headlineMedium: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          fontFamily: primaryFontFamily,
          color: AppColors.darkText,
        ),
        headlineSmall: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          fontFamily: primaryFontFamily,
          color: AppColors.darkText,
        ),
        titleLarge: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          fontFamily: primaryFontFamily,
          color: AppColors.darkText,
        ),
        titleMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          fontFamily: primaryFontFamily,
          color: AppColors.darkText,
        ),
        titleSmall: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: primaryFontFamily,
          color: AppColors.darkText,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          fontFamily: primaryFontFamily,
          color: AppColors.darkText,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          fontFamily: primaryFontFamily,
          color: AppColors.darkText,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          fontFamily: primaryFontFamily,
          color: AppColors.darkText.withValues(alpha: 0.7),
        ),
        labelLarge: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          fontFamily: primaryFontFamily,
          color: AppColors.primary,
        ),
        labelMedium: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          fontFamily: primaryFontFamily,
          color: AppColors.darkText,
        ),
        labelSmall: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: primaryFontFamily,
          color: AppColors.darkText.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
