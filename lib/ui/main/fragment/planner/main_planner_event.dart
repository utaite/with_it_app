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

final class ChangedFocusedDayEvent extends MainPlannerEvent {
  ChangedFocusedDayEvent({
    required this.selectedDay,
    required this.focusedDay,
  });

  final DateTime selectedDay;
  final DateTime focusedDay;

  @override
  List<Object?> get props => [selectedDay, focusedDay];
}

final class ReadEvent extends MainPlannerEvent {}

final class UntilPopEvent extends MainPlannerEvent {}
