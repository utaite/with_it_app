import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:with_it/model/model.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/widget/widget.dart';

final class PlatformApp extends StatelessWidget {
  const PlatformApp({
    required this.routes,
    required this.initialRoute,
    required this.title,
    required this.brightness,
    required this.cupertinoThemeData,
    required this.locale,
    required this.localizationsDelegates,
    required this.supportedLocales,
    required this.debugShowCheckedModeBanner,
    super.key,
  });

  final Map<String, WidgetBuilder> routes;
  final RouteModel initialRoute;
  final String title;
  final Brightness? brightness;
  final CupertinoThemeData cupertinoThemeData;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;
  final bool? debugShowCheckedModeBanner;

  @override
  Widget build(BuildContext context) => PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      );

  Widget _buildAndroid(BuildContext context) => MaterialApp(
        routes: routes,
        initialRoute: initialRoute.routeName,
        title: title,
        theme: Brightness.light.theme,
        darkTheme: Brightness.dark.theme,
        themeMode: brightness.themeMode,
        localizationsDelegates: localizationsDelegates,
        locale: locale,
        supportedLocales: supportedLocales,
        debugShowCheckedModeBanner: false,
      );

  Widget _buildIos(BuildContext context) => CupertinoTheme(
        data: cupertinoThemeData,
        child: _buildAndroid(context),
      );
}
