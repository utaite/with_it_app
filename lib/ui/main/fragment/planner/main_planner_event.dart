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

final class ChangedRangeEvent extends MainPlannerEvent {
  ChangedRangeEvent({
    required this.start,
    required this.end,
    required this.focusedDay,
  });

  final DateTime? start;
  final DateTime? end;
  final DateTime focusedDay;

  @override
  List<Object?> get props => [start, end, focusedDay];
}

final class UntilPopEvent extends MainPlannerEvent {}
