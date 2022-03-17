import 'package:flutter/material.dart';
import 'package:hilmy/constants/app_colors.dart';
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: kLightGreen,
  primaryColorBrightness: Brightness.light,
  canvasColor: kLightDark,
  splashColor: kLightGreen,
  backgroundColor: kLightGrey,
  // accentColor: Color(0xff457BE0),
  // accentColorBrightness: Brightness.light,
  scaffoldBackgroundColor: kWhite,
  bottomAppBarColor: Color(0xff6D42CE),
  cardColor: Color(0xaaF5E0C3),
  dividerColor: Color(0x1f6D42CE),
  focusColor: Color(0x1aF5E0C3),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: Color(0xff5D4524),
  primaryColorBrightness: Brightness.dark,
  primaryColorLight: Color(0x1a311F06),
  primaryColorDark: Color(0xff936F3E),
  canvasColor: kWhite,
  backgroundColor: kDarkBlack,
  // accentColor: Color(0xff457BE0),
  // accentColorBrightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xffB5BFD3),
  bottomAppBarColor: Color(0xff6D42CE),
  cardColor: Color(0xaa311F06),
  dividerColor: Color(0x1f6D42CE),
  focusColor: Color(0x1a311F06),
);
