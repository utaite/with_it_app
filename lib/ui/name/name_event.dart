import 'package:with_it/base/base.dart';
import 'package:with_it/ui/name/state/name_state.dart';

abstract base class NameEvent extends BaseEvent {}

final class InitialEvent extends NameEvent {
  InitialEvent({
    this.state,
  });

  final NameState? state;

  @override
  List<Object?> get props => [state];
}

final class ChangedNameEvent extends NameEvent {
  ChangedNameEvent({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => [name];
}

final class PressedConfirmEvent extends NameEvent {}
