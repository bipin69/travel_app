import 'package:flutter/material.dart';


class AppTheme {
  AppTheme._();

  static getApplicationTheme({required bool isDarkMode}) {
    return ThemeData(
      // Base Theme Settings
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Nunito",
      colorScheme: isDarkMode
          ? const ColorScheme.dark(
              primary: Colors.blue,
            )
          : const ColorScheme.light(
              primary: Colors.blue,
            ),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      useMaterial3: true,

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: "Nunito",
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: "Nunito",
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(),
        labelStyle: TextStyle(
          fontSize: 20,
          fontFamily: "Nunito",
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.blue,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
