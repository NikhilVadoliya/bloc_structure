import 'package:bloc_structure/core/theme/app_colour.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: LightThemeColor.primaryColor,
  primaryColorLight: LightThemeColor.primaryColorLight,
  primaryColorDark: LightThemeColor.primaryColorDark,
  canvasColor: LightThemeColor.backgroundColor,
  scaffoldBackgroundColor: LightThemeColor.backgroundColor,
  cardColor: LightThemeColor.backgroundColor,
  dividerColor: LightThemeColor.disableColor,
  highlightColor: LightThemeColor.highlightColor,
  splashColor: LightThemeColor.splashColor,
  appBarTheme: const AppBarTheme(backgroundColor: LightThemeColor.appColor),
  disabledColor: LightThemeColor.disableColor,
  dialogBackgroundColor: LightThemeColor.backgroundColor,
  indicatorColor: LightThemeColor.primaryColor,
  hintColor: LightThemeColor.textColor.withOpacity(0.5),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    minWidth: 88,
    height: 36,
    padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xff000000),
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
    alignedDropdown: false,
    buttonColor: LightThemeColor.appColor,
    disabledColor: LightThemeColor.disableColor,
    highlightColor: LightThemeColor.highlightColor,
    splashColor: LightThemeColor.splashColor,
    focusColor: LightThemeColor.focusColor,
    hoverColor: LightThemeColor.hoverColor,
  ),
  textSelectionTheme: TextSelectionThemeData(
      cursorColor: LightThemeColor.primaryColorDark,
      selectionColor: LightThemeColor.primaryColorDark.withOpacity(0.5)),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: LightThemeColor.textColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: LightThemeColor.textColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: LightThemeColor.textColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: LightThemeColor.textColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    isDense: false,
    contentPadding: EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 0),
    isCollapsed: false,
    prefixStyle: TextStyle(
      color: LightThemeColor.textColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: LightThemeColor.textColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: LightThemeColor.textColor,
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: false,
    fillColor: LightThemeColor.textColor,
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff000000),
        width: 1,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xdd000000),
    opacity: 1,
    size: 24,
  ),
  primaryIconTheme: const IconThemeData(
    color: LightThemeColor.backgroundColor,
    opacity: 1,
    size: 24,
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: LightThemeColor.textColor,
    unselectedLabelColor: LightThemeColor.secondaryColor.withOpacity(0.5),
  ),
  dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
    side: BorderSide(
      color: LightThemeColor.secondaryColor,
      width: 0,
      style: BorderStyle.none,
    ),
    borderRadius: BorderRadius.all(Radius.circular(0.0)),
  )),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return LightThemeColor.appColor;
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return LightThemeColor.appColor;
      }
      return null;
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return LightThemeColor.appColor;
      }
      return null;
    }),
    trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return LightThemeColor.appColor;
      }
      return null;
    }),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(color: LightThemeColor.backgroundColor),
  colorScheme: ColorScheme.fromSwatch(brightness: Brightness.light).copyWith(
    error: LightThemeColor.errorColor,
  ),
);
