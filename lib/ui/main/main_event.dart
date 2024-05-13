import 'package:with_it/base/base.dart';
import 'package:with_it/ui/main/state/main_state.dart';

abstract base class MainEvent extends BaseEvent {}

final class InitialEvent extends MainEvent {
  InitialEvent({
    this.state,
  });

  final MainState? state;

  @override
  List<Object?> get props => [state];
}

final class ChangedIndexEvent extends MainEvent {
  ChangedIndexEvent({
    required this.index,
  });

  final int index;

  @override
  List<Object?> get props => [index];
}

final class SignInEvent extends MainEvent {
  SignInEvent({
    required this.deviceToken,
  });

  final String deviceToken;

  @override
  List<Object?> get props => [deviceToken];
}
