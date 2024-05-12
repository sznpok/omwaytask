import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

const borderRadius = 8.0;

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: primaryLightColor,
    iconTheme: IconThemeData(
      color: primaryLightColor,
    ),
    brightness: Brightness.light,
    primaryColorLight: primaryLightColor,
    shadowColor: shadowColor,
    appBarTheme: AppBarTheme(
      color: primaryLightColor,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: cardLightColor,
          ),
    ),
    textTheme: TextTheme(
      bodyLarge: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: textLightColor),
      bodyMedium: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: textLightColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLightColor,
        foregroundColor: cardLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: Theme.of(context).textTheme.bodyLarge!,
      ),
    ),
    hintColor: hintLightColor,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      backgroundColor: primaryLightColor,
      foregroundColor: cardLightColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: secondaryLightColor,
          ),
    )),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: primaryLightColor,
      fillColor: primaryLightColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: cardLightColor,
      backgroundColor: primaryLightColor,
    ),
    cardTheme: CardTheme(color: cardLightColor),
    useMaterial3: true,
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData(
    appBarTheme: AppBarTheme(
      color: preDarkColor,
      titleTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: cardLightColor,
          ),
    ),
    cardColor: primaryDarkColor,
    iconTheme: IconThemeData(
      color: primaryDarkColor,
    ),
    brightness: Brightness.dark,
    primaryColor: primaryDarkColor,
    shadowColor: shadowColor,
    primaryColorDark: primaryDarkColor,
    textTheme: TextTheme(
      bodyLarge:
          Theme.of(context).textTheme.bodyLarge!.copyWith(color: textDarkColor),
      bodyMedium: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: textDarkColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryDarkColor,
        foregroundColor: cardLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: Theme.of(context).textTheme.bodyLarge!,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLightColor,
        foregroundColor: cardLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        textStyle: Theme.of(context).textTheme.bodyLarge!,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: primaryLightColor,
      filled: true,
      fillColor: preDarkColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: primaryDarkColor,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: primaryDarkColor,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Theme.of(context).disabledColor,
        ),
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: cardDarkColor,
      backgroundColor: primaryDarkColor,
    ),
    cardTheme: CardTheme(color: preDarkColor),
    useMaterial3: true,
  );
}
