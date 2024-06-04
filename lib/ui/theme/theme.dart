import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color orangeClr = Color(0xFFEC6343);
const Color greenClr = Color(0xFF779E99);
const Color primaryClr = Color(0xFF6A64D0);
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      primary: primaryClr,
      brightness: Brightness.light,
      background: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: darkGreyClr,
      brightness: Brightness.dark,
      background: darkHeaderClr,
    ),
  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.grey[400]:Colors.grey[400],
    ),
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.white:Colors.black,
    ),
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.white:Colors.black,
    ),
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode?Colors.grey[100]:Colors.grey[600],
    ),
  );
}
