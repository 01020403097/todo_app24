
import 'package:flutter/material.dart';

class AppTheme{
  static Color primary=Color(0xFF5D9CEC);
  static Color backgroundLight=Color(0xFFDFECDB);
  static Color backgroundDark=Color(0xFF060E1E);
  static Color green=Color(0xFF61E757);
  static Color red=Color(0xFFEC4B4B);
  static Color gray=Color(0xFFC8C9CB);
  static Color white=Color(0xFFFFFFFF);


static ThemeData lightTheme=ThemeData(

  primaryColor: primary,
  scaffoldBackgroundColor: backgroundLight,
  appBarTheme: AppBarTheme(backgroundColor: primary)

);
static ThemeData darkTheme=ThemeData();
}