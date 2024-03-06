import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';

mixin BaseLoadingState implements BaseState {
  bool get isLoading;

  @override
  Status get status {
    if (isLoading) {
      return Status.loading;
    } else if (isActive) {
      return Status.active;
    }

    return Status.empty;
  }
}
