import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      //error:
      //onError:
    ),
    //secondaryHeaderColor: AppColors.secondaryColor,
    scaffoldBackgroundColor: AppColors.primaryDark,
    hintColor: AppColors.hintText,

    textTheme: TextTheme(     // Titulo login y register
      displayLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 36,
        color: AppColors.primaryText
      ),
      titleMedium: GoogleFonts.poppins(     // Used on inputs
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
        fontSize: 16
      ),
      bodyLarge: GoogleFonts.poppins(       // hintText
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
        fontSize: 16
      ),
      bodyMedium: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        color: AppColors.primaryText,
        fontSize: 16
      ),
      labelMedium: GoogleFonts.poppins(
        color: AppColors.primaryText
      )
    ),

    iconTheme: const IconThemeData(
      color: AppColors.primaryText
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: AppColors.primaryText,
      titleTextStyle: GoogleFonts.poppins(
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
      hintStyle: GoogleFonts.poppins(
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
      )
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.secondaryDark,
      headerBackgroundColor: AppColors.primaryDark,
      dividerColor: AppColors.primaryColor,
      weekdayStyle: GoogleFonts.poppins(
        color: AppColors.secondaryColor
      ),
      locale: const Locale('es')
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.secondaryDark,

    ),
  );
}