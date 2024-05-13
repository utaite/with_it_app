import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/app/app_cubit.dart';
import 'package:with_it/ui/app/app_state.dart';

final class ToggleThemeBuilder extends StatelessWidget {
  const ToggleThemeBuilder({
    required this.builder,
    super.key,
  });

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => BlocSelector<AppCubit, AppState, Brightness>(
        selector: (state) => state.brightness,
        builder: (context, brightness) => Theme(
          data: brightness.toggle.theme,
          child: Builder(
            builder: builder,
          ),
        ),
      );
}
