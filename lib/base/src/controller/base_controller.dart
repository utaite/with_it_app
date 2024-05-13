import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';

abstract base class BaseController<B extends StateStreamable<S>, S extends BaseState> with BaseMixin {
  B get bloc => context.read();

  S get state => bloc.state;

  void onPopInvoked(bool didPop) {
    if (!didPop && onWillPop()) {
      if (Navigator.of(context).canPop()) {
        super.pop();
      } else {
        unawaited(SystemNavigator.pop());
      }
    }
  }

  bool onWillPop() => state.isWillPop;

  bool listenWhen(S previous, S current) => current.isActive && current.isListen;

  bool listenWhenError(S previous, S current) => previous is! BaseErrorLoadingState && current is BaseErrorLoadingState;

  bool buildWhen(S previous, S current) => previous.status != current.status;

  Future<void> onListenError(BuildContext context, S state) async {
    if (state is BaseErrorLoadingState && state.error.isTypeDialog) {
      debugPrint('ERROR');
      await context.showDialog(
        title: state.error.title,
        content: state.error.content,
      );
    }
  }

  void onListenPop(BuildContext context, S state) {
    super.pop(true);
  }

  void onListenStatePop(BuildContext context, S state) {
    super.pop(state);
  }
}
