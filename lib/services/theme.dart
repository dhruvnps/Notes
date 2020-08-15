import 'package:flutter/material.dart';

String fontFamily = 'Avenir';

// color of cursor, handle, and fab
Color mainColor = Color(0xff40bf7a);

Color fadedTextColor = Colors.grey[400];
Color textColor = Colors.white;
Color appBarColor = Colors.grey[900];
Color backgroundColor = Color(0xff191919);
Color accentColor = Colors.grey[700];
Color highlightColor = Color(0x10ffffff);
Color splashColor = Color(0x15ffffff);

// refrenced by textField() in editor.dart
Color cursorColor = mainColor;

ThemeData darkTheme = ThemeData.dark().copyWith(
  canvasColor: appBarColor,
  textSelectionHandleColor: mainColor,
  textSelectionColor: accentColor,
  highlightColor: highlightColor,
  splashColor: splashColor,
  accentColor: accentColor,
  textTheme: TextTheme(
    subtitle2: TextStyle(
      color: fadedTextColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: fontFamily,
    ),

    // NOTE: default for editor info tab text
    bodyText2: TextStyle(
      color: textColor,
      fontSize: 16,
      fontFamily: fontFamily,
    ),

    // italicised subtitle1
    bodyText1: TextStyle(
      color: textColor,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: fontFamily,
      fontStyle: FontStyle.italic,
    ),

    // NOTE: also default for editor text theme
    subtitle1: TextStyle(
      color: textColor,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: fontFamily,
    ),

    headline5: TextStyle(
      fontWeight: FontWeight.normal,
      fontFamily: fontFamily,
      letterSpacing: 2,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: mainColor,
  ),
  appBarTheme: AppBarTheme(
    color: appBarColor,
  ),
  scaffoldBackgroundColor: backgroundColor,
);
