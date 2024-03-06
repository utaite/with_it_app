import 'package:flutter/material.dart';

mixin BaseMixin {
  BuildContext get context;

  void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).unfocus();
  }

  void nextFocus([_]) {
    FocusScope.of(context).nextFocus();
  }

  void pop<T>([T? result]) {
    Navigator.of(context).pop(result);
  }
}
