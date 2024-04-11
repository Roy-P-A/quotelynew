import 'package:flutter/material.dart';
import 'theme.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: Colors.transparent,
      ),
      fontFamily: "DMSans",
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 28, color: primaryColor),
        displayMedium: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 26, color: primaryColor),
        displaySmall: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 24, color: primaryColor),
        headlineLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: secondaryHeadingColor),
        headlineMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: secondaryTextColor),
        headlineSmall: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 18, color: primaryColor),
        titleLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: secondaryTextColor2),
        titleMedium: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: primaryColor),
        titleSmall: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: tertiaryTextColor),
        bodyLarge: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: tertiaryTextColor),
        bodyMedium: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 14, color: primaryColor),
        bodySmall: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 13, color: primaryColor),
        labelLarge: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 13, color: primaryColor),
        labelMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: secondaryTextColor),
        labelSmall: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 10, color: primaryColor),
      ));
}
