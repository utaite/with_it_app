import 'package:flutter/material.dart';
import 'package:with_it/module/module.dart';

extension ThemeDataExV2 on ThemeData {
  Color get _scaffoldBackgroundColor => brightness.isDark ? Colors.grey[900].elvis : Colors.white;

  Color get _foregroundColor => brightness.isDark ? Colors.white : Colors.black;

  ThemeData applyTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: (brightness.isDark ? const ColorScheme.dark() : const ColorScheme.light()).copyWith(
          primary: Resource.colorPrimary,
          secondary: Resource.colorPrimary,
          onPrimary: Resource.colorPrimary,
          onSecondary: Resource.colorPrimary,
        ),
        primaryColor: Resource.colorPrimary,
        primaryColorDark: Resource.colorPrimary,
        scaffoldBackgroundColor: _scaffoldBackgroundColor,
        fontFamily: Font.pretendard,
        appBarTheme: _appBarTheme,
        bottomNavigationBarTheme: _bottomNavigationBarTheme,
        textTheme: _textTheme,
      );

  AppBarTheme get _appBarTheme => AppBarTheme(
        backgroundColor: _scaffoldBackgroundColor,
        foregroundColor: _foregroundColor,
        elevation: 0,
        titleTextStyle: _textTheme.titleMedium?.copyWith(
          color: _foregroundColor,
          fontWeight: FontWeight.w600,
          fontFamily: Font.pretendard,
        ),
      );

  BottomNavigationBarThemeData get _bottomNavigationBarTheme => BottomNavigationBarThemeData(
        selectedItemColor: _foregroundColor,
        unselectedItemColor: Resource.colorGrey,
        selectedLabelStyle: _textTheme.labelLarge?.copyWith(
          color: _foregroundColor,
        ),
        unselectedLabelStyle: _textTheme.labelLarge,
        type: BottomNavigationBarType.fixed,
      );

  FilledButtonThemeData get _filledButtonTheme => FilledButtonThemeData(
        style: FilledButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Resource.colorPrimary,
          disabledForegroundColor: Colors.white,
          disabledBackgroundColor: Resource.colorPrimary.withOpacity(3.div(10)),
          padding: Paddings.paddingAll16,
          shape: const RoundedRectangleBorder(),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      );

  FilledButtonThemeData get _uncoloredFilledButtonTheme {
    final style = FilledButton.styleFrom(
      foregroundColor: Resource.colorGrey[S.s800.s],
      backgroundColor: Resource.colorGrey[S.s100.s],
    );

    return FilledButtonThemeData(
      style: _filledButtonTheme.style?.copyWith(
        foregroundColor: style.foregroundColor,
        backgroundColor: style.backgroundColor,
      ),
    );
  }

  TextTheme get _textTheme => TextTheme(
        headlineLarge: brightness.isDark ? Styles.textWhite32 : Styles.textGrey32,
        headlineMedium: brightness.isDark ? Styles.textWhite28 : Styles.textGrey28,
        headlineSmall: brightness.isDark ? Styles.textWhite24 : Styles.textGrey24,
        titleLarge: brightness.isDark ? Styles.textWhite18 : Styles.textGrey18,
        titleMedium: brightness.isDark ? Styles.textWhite16 : Styles.textGrey16,
        titleSmall: brightness.isDark ? Styles.textWhite14 : Styles.textGrey14,
        labelLarge: brightness.isDark ? Styles.textWhite12 : Styles.textGrey12,
        labelMedium: brightness.isDark ? Styles.textWhite10 : Styles.textGrey10,
        labelSmall: brightness.isDark ? Styles.textWhite8 : Styles.textGrey8,
      );

  FilledButtonThemeData isColoredFilledButtonTheme({required bool isColored}) => isColored ? _filledButtonTheme : _uncoloredFilledButtonTheme;

  FilledButtonThemeData redFilledButtonTheme() {
    final style = FilledButton.styleFrom(
      backgroundColor: Resource.colorRed,
      disabledBackgroundColor: Resource.colorRed.withOpacity(3.div(10)),
    );

    return FilledButtonThemeData(
      style: _filledButtonTheme.style?.copyWith(
        backgroundColor: style.backgroundColor,
      ),
    );
  }

  TextStyle? filledButtonTextStyle() => _textTheme.titleSmall?.copyWith(
        color: filledButtonTheme.style?.foregroundColor?.resolve(MaterialState.values.toSet()),
        fontWeight: FontWeight.w600,
      );
}
