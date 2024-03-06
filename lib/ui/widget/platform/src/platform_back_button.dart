import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:with_it/ui/widget/widget.dart';

final class PlatformBackButton extends StatelessWidget {
  const PlatformBackButton({
    super.key,
    this.onPressed,
    this.color,
  });

  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final onPressed = this.onPressed ?? () async => Navigator.of(context).maybePop();

    return PlatformWidget(
      androidBuilder: (context) => PlatformButton(
        onPressed: onPressed,
        icon: Icon(
          Icons.arrow_back,
          color: color,
        ),
      ),
      iosBuilder: (context) => CupertinoNavigationBarBackButton(
        onPressed: onPressed,
        color: color ?? Theme.of(context).iconTheme.color,
      ),
    );
  }
}
