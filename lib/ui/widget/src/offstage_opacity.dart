import 'package:flutter/material.dart';
import 'package:with_it/module/module.dart';

final class OffstageOpacity extends StatelessWidget {
  const OffstageOpacity({
    required this.child,
    super.key,
    bool offstage = false,
    double? opacity,
  }) : value = opacity ?? (offstage ? 1 : 0);

  final double value;
  final Widget child;

  @override
  Widget build(BuildContext context) => Offstage(
        offstage: value.isNotPositive,
        child: Opacity(
          opacity: value.tween,
          child: child,
        ),
      );
}
