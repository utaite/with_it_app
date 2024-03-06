import 'package:with_it/module/module.dart';

mixin BaseState {
  bool get isActive => false;

  bool get isListen => false;

  bool get isWillPop => true;

  Status get status {
    if (isActive) {
      return Status.active;
    }

    return Status.empty;
  }
}
