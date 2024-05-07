import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_event.dart';
import 'package:with_it/ui/main/fragment/planner/repository/main_planner_repository.dart';
import 'package:with_it/ui/main/fragment/planner/repository/main_planner_rest_repository.dart';
import 'package:with_it/ui/main/fragment/planner/state/main_planner_state.dart';

final class MainPlannerBloc extends Bloc<MainPlannerEvent, MainPlannerState> {
  MainPlannerBloc({
    required this.repository,
    required MainPlannerState initialState,
  }) : super(initialState) {
    on<InitialEvent>(_onInitial);
    on<UntilPopEvent>(
      _onUntilPop,
      transformer: (events, mapper) => events.throttleTime(Values.duration).exhaustMap(mapper),
    );
  }

  factory MainPlannerBloc.empty({MainPlannerRepository? repository, MainPlannerState? initialState}) => MainPlannerBloc(
        repository: repository ?? const MainPlannerRestRepository(),
        initialState: initialState ?? MainPlannerState.empty(),
      );

  final MainPlannerRepository repository;

  void _onInitial(InitialEvent event, Emitter<MainPlannerState> emit) {
    debugPrint('[MainPlannerBloc] _onInitial: $event');
    return emit(event.state ?? MainPlannerState.empty());
  }

  void _onUntilPop(UntilPopEvent event, Emitter<MainPlannerState> emit) {
    debugPrint('[MainPlannerBloc] _onUntilPop: $event');
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
