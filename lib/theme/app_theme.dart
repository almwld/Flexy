import 'package:flutter/material.dart';

class AppTheme {
  // الألوان الذهبية الثابتة
  static const Color goldColor = Color(0xFFD4AF37);      // ذهبي غامق
  static const Color goldLight = Color(0xFFF4D03F);      // ذهبي فاتح
  static const Color goldPrimary = Color(0xFFC6A700);    // ذهبي أساسي
  static const Color goldAccent = Color(0xFFE5C100);     // ذهبي محايد
  static const Color error = Color(0xFFE74C3C);
  static const Color success = Color(0xFF2ECC71);
  
  // ألوان الخلفية - تختلف حسب الثيم
  static const Color darkBackground = Color(0xFF121212);  // خلفية داكنة
  static const Color lightBackground = Color(0xFFF5F5F5); // خلفية فاتحة
  static const Color darkSurface = Color(0xFF1E1E1E);     // سطح داكن
  static const Color lightSurface = Color(0xFFFFFFFF);    // سطح فاتح
  static const Color darkCard = Color(0xFF2C2C2C);        // بطاقة داكنة
  static const Color lightCard = Color(0xFFFAFAFA);       // بطاقة فاتحة
  static const Color darkText = Color(0xFFE0E0E0);        // نص داكن
  static const Color lightText = Color(0xFF212121);       // نص فاتح

  // الثيم الفاتح
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: goldColor,
      scaffoldBackgroundColor: lightBackground,
      cardColor: lightCard,
      
      // ألوان النص
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: lightText),
        bodyMedium: TextStyle(color: lightText),
        titleLarge: TextStyle(color: lightText, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: lightText),
        labelLarge: TextStyle(color: lightText),
      ),
      
      // شريط التطبيق
      appBarTheme: const AppBarTheme(
        backgroundColor: lightSurface,
        foregroundColor: lightText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: lightText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      
      // البطاقات
      cardTheme: CardThemeData(
        color: lightCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // الأزرار
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      // حقول الإدخال
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      
      // قوائم التنقل السفلي
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightSurface,
        selectedItemColor: goldColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }

  // الثيم الداكن
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: goldColor,
      scaffoldBackgroundColor: darkBackground,
      cardColor: darkCard,
      
      // ألوان النص
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: darkText),
        bodyMedium: TextStyle(color: darkText),
        titleLarge: TextStyle(color: darkText, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: darkText),
        labelLarge: TextStyle(color: darkText),
      ),
      
      // شريط التطبيق
      appBarTheme: const AppBarTheme(
        backgroundColor: darkSurface,
        foregroundColor: darkText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: darkText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      
      // البطاقات
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // الأزرار
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: goldColor,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      // حقول الإدخال
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      
      // قوائم التنقل السفلي
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: goldColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
