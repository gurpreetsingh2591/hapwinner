import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData lightTheme = ThemeData(
        fontFamily: "form_djr_light",
        scaffoldBackgroundColor: appWhite,
        primaryColor: appPrimaryColor,
        primaryColorDark: Colors.white,
        hoverColor: Colors.white54,
        dividerColor: appLineColor,
        unselectedWidgetColor: textDeselectColor,
        appBarTheme: const AppBarTheme(
          color: appLayoutBackground,
          iconTheme: IconThemeData(color: appPrimaryTextColor),
        ),
        cardTheme: const CardTheme(color: Colors.white),
        iconTheme: const IconThemeData(color: appPrimaryTextColor),
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: appWhite),
        textTheme: const TextTheme(
            bodyLarge: TextStyle(color: appPrimaryTextColor),
            bodyMedium: TextStyle(color: appPrimaryTextColor),
            bodySmall: TextStyle(color: appPrimaryTextColor),
            titleLarge: TextStyle(color: appPrimaryTextColor),
            titleMedium: TextStyle(color: appPrimaryTextColor),
            titleSmall: TextStyle(color: appPrimaryTextColor),
            labelLarge: TextStyle(color: appPrimaryTextColor),
            labelMedium: TextStyle(color: appPrimaryTextColor),
            labelSmall: TextStyle(color: appPrimaryTextColor),
            displayLarge: TextStyle(color: appPrimaryTextColor),
            displayMedium: TextStyle(color: appPrimaryTextColor),
            displaySmall: TextStyle(color: appPrimaryTextColor),
            headlineLarge: TextStyle(color: appPrimaryTextColor),
            headlineMedium: TextStyle(color: appPrimaryTextColor),
            headlineSmall: TextStyle(color: appPrimaryTextColor)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(appPrimaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: BorderSide(color: appLineColor.withOpacity(0.5))))
    .copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: ZoomPageTransitionsBuilder(),
      TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
    }));
