import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/theming/light_them.dart';
import 'package:movie/core/theming/dark_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(getDarkTheme);

  bool isDark = true;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('isDarkTheme') ?? false;
    emit(isDark ? getDarkTheme : getLightTheme);
  }

  Future<void> toggleTheme() async {
    isDark = !isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDark);
    emit(isDark ? getDarkTheme : getLightTheme);
  }
}
