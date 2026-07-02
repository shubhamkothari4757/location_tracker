import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryNeon = Color(0xFF10B981); // Emerald Green
  static const Color secondaryNeon = Color(0xFF06B6D4); // Cyan Blue
  static const Color accentColor = Color(0xFF6366F1); // Indigo
  static const Color alertRed = Color(0xFFEF4444); // Red 500

  // Battery Status Colors
  static const Color batteryLow = Color(0xFFEF4444);     // Red
  static const Color batteryNormal = Color(0xFFF97316);  // Orange
  static const Color batteryOptimal = Color(0xFFF59E0B); // Amber
  static const Color batteryFull = Color(0xFF10B981);    // Emerald Green

  // Dark Mode Colors
  static const Color darkBg = Color(0xFF0F172A); // Deep Slate Blue
  static const Color darkCard = Color(0xFF1E293B); // Muted Slate
  static const Color darkTextPrimary = Color(0xFFF8FAFC); // Slate 50
  static const Color darkTextSecondary = Color(0xFF94A3B8); // Slate 400
  static const Color darkBorder = Color(0xFF334155);

  // Light Mode Colors
  static const Color lightBg = Color(0xFFF8FAFC); // Slate 50
  static const Color lightCard = Color(0xFFFFFFFF); // White
  static const Color lightTextPrimary = Color(0xFF0F172A); // Deep Slate
  static const Color lightTextSecondary = Color(0xFF64748B); // Slate 500
  static const Color lightBorder = Color(0xFFE2E8F0); // Slate 200

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: primaryNeon,
      colorScheme: const ColorScheme.dark(
        primary: primaryNeon,
        secondary: secondaryNeon,
        tertiary: accentColor,
        surface: darkBg,
        surfaceContainer: darkCard,
        error: alertRed,
        outline: darkTextSecondary,
        outlineVariant: darkBorder,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: darkTextPrimary,
        onSurfaceVariant: darkTextSecondary,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().textTheme.copyWith(
              headlineLarge: const TextStyle(
                color: darkTextPrimary,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
              headlineMedium: const TextStyle(
                color: darkTextPrimary,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
              titleLarge: const TextStyle(
                color: darkTextPrimary,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
              bodyLarge: const TextStyle(
                color: darkTextPrimary,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
              bodyMedium: const TextStyle(
                color: darkTextSecondary,
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
              labelSmall: const TextStyle(
                color: darkTextSecondary,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
      ),
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(
            color: darkBorder,
            width: 1,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBg,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: darkTextPrimary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: darkTextPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryNeon,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryNeon,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: darkCard,
        indicatorColor: primaryNeon.withValues(alpha: 0.15),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(color: primaryNeon, fontWeight: FontWeight.bold);
          }
          return const TextStyle(color: darkTextSecondary);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryNeon);
          }
          return const IconThemeData(color: darkTextSecondary);
        }),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(darkTextSecondary.withValues(alpha: 0.3)),
        radius: const Radius.circular(8.0),
        thickness: WidgetStateProperty.all(6.0),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBg,
      primaryColor: primaryNeon,
      colorScheme: const ColorScheme.light(
        primary: primaryNeon,
        secondary: secondaryNeon,
        tertiary: accentColor,
        surface: lightBg,
        surfaceContainer: lightCard,
        error: alertRed,
        outline: lightTextSecondary,
        outlineVariant: lightBorder,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: lightTextPrimary,
        onSurfaceVariant: lightTextSecondary,
      ),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData.light().textTheme.copyWith(
              headlineLarge: const TextStyle(
                color: lightTextPrimary,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
              headlineMedium: const TextStyle(
                color: lightTextPrimary,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
              titleLarge: const TextStyle(
                color: lightTextPrimary,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
              bodyLarge: const TextStyle(
                color: lightTextPrimary,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
              bodyMedium: const TextStyle(
                color: lightTextSecondary,
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
              labelSmall: const TextStyle(
                color: lightTextSecondary,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
      ),
      cardTheme: CardThemeData(
        color: lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(
            color: lightBorder,
            width: 1,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBg,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: lightTextPrimary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: lightTextPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryNeon,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          textStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryNeon,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: lightCard,
        indicatorColor: primaryNeon.withValues(alpha: 0.15),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(color: primaryNeon, fontWeight: FontWeight.bold);
          }
          return const TextStyle(color: lightTextSecondary);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryNeon);
          }
          return const IconThemeData(color: lightTextSecondary);
        }),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(lightTextSecondary.withValues(alpha: 0.3)),
        radius: const Radius.circular(8.0),
        thickness: WidgetStateProperty.all(6.0),
      ),
    );
  }
}
