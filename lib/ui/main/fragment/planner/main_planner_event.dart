import 'package:with_it/base/base.dart';
import 'package:with_it/ui/main/fragment/planner/state/main_planner_state.dart';

abstract base class MainPlannerEvent extends BaseEvent {}

final class InitialEvent extends MainPlannerEvent {
  InitialEvent({
    this.state,
  });

  final MainPlannerState? state;

  @override
  List<Object?> get props => [state];
}

final class UntilPopEvent extends MainPlannerEvent {}
