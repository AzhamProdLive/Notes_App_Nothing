import 'package:app_client/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';

Color toggleableActiveCustomColor = Colors.black;

class AppTheme {
  static final dark = ThemeData(
    typography: Typography.material2018(),
    primaryColor: Colors.white,
    splashColor: Colors.white,

    textTheme: const TextTheme(bodyLarge: TextStyle(color: Colors.white), bodyMedium: TextStyle(color: Colors.white), labelLarge: TextStyle(color: Colors.white), ),
    primaryTextTheme:  const TextTheme(bodyLarge: TextStyle(color: Colors.white), bodyMedium: TextStyle(color: Colors.white), labelLarge: TextStyle(color: Colors.white),),

   navigationBarTheme: const NavigationBarThemeData(backgroundColor: Colors.black, labelTextStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(color: Colors.white))),

    canvasColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: CustomColors.lightGrey,
        focusColor: Colors.white,
        hintStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
        labelStyle: TextStyle(color: CustomColors.whiteMain)
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
      scaffoldBackgroundColor: CustomColors.backgroundColor,

      fontFamily: 'Nunito',

    checkboxTheme: CheckboxThemeData(
       fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
         if (states.contains(MaterialState.disabled)) { return null; }
         if (states.contains(MaterialState.selected)) { return toggleableActiveCustomColor; }
         return null;
       }),
        ),
    radioTheme: RadioThemeData(
       fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
       if (states.contains(MaterialState.disabled)) { return null; }
       if (states.contains(MaterialState.selected)) { return toggleableActiveCustomColor; }
       return null;
       }),
       ),
    switchTheme: SwitchThemeData(
       thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
         if (states.contains(MaterialState.disabled)) { return null; }
         if (states.contains(MaterialState.selected)) { return toggleableActiveCustomColor; }
         return null;
       }),
       trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
         if (states.contains(MaterialState.disabled)) { return null; }
         if (states.contains(MaterialState.selected)) { return toggleableActiveCustomColor; }
         return null;
       }),
       ), colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, background: Colors.black).copyWith(background: Colors.black),);
}
