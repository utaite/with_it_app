import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/widget/widget.dart';

final class PlatformButton extends StatelessWidget {
  const PlatformButton({
    required this.icon,
    super.key,
    this.onPressed,
    this.size = Values.iconSize,
  });

  final VoidCallback? onPressed;
  final double size;
  final Widget icon;

  @override
  Widget build(BuildContext context) => PlatformWidget(
        androidBuilder: (context) => IconButton(
          onPressed: onPressed,
          padding: Paddings.paddingAll12,
          splashRadius: Paddings.paddingValue24,
          iconSize: size,
          constraints: const BoxConstraints(),
          icon: icon,
        ),
        iosBuilder: (context) => CupertinoButton(
          onPressed: onPressed,
          padding: EdgeInsetsDirectional.zero,
          child: IconTheme(
            data: Theme.of(context).iconTheme.copyWith(
                  size: size,
                ),
            child: icon,
          ),
        ),
      );
}
