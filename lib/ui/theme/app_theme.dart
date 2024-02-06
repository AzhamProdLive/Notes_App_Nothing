import 'package:app_client/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTheme {
  static final dark = ThemeData(
    typography: Typography.material2018(),
    primaryColor: Colors.white,
    splashColor: Colors.white,
    textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white), bodyText2: TextStyle(color: Colors.white), button: TextStyle(color: Colors.white), ),
    navigationBarTheme: const NavigationBarThemeData(backgroundColor: Colors.black, labelTextStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(color: Colors.white))),
    primaryTextTheme:  const TextTheme(bodyText1: TextStyle(color: Colors.white), bodyText2: TextStyle(color: Colors.white), button: TextStyle(color: Colors.white),),
    backgroundColor: Colors.black,
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
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
      fontFamily: 'Nunito',
      scaffoldBackgroundColor: CustomColors.backgroundColor, colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, background: Colors.black));
}
