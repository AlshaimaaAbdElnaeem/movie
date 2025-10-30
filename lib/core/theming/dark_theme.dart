import 'package:flutter/material.dart';

ThemeData getDarkTheme = ThemeData(
  fontFamily: 'Inter',
   scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: Colors.red,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F1F1F),
      foregroundColor: Colors.white,
      
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 1,
      centerTitle: false,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 16),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
 
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2C2C),
      labelStyle: TextStyle(color: Colors.white70),
      suffixIconColor: Colors.white70,
      prefixIconColor: Colors.white70,
      hintStyle: const TextStyle(color: Colors.white54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    ),);
