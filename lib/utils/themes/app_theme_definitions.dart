import 'package:flutter/material.dart';
import 'app_theme_colors.dart';

final ThemeData lightTheme = ThemeData(
  fontFamily: "Montserrat",
  scaffoldBackgroundColor: appWhite,
  primaryColor: Colors.blue,
  primaryColorDark: Colors.white,
  errorColor: Colors.red,
  hoverColor: Colors.white54,
  dividerColor: appDividerColor,
  appBarTheme: const AppBarTheme(
    color: appLayoutBackground,
    iconTheme: IconThemeData(color: appTextColorPrimary),
  ),
  cardTheme: const CardTheme(color: Colors.white),
  iconTheme: const IconThemeData(color: appTextColorPrimary),
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: appWhite),
  textTheme: const TextTheme(
    headline6: TextStyle(color: appTextColorPrimary),
    subtitle2: TextStyle(color: appTextColorSecondary),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: ZoomPageTransitionsBuilder(),
      TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
    }));
