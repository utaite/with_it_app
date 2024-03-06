import 'package:flutter/material.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/model/model.dart';
import 'package:with_it/module/module.dart';

mixin BaseNavigatorMixin on BaseMixin {
  Map<String, WidgetBuilder> get fragments;

  Map<RouteModel, GlobalKey<NavigatorState>> get navigatorKeys => const {};

  Route<dynamic>? onGenerateRoute(RouteSettings settings, [int? index]) {
    debugPrint('[$runtimeType] onGenerateRoute name: ${settings.name}');
    if (fragments.containsKey(settings.name)) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => (fragments[settings.name]?.call(context)).elvis,
      );
    }

    return null;
  }

  GlobalKey<NavigatorState>? getNavigatorKey(RouteModel route) {
    navigatorKeys.putIfAbsent(route, GlobalKey<NavigatorState>.new);

    return navigatorKeys[route];
  }
}
