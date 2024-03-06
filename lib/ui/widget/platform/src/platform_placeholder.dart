import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/widget/widget.dart';

final class PlatformPlaceholder extends StatelessWidget {
  const PlatformPlaceholder({
    super.key,
    this.wrap = false,
    this.widgetSize = Values.placeholderWidgetSize,
    this.indicatorSize = Values.placeholderIndicatorSize,
    this.color,
  });

  final bool wrap;
  final double widgetSize;
  final double indicatorSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final child = Center(
      child: SizedBox(
        height: widgetSize,
        width: widgetSize,
        child: PlatformWidget(
          androidBuilder: _buildAndroid,
          iosBuilder: _buildIos,
        ),
      ),
    );

    return wrap ? child : Center(child: child);
  }

  Widget _buildAndroid(BuildContext context) => CircularProgressIndicator(
        color: color,
        strokeWidth: indicatorSize,
      );

  Widget _buildIos(BuildContext context) => CupertinoActivityIndicator(
        color: color,
        radius: min(Values.radiusValue, widgetSize),
      );
}
