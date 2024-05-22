import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:with_it/messages/planner.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_event.dart';
import 'package:with_it/ui/main/fragment/planner/repository/main_planner_repository.dart';
import 'package:with_it/ui/main/fragment/planner/repository/main_planner_rest_repository.dart';
import 'package:with_it/ui/main/fragment/planner/state/main_planner_error_state.dart';
import 'package:with_it/ui/main/fragment/planner/state/main_planner_state.dart';

final class MainPlannerBloc extends Bloc<MainPlannerEvent, MainPlannerState> {
  MainPlannerBloc({
    required this.repository,
    required MainPlannerState initialState,
  }) : super(initialState) {
    on<InitialEvent>(_onInitial);
    on<ChangedFocusedDayEvent>(_onChangedFocusedDay);
    on<ReadEvent>(_onRead);
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

  Future<void> _onChangedFocusedDay(ChangedFocusedDayEvent event, Emitter<MainPlannerState> emit) async {
    debugPrint('[MainPlannerBloc] _onChangedFocusedDay: $event');
    emit(
      MainPlannerState.empty().copyWith(
        state: state,
        request: state.request.copyWith(
          selectedDay: event.selectedDay,
          focusedDay: event.focusedDay,
        ),
        isLoading: true,
      ),
    );

    final plannerRead = await repository.readPlanner(
      PlannerReadRequest(
        data: PlannerReadRequestData(
          deviceToken: await FirebaseMessaging.instance.getToken(),
          dateTime: state.request.selectedDay.format,
        ),
      ),
    );
    debugPrint('[MainPlannerBloc] _onChangedFocusedDay plannerRead: $plannerRead');

    try {
      validate([plannerRead.result]);
      return emit(
        state.copyWith(
          plannerRead: plannerRead,
          isLoading: false,
        ),
      );
    } on GlobalException catch (e) {
      debugPrint('[MainPlannerBloc] _onChangedFocusedDay error: $e');
      return emit(
        MainPlannerErrorState.empty().copyWith(
          state: state,
          plannerRead: plannerRead,
          error: e.copyWith(
            type: e.isTypeEmpty ? ErrorType.text : e.type,
          ),
        ),
      );
    }
  }

  Future<void> _onRead(ReadEvent event, Emitter<MainPlannerState> emit) async {
    debugPrint('[MainPlannerBloc] _onRead: $event');
    emit(
      MainPlannerState.empty().copyWith(
        state: state,
        isLoading: true,
      ),
    );

    final plannerRead = await repository.readPlanner(
      PlannerReadRequest(
        data: PlannerReadRequestData(
          deviceToken: await FirebaseMessaging.instance.getToken(),
          dateTime: state.request.selectedDay.format,
        ),
      ),
    );
    debugPrint('[MainPlannerBloc] _onRead plannerRead: $plannerRead');

    try {
      validate([plannerRead.result]);
      return emit(
        state.copyWith(
          plannerRead: plannerRead,
          isLoading: false,
        ),
      );
    } on GlobalException catch (e) {
      debugPrint('[MainPlannerBloc] _onRead error: $e');
      return emit(
        MainPlannerErrorState.empty().copyWith(
          state: state,
          plannerRead: plannerRead,
          error: e.copyWith(
            type: e.isTypeEmpty ? ErrorType.text : e.type,
          ),
        ),
      );
    }
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
