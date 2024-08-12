
import 'package:flutter/material.dart';

class AppTheme{
  static Color primary=Color(0xFF5D9CEC);
  static Color backgroundLight=Color(0xFFDFECDB);
  static Color backgroundDark=Color(0xFF060E1E);
  static Color green=Color(0xFF61E757);
  static Color red=Color(0xFFEC4B4B);
  static Color gray=Color(0xFFC8C9CB);
  static Color white=Color(0xFFFFFFFF);
  static Color black=Color(0xFF000000);


static ThemeData lightTheme=ThemeData(

  primaryColor: primary,
  scaffoldBackgroundColor: backgroundLight,
  appBarTheme: AppBarTheme(backgroundColor: primary),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: white,
    type: BottomNavigationBarType.fixed,
    selectedItemColor:primary,
  unselectedItemColor: gray,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  elevation: 0,),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primary,
    foregroundColor: white,
    shape: CircleBorder(side: BorderSide(width: 4,color: white),),),
  textTheme: TextTheme(
    titleMedium: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: black),
    titleSmall: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: black),),
  elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
    backgroundColor: primary,),),

);
static ThemeData darkTheme=ThemeData();
}