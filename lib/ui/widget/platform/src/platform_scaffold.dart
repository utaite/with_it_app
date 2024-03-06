import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/widget/widget.dart';

final class PlatformScaffold extends StatelessWidget {
  const PlatformScaffold({
    required this.body,
    super.key,
    this.backgroundColor,
    this.appBar,
    this.floatingActionButton,
    this.androidBottomNavigationBar,
    this.iosBottomNavigationBar,
  });

  final Color? backgroundColor;
  final PlatformAppBar? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final BottomNavigationBar? androidBottomNavigationBar;
  final CupertinoTabBar? iosBottomNavigationBar;

  @override
  Widget build(BuildContext context) => PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      );

  Widget _buildAndroid(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar is PlatformAppBar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: appBar.elvis,
              )
            : null,
        body: SafeArea(
          child: body,
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: androidBottomNavigationBar,
      );

  Widget _buildIos(BuildContext context) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar is PlatformAppBar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kMinInteractiveDimension),
                child: appBar.elvis,
              )
            : null,
        body: SafeArea(
          child: body,
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: iosBottomNavigationBar,
      );
}
