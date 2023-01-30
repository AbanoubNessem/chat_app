import 'package:flutter/material.dart';

class AppStyle {
  static Color lightPrimaryColor = const Color(0xff39A552);
  static Color lightAccentColor = const Color(0xffDFECDB);
  static ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: lightPrimaryColor,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      scaffoldBackgroundColor: lightAccentColor,
      cursorColor: Colors.white,
      backgroundColor: lightPrimaryColor,
      cardColor: Colors.black,
      textTheme: TextTheme(
        titleMedium: const TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold),
        headlineSmall: const TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold),
        titleLarge: const TextStyle(color: Colors.black, fontSize: 20),
        titleSmall: const TextStyle(fontSize: 18),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: lightPrimaryColor,
      ));
}
