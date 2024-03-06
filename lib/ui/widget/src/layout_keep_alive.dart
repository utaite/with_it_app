import 'package:flutter/material.dart';

final class LayoutKeepAlive extends StatefulWidget {
  const LayoutKeepAlive({
    required this.child,
    super.key,
    this.wantKeepAlive = true,
  });

  final Widget child;
  final bool wantKeepAlive;

  @override
  State<LayoutKeepAlive> createState() => _LayoutKeepAliveState();
}

final class _LayoutKeepAliveState extends State<LayoutKeepAlive> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;
}
