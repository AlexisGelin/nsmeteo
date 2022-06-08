import 'package:flutter/material.dart';

//Couleurs des textes
const normalTextColor = Color.fromRGBO(255, 255, 255, 1);
const placeholderColor = Color.fromRGBO(151, 186, 208, 1);

//Couleurs des fonds
const primaryColor = Color.fromRGBO(95, 168, 211, 1);
const secondaryColor = Color.fromRGBO(27, 73, 101, 1);
const thirdColor = Color.fromRGBO(202, 233, 255, 1);

const backgroundTransparent = Color.fromRGBO(27, 73, 101, 0.6);
const navbarColor = Color.fromRGBO(108, 165, 205, 1);

ThemeData buildTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    fontFamily: 'DMSans',
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: secondaryColor,
        secondaryContainer: backgroundTransparent,
        tertiary: thirdColor,
        onPrimary: normalTextColor,
        onTertiary: placeholderColor,
        primaryContainer: navbarColor),
    textTheme: Theme.of(context).textTheme.copyWith(
          titleLarge: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 10)
              ],
              color: ColorScheme.fromSwatch().onPrimary),
          titleMedium: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 10)
              ],
              color: ColorScheme.fromSwatch().onPrimary),
          titleSmall: TextStyle(
              fontSize: 24,
              shadows: [
                Shadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 10)
              ],
              color: ColorScheme.fromSwatch().onPrimary),
          headlineMedium:
              TextStyle(fontSize: 16, color: ColorScheme.fromSwatch().tertiary),
          bodyMedium: TextStyle(
              fontSize: 16, color: ColorScheme.fromSwatch().onPrimary),
          labelMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorScheme.fromSwatch().onPrimary),
          labelSmall: const TextStyle(
              fontSize: 16, color: placeholderColor),
        ),
  );
}
