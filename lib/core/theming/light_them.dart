import 'package:flutter/material.dart';

ThemeData getLightTheme = ThemeData(
  fontFamily: 'Inter',
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.deepPurple,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 1,
      centerTitle: false,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black87, fontSize: 16),
      titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
   
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade200,
      suffixIconColor: Colors.black54,
      hintStyle: const TextStyle(color: Colors.black38),
      prefixIconColor: Colors.black54,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    ),);
