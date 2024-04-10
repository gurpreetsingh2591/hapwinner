import 'package:flutter/material.dart';

import '../utils/themes/colors.dart';

class Colours {
  static const primary = Colors.white;
  static const backgroundDark = Color(0xff130233);
  static const backgroundLight = Color(0xff1a0541);
  static const accent = Color(0xffac42fe);
}

final mainTheme = ThemeData(

  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'poppins',
  primaryColor: appBaseColor,
  //appBarTheme: appTheme,

  colorScheme: const ColorScheme(

    background: Colours.primary,
    onBackground: Colours.primary,
    brightness: Brightness.dark,
    primary: appBaseColor,
    onPrimary: appBaseColor,
    secondary: Colours.primary,
    onSecondary: appBaseColor,
    error: Colors.red,
    onError: Colors.black87,
    surface: Colours.backgroundLight,
    onSurface: Colours.primary,

  ).copyWith(background: Colors.white),
  // textTheme: const TextTheme(
  //   headline1: TextStyle(color: Colours.primary),
  //   bodyText1: TextStyle(color: Colours.primary),
  //   bodyText2: TextStyle(color: Colours.primary),
  //   headline6: TextStyle(color: Colours.primary),
  //   subtitle1: TextStyle(color: Colours.primary),
  //   subtitle2: TextStyle(color: Colours.primary),
  //   caption: TextStyle(color: Colours.primary),
  // ),
);

const appTheme = AppBarTheme(
  color: appBaseColor,
);