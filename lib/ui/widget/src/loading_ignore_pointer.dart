import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/base/base.dart';

final class LoadingIgnorePointer<B extends StateStreamable<S>, S extends BaseLoadingState> extends StatelessWidget {
  const LoadingIgnorePointer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => BlocSelector<B, S, bool>(
        selector: (state) => state.isLoading,
        builder: (context, ignoring) => IgnorePointer(
          ignoring: ignoring,
          child: child,
        ),
      );
}
