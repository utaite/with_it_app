import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/app/app_cubit.dart';
import 'package:with_it/ui/app/app_state.dart';

final class PlatformWidget extends StatelessWidget {
  const PlatformWidget({
    super.key,
    this.androidBuilder,
    this.iosBuilder,
  });

  final WidgetBuilder? androidBuilder;
  final WidgetBuilder? iosBuilder;

  @override
  Widget build(BuildContext context) => BlocSelector<AppCubit, AppState, TargetPlatform>(
        selector: (state) => state.platform,
        builder: (context, platform) {
          final widgetBuilder = {
            TargetPlatform.android: androidBuilder,
            TargetPlatform.iOS: iosBuilder,
          };

          return (widgetBuilder[platform]?.call(context)).elvis;
        },
      );
}
