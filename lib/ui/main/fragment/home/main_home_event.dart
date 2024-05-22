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

final class ChangedDateTimeEvent extends MainHomeEvent {
  ChangedDateTimeEvent({
    required this.dateTime,
  });

  final DateTime dateTime;

  @override
  List<Object?> get props => [dateTime];
}

final class DeleteEvent extends MainHomeEvent {
  DeleteEvent({
    required this.planId,
  });

  final int planId;

  @override
  List<Object?> get props => [planId];
}

final class ReadEvent extends MainHomeEvent {}

final class UpdateEvent extends MainHomeEvent {
  UpdateEvent({
    required this.planId,
    required this.subjectId,
  });

  final int planId;
  final int subjectId;

  @override
  List<Object?> get props => [planId, subjectId];
}

final class UntilPopEvent extends MainHomeEvent {}
