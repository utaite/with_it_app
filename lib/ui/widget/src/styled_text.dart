import 'package:flutter/material.dart';

final class StyledText extends StatelessWidget {
  const StyledText({
    this.style,
    this.builder,
    this.children,
    super.key,
  });

  final TextStyle? style;
  final List<InlineSpan> Function(TextStyle style)? builder;
  final List<InlineSpan>? children;

  @override
  Widget build(BuildContext context) => Text.rich(
        TextSpan(
          children: builder?.call(style ?? const TextStyle()) ?? children ?? const [],
        ),
        style: style,
      );
}
