import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {

  static ThemeData darkTheme = ThemeData(

    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      //onPrimary:
      //onSecondary:
      //background
      //onBackground
      //surface:
      error: AppColors.errorColor,
      onError: AppColors.errorColor
    ),
    //secondaryHeaderColor: AppColors.secondaryColor,
    scaffoldBackgroundColor: AppColors.primaryDark,
    hintColor: AppColors.hintText,

    textTheme: const TextTheme(  // Titulo login y register
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 36,
        color: AppColors.primaryText
      ),
      titleMedium: TextStyle(   // Used on inputs
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
        fontSize: 16
      ),
      bodyLarge: TextStyle(     // texto ingresado
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
        fontSize: 16
      ),
      bodyMedium: TextStyle(    // general
        fontFamily: 'Poppins',
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
        fontSize: 16
      ),
      labelMedium: TextStyle(
        color: AppColors.primaryText
      )
    ),

    iconTheme: const IconThemeData(
      color: AppColors.primaryText
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.primaryText,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        fontSize: 36,
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
      hintStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: AppColors.hintText
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4
      ),
      prefixIconColor: AppColors.secondaryText,
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
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.errorColor,
          width: 2.0
        ),
        borderRadius: BorderRadius.circular(16)
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.errorColor,
          width: 2.0
        ),
        borderRadius: BorderRadius.circular(16)
      )
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.secondaryDark,
      headerBackgroundColor: AppColors.primaryDark,
      dividerColor: AppColors.primaryColor,
      headerHeadlineStyle: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 30
      ),
      headerHelpStyle: const TextStyle(
        fontFamily: 'Poppins',
      ),
      weekdayStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: AppColors.secondaryColor
      ),
      dayStyle: const TextStyle(
        fontFamily: 'Poppins',
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.secondaryColor),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontFamily: 'Poppins')
        )
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.secondaryColor),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontFamily: 'Poppins')
        )
      ),
      locale: const Locale('es')
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.secondaryDark,

    ),
  );
}