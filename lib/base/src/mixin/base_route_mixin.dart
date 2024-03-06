import 'dart:async';

import 'package:flutter/material.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/model/model.dart';

mixin BaseRouteMixin on BaseMixin {
  Future<T?> toNamed<T>(RouteModel route, {bool rootNavigator = false, Object? arguments}) async =>
      Navigator.of(context, rootNavigator: rootNavigator).pushNamed<T>(route.routeName, arguments: arguments);

  Future<T?> offNamed<T>(RouteModel route, {bool rootNavigator = false, Object? arguments}) async =>
      Navigator.of(context, rootNavigator: rootNavigator).pushReplacementNamed<T, T>(route.routeName, arguments: arguments);

  Future<T?> offAllNamed<T>(RouteModel route, {bool rootNavigator = false, Object? arguments}) async =>
      Navigator.of(context, rootNavigator: rootNavigator).pushNamedAndRemoveUntil<T>(route.routeName, (_) => false, arguments: arguments);

  Future<void> onListenUntilPop<T>(BuildContext context, BaseState state) async {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
