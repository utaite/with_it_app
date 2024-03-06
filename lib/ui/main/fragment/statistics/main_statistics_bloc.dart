import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/statistics/main_statistics_event.dart';
import 'package:with_it/ui/main/fragment/statistics/repository/main_statistics_mock_repository.dart';
import 'package:with_it/ui/main/fragment/statistics/repository/main_statistics_repository.dart';
import 'package:with_it/ui/main/fragment/statistics/repository/main_statistics_rest_repository.dart';
import 'package:with_it/ui/main/fragment/statistics/state/main_statistics_state.dart';

final class MainStatisticsBloc extends Bloc<MainStatisticsEvent, MainStatisticsState> {
  MainStatisticsBloc({
    required this.repository,
    required MainStatisticsState initialState,
  }) : super(initialState) {
    on<InitialEvent>(_onInitial);
    on<UntilPopEvent>(
      _onUntilPop,
      transformer: (events, mapper) => events.throttleTime(Values.duration).exhaustMap(mapper),
    );
  }

  factory MainStatisticsBloc.empty({MainStatisticsRepository? repository, MainStatisticsState? initialState}) => MainStatisticsBloc(
        repository: repository ?? (Env.isMock ? const MainStatisticsMockRepository() : const MainStatisticsRestRepository()),
        initialState: initialState ?? MainStatisticsState.empty(),
      );

  final MainStatisticsRepository repository;

  void _onInitial(InitialEvent event, Emitter<MainStatisticsState> emit) {
    debugPrint('[MainStatisticsBloc] _onInitial: $event');
    return emit(event.state ?? MainStatisticsState.empty());
  }

  void _onUntilPop(UntilPopEvent event, Emitter<MainStatisticsState> emit) {
    debugPrint('[MainStatisticsBloc] _onUntilPop: $event');
    emit(
      state.copyWith(
        isUntilPop: true,
      ),
    );

    return emit(
      state.copyWith(
        isUntilPop: false,
      ),
    );
  }
}
