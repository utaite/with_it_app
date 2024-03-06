import 'package:flutter/material.dart';
import 'package:with_it/ui/widget/widget.dart';

final class PlatformButtonPlaceholder extends StatelessWidget {
  const PlatformButtonPlaceholder({
    required this.isLoading,
    required this.child,
    super.key,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          if (isLoading)
            PlatformPlaceholder(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          Opacity(
            opacity: isLoading ? 0 : 1,
            child: child,
          ),
        ],
      );
}
