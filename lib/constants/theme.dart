import 'package:flutter/material.dart';

class AppTheme {
  // Refined Foodish Color Palette
  static const Color tomatoRed = Color(0xFFD32F2F); // Richer red, like ripe tomatoes
  static const Color basilGreen = Color(0xFF388E3C); // Deep, vibrant green
  static const Color saffronGold = Color(0xFFFBC02D); // Warm, appetizing gold
  static const Color warmBrown = Color(0xFF6D4C41); // Softer brown, like toasted bread
  static const Color softCream = Color(0xFFFFF7E6); // Creamy off-white for backgrounds
  static const Color neutralGray = Color(0xFF616161); // Neutral for text and borders

  // Light Theme: Fresh, modern, daytime dining vibe
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: softCream,
      primaryColor: tomatoRed,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: neutralGray,
          fontFamily: 'Roboto', // Clean and modern
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: neutralGray,
          fontFamily: 'Roboto',
          fontSize: 14,
        ),
        titleLarge: TextStyle(
          color: warmBrown,
          fontFamily: 'Lora', // Elegant for headers
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: softCream,
        foregroundColor: warmBrown,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: warmBrown,
          fontFamily: 'Lora',
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: softCream,
        selectedItemColor: tomatoRed,
        unselectedItemColor: neutralGray.withOpacity(0.6),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: saffronGold,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: tomatoRed,
        secondary: basilGreen,
        surface: softCream,
        onSurface: neutralGray,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        prefixIconColor: neutralGray,
        hintStyle: TextStyle(color: neutralGray.withOpacity(0.6)),
      ),
    );
  }

  // Warm Theme: Cozy, elegant, evening dining vibe
  static ThemeData get warmTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color(0xFFFBE9E7), // Warm peach background
      primaryColor: warmBrown,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Color(0xFF3E2723),
          fontFamily: 'Lora', // Elegant and warm
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFF3E2723),
          fontFamily: 'Lora',
          fontSize: 14,
        ),
        titleLarge: TextStyle(
          color: warmBrown,
          fontFamily: 'Lora',
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFBE9E7),
        foregroundColor: Color(0xFF3E2723),
        elevation: 1,
        titleTextStyle: TextStyle(
          color: warmBrown,
          fontFamily: 'Lora',
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFBE9E7),
        selectedItemColor: warmBrown,
        unselectedItemColor: neutralGray.withOpacity(0.6),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: warmBrown,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontFamily: 'Lora',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: warmBrown,
        secondary: saffronGold,
        surface: Color(0xFFFBE9E7),
        onSurface: Color(0xFF3E2723),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        prefixIconColor: Color(0xFF3E2723),
        hintStyle: TextStyle(color: Color(0xFF3E2723).withOpacity(0.6)),
      ),
    );
  }
}