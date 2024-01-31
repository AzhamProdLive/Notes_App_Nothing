import 'package:app_client/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final dark = ThemeData(
    canvasColor: Colors.yellow,
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: CustomColors.lightGrey,
        hintStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
      dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        contentTextStyle: TextStyle(color: Colors.white),
        backgroundColor: CustomColors.darkGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
      fontFamily: 'Nunito',
      scaffoldBackgroundColor: CustomColors.darkGrey, colorScheme: ColorScheme.fromSeed(seedColor: Colors.black, background: Colors.black));
}
