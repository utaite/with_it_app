import 'package:flutter/material.dart';

final class OutlinedButtonThemeBuilder extends StatelessWidget {
  const OutlinedButtonThemeBuilder({
    required this.outlinedButtonTheme,
    required this.builder,
    super.key,
  });

  final OutlinedButtonThemeData outlinedButtonTheme;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          outlinedButtonTheme: outlinedButtonTheme,
        ),
        child: Builder(
          builder: builder,
        ),
      );
}
