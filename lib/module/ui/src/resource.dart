import 'package:flutter/material.dart';

final class Resource {
  static const MaterialColor colorPrimary = MaterialColor(
    _colorPrimaryValue,
    {
      100: Color(0xFFFAF4FE),
      200: Color(0xFFEDE6FF),
      300: Color(0xFFE8DEF8),
      600: Color(_colorPrimaryValue),
    },
  );
  static const int _colorPrimaryValue = 0xFF7C55E3;

  static const MaterialColor colorGrey = MaterialColor(
    _colorGreyValue,
    {
      100: Color(0xFFF5F5F5),
      200: Color(0xFFDFDFDF),
      300: Color(0xFFCECECE),
      400: Color(0xFFB9B9B9),
      600: Color(_colorGreyValue),
      700: Color(0xFF7A7A7A),
      800: Color(0xFF5C5C5C),
      900: Color(0xFF454545),
    },
  );
  static const int _colorGreyValue = 0xFFA0A0A0;

  static const MaterialColor colorRed = MaterialColor(
    _colorRedValue,
    {
      200: Color(0xFFFF6057),
      400: Color(_colorRedValue),
    },
  );
  static const int _colorRedValue = 0xFFE84135;

  static const MaterialColor colorBlue = MaterialColor(
    _colorBlueValue,
    {
      200: Color(0xFFC6EAFF),
      400: Color(_colorBlueValue),
    },
  );
  static const int _colorBlueValue = 0xFF4EBFFF;

  static const MaterialColor colorYellow = MaterialColor(
    _colorYellowValue,
    {
      200: Color(0xFFFFEF9D),
      400: Color(_colorYellowValue),
    },
  );
  static const int _colorYellowValue = 0xFFFFC224;

  static const MaterialColor colorBlack = MaterialColor(
    _colorBlackValue,
    {
      400: Color(_colorBlackValue),
    },
  );
  static const int _colorBlackValue = 0xFF0D0D0D;
}
