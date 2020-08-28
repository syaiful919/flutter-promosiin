import 'package:flutter/material.dart';

class ProjectColor {
  static const Color main = Color(0xff4cbbb9);
  static const Color white1 = Colors.white;
  static const Color black1 = Colors.black;
  static const Color black2 = Color(0xff545454); // text
  static const Color red1 = Colors.red;
  static const Color red2 = Color(0xfffb2f2f); // alert
  static const Color grey1 = Colors.grey;
  static const Color grey2 = Color(0xFFD5D5D5); // shadow
}

class Gap {
  static const double zero = 0;
  static const double xxs = 2;
  static const double xs = 4;
  static const double s = 8;
  static const double m = 16;
  static const double l = 32;
  static const double xl = 48;
}

class TypoSize {
  static const double head = 20;
  static const double title = 16;
  static const double paragraph = 14;
  static const double caption = 12;
}

class TypoStyle {
  static const pageTitle = TextStyle(
    color: ProjectColor.white1,
    fontSize: TypoSize.title,
  );
  static const sectionLabel = TextStyle(
    color: ProjectColor.black1,
    fontSize: TypoSize.title,
  );
  static const paragraph = TextStyle(
    color: ProjectColor.black2,
    fontSize: TypoSize.paragraph,
  );
  static const caption = TextStyle(
    color: ProjectColor.black2,
    fontSize: TypoSize.caption,
  );
  static const mainButton = TextStyle(
    color: ProjectColor.white1,
    fontSize: TypoSize.title,
  );
  static const placeholder = TextStyle(
    color: ProjectColor.grey2,
    fontSize: TypoSize.paragraph,
  );
}

class IconSize {
  static const double s = 18;
  static const double m = 24;
  static const double l = 36;
  static const double xl = 48;
}

class RadiusSize {
  static const double s = 4;
  static const double m = 8;
}

ThemeData projectTheme = ThemeData(
  fontFamily: 'Poppins',
  primaryColor: ProjectColor.main,
  backgroundColor: ProjectColor.white1,
  scaffoldBackgroundColor: ProjectColor.white1,
  iconTheme: IconThemeData(
    color: ProjectColor.main,
    size: IconSize.m,
  ),
  hintColor: ProjectColor.grey2,
  errorColor: ProjectColor.red2,
);
