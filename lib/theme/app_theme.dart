import 'package:flutter/material.dart';

class AppTheme {
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color goldLight = Color(0xFFF4D03F);
  static const Color goldPrimary = Color(0xFFC6A700);
  static const Color goldAccent = Color(0xFFE5C100);
  static const Color error = Color(0xFFE74C3C);
  static const Color success = Color(0xFF2ECC71);
  
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF121212);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color darkCard = Color(0xFF2C2C2C);
  static const Color lightCard = Color(0xFFFAFAFA);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: goldColor,
      scaffoldBackgroundColor: lightBackground,
      cardColor: lightCard,
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        color: lightCard,
        elevation: 2,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: goldColor,
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkCard,
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: const CardThemeData(
        color: darkCard,
        elevation: 2,
      ),
    );
  }
}
