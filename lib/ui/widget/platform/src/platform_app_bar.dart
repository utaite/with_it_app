import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/widget/widget.dart';

final class PlatformAppBar extends StatelessWidget {
  const PlatformAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.elevation = 1,
    this.centerTitle = true,
    this.backgroundColor,
  });

  final Widget? leading;
  final Widget? title;
  final Iterable<Widget>? actions;
  final double elevation;
  final bool centerTitle;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      );

  AppBar _buildAndroid(BuildContext context) => AppBar(
        automaticallyImplyLeading: false,
        leading: leading,
        title: title,
        actions: actions.elvis.isNotEmpty
            ? [
                Paddings.width4,
                ...?actions,
                Paddings.width4,
              ]
            : null,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: centerTitle,
      );

  CupertinoNavigationBar _buildIos(BuildContext context) => CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        leading: leading ?? (!centerTitle ? title : null),
        middle: centerTitle
            ? DefaultTextStyle(
                style: Theme.of(context).appBarTheme.titleTextStyle.elvis,
                child: title.elvis,
              )
            : null,
        trailing: OffstageOpacity(
          offstage: actions.elvis.length.isPositive,
          child: Wrap(
            spacing: Paddings.paddingValue4,
            children: [
              ...actions.elvis,
            ],
          ),
        ),
        border: null,
        backgroundColor: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
        padding: title is Widget && !centerTitle ? const EdgeInsetsDirectional.only(start: Paddings.paddingValue16) : EdgeInsetsDirectional.zero,
      );
}
