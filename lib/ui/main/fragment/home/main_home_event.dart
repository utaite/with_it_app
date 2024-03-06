import 'package:with_it/base/base.dart';
import 'package:with_it/ui/main/fragment/home/state/main_home_state.dart';

abstract base class MainHomeEvent extends BaseEvent {}

final class InitialEvent extends MainHomeEvent {
  InitialEvent({
    this.state,
  });

  final MainHomeState? state;

  @override
  List<Object?> get props => [state];
}

final class UntilPopEvent extends MainHomeEvent {}
