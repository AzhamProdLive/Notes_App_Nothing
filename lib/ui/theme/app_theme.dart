import 'package:app_client/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTheme {
  static final dark = ThemeData(
    primaryColor: CustomColors.deepRed,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    canvasColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: CustomColors.lightGrey,
        hintStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
      dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(color: Colors.white),
        contentTextStyle: TextStyle(color: Colors.white),
        backgroundColor: CustomColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
      fontFamily: 'Nunito',
      scaffoldBackgroundColor: CustomColors.backgroundColor, colorScheme: ColorScheme.fromSeed(seedColor: Colors.black, background: Colors.black));
}
