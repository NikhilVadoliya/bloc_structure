import 'package:bloc_structure/core/theme/dart_theme_colors.dart';
import 'package:bloc_structure/core/theme/light_theme_colors.dart';
import 'package:bloc_structure/core/utils.dart';
import 'package:flutter/material.dart';

class ThemeResource {
  static var fontType = getFontFamilyType(FontFamilyType.openSans);

  //DarkTheme
  //TODO: change your dark theme according to your Ui
  final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: DarkThemeColors.backgroundColor,
    backgroundColor: DarkThemeColors.textBoxColor,
    brightness: Brightness.dark,
    primaryColor: DarkThemeColors.primaryColor,
    secondaryHeaderColor: DarkThemeColors.secondaryColor,
    dividerColor: DarkThemeColors.dividerColor,
    fontFamily: fontType,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: DarkThemeColors.primaryColor,
      onSecondary: DarkThemeColors.secondaryColor.withOpacity(0.80),
      onError: DarkThemeColors.errorColor.withOpacity(0.80),
      onPrimary: DarkThemeColors.primaryColor.withOpacity(0.80),
      background: DarkThemeColors.backgroundColor,
      surface: DarkThemeColors.backgroundColor,
      secondary: DarkThemeColors.secondaryColor,
      error: DarkThemeColors.errorColor,
      onBackground: DarkThemeColors.backgroundColor.withOpacity(0.80),
      onSurface: DarkThemeColors.backgroundColor.withOpacity(0.80),
      primaryContainer: DarkThemeColors.textPrimary,
      secondaryContainer: DarkThemeColors.textSecondary,
      onTertiaryContainer: DarkThemeColors.primaryColor,
      outline: DarkThemeColors.dividerColor,
    ),
    // border color
    buttonTheme: ButtonThemeData(
      buttonColor: DarkThemeColors.primaryColor,
      disabledColor: DarkThemeColors.textDisabled,
      focusColor: DarkThemeColors.secondaryColor,
    ),
  );

  //Light Theme
  //TODO: change your light theme according to your Ui
  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: LightThemeColors.backgroundColor,
    brightness: Brightness.light,
    primaryColor: LightThemeColors.primaryColor,
    secondaryHeaderColor: LightThemeColors.secondaryColor,
    dividerColor: LightThemeColors.dividerColor,
    backgroundColor: LightThemeColors.textBoxColor,
    fontFamily: fontType,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: LightThemeColors.primaryColor,
      onSecondary: LightThemeColors.secondaryColor.withOpacity(0.80),
      onError: LightThemeColors.errorColor.withOpacity(0.80),
      onPrimary: LightThemeColors.primaryColor.withOpacity(0.80),
      background: LightThemeColors.backgroundColor,
      surface: LightThemeColors.backgroundColor,
      secondary: LightThemeColors.secondaryColor,
      error: LightThemeColors.errorColor,
      onBackground: LightThemeColors.backgroundColor.withOpacity(0.80),
      onSurface: LightThemeColors.backgroundColor.withOpacity(0.80),
      primaryContainer: LightThemeColors.textPrimary,
      secondaryContainer: LightThemeColors.textSecondary,
      onTertiaryContainer: LightThemeColors.textDisabled,
      outline: LightThemeColors.dividerColor,
    ),
    // border color
    buttonTheme: ButtonThemeData(
        buttonColor: LightThemeColors.primaryColor,
        disabledColor: LightThemeColors.textDisabled,
        focusColor: LightThemeColors.secondaryColor),
  );
}
