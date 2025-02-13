import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.red,
    primaryColor: AppColors.primaryColor,
    //secondaryHeaderColor: AppColors.secondaryColor,
    scaffoldBackgroundColor: AppColors.primaryDark,
    hintColor: AppColors.secondaryColor,

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 36,
        color: AppColors.primaryText
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 20,
        color: AppColors.primaryText
      ),
      bodyLarge: TextStyle(     // Used on inputs
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
        fontSize: 16,
      ),
      bodyMedium: TextStyle( //TODO: ir eliminando xd
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        fontSize: 16,
      )
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.primaryText,
      titleTextStyle: TextStyle(
        //TODO: hacer que funcione esta wea que no se cambia
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          fontSize: 20,
          color: AppColors.primaryText
      ),
      //elevation: <int> /sombra del AppBar
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionColor: AppColors.primaryColor.withValues(alpha: 0.5),
      selectionHandleColor: AppColors.secondaryColor,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.primaryDark,
      //prefixIconColor: AppColors.secondaryText,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4
      ),
      prefixIconColor: AppColors.secondaryText,
      //TODO: esta weá tampoco cambia creo
      hintStyle: const TextStyle(
        fontFamily: 'Poppins',
        //color: AppColors.secondaryDark //TODO: q wea? q color es?
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: 2.0
        ),
        borderRadius: BorderRadius.circular(16),

      ),
      enabledBorder: OutlineInputBorder(
         borderSide: const BorderSide(
           color: AppColors.secondaryDark,
           width: 2.0
         ),
        borderRadius: BorderRadius.circular(16)
      )
    )
  );
}