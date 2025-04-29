import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData appThemeData = ThemeData(
    primaryColor: Colors.black87,
    useMaterial3: true,
    fontFamily: 'Quicksand',
    buttonTheme: ButtonThemeData(buttonColor: Colors.green),
    appBarTheme: AppBarTheme(backgroundColor: Color(0x2B0A3C07)),
    textTheme: TextTheme(
      // content
      bodySmall: TextStyle(
        fontSize: 8,
        color: Colors.black87,
        height: 2,
      ),
      bodyMedium: TextStyle(
        fontSize: 10,
        height: 2,
        color: Colors.black87,
      ),
      bodyLarge: TextStyle(
        fontSize: 12,
        height: 2,
        color: Colors.black87,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        color: Colors.black87,
        height: 2,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        color: Colors.black87,
        height: 2,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: TextStyle(
        fontSize: 18,
        color: Colors.black87,
        height: 2,
        fontWeight: FontWeight.w500,
      ),

      // titles
      displaySmall: TextStyle(
        fontSize: 25,
        height: 1.2,
        color: Colors.black87,
      ),
      displayMedium: TextStyle(
        fontSize: 30,
        height: 1.2,
        color: Colors.black87,
      ),
      displayLarge: TextStyle(
        fontSize: 35,
        height: 1.2,
        color: Colors.black87,
      ),
      titleSmall: TextStyle(
        fontSize: 40,
        color: Colors.black87,
        height: 1.2,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontSize: 45,
        color: Colors.black87,
        height: 1.2,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontSize: 50,
        color: Colors.black87,
        height: 1.2,
        fontWeight: FontWeight.w500,
      ),

      // large texts
      headlineSmall: TextStyle(
        fontSize: 55,
        height: 1.25,
        color: Colors.black87,
      ),
      headlineMedium: TextStyle(
        fontSize: 70,
        height: 1.25,
        color: Colors.black87,
      ),
      headlineLarge: TextStyle(
        fontSize: 85,
        height: 1.25,
        color: Colors.black87,
      ),
    ),
  );
}
