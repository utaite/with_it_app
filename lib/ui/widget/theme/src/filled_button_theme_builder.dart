import 'package:flutter/material.dart';

final class FilledButtonThemeBuilder extends StatelessWidget {
  const FilledButtonThemeBuilder({
    required this.filledButtonTheme,
    required this.builder,
    super.key,
  });

  final FilledButtonThemeData filledButtonTheme;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          filledButtonTheme: filledButtonTheme,
        ),
        child: Builder(
          builder: builder,
        ),
      );
}
