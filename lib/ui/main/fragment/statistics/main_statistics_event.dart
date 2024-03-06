import 'package:with_it/base/base.dart';
import 'package:with_it/ui/main/fragment/statistics/state/main_statistics_state.dart';

abstract base class MainStatisticsEvent extends BaseEvent {}

final class InitialEvent extends MainStatisticsEvent {
  InitialEvent({
    this.state,
  });

  final MainStatisticsState? state;

  @override
  List<Object?> get props => [state];
}

final class UntilPopEvent extends MainStatisticsEvent {}
