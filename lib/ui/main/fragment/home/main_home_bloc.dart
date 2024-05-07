import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/home/main_home_event.dart';
import 'package:with_it/ui/main/fragment/home/repository/main_home_repository.dart';
import 'package:with_it/ui/main/fragment/home/repository/main_home_rest_repository.dart';
import 'package:with_it/ui/main/fragment/home/state/main_home_state.dart';

final class MainHomeBloc extends Bloc<MainHomeEvent, MainHomeState> {
  MainHomeBloc({
    required this.repository,
    required MainHomeState initialState,
  }) : super(initialState) {
    on<InitialEvent>(_onInitial);
    on<UntilPopEvent>(
      _onUntilPop,
      transformer: (events, mapper) => events.throttleTime(Values.duration).exhaustMap(mapper),
    );
  }

  factory MainHomeBloc.empty({MainHomeRepository? repository, MainHomeState? initialState}) => MainHomeBloc(
        repository: repository ?? const MainHomeRestRepository(),
        initialState: initialState ?? MainHomeState.empty(),
      );

  final MainHomeRepository repository;

  void _onInitial(InitialEvent event, Emitter<MainHomeState> emit) {
    debugPrint('[MainHomeBloc] _onInitial: $event');
    return emit(event.state ?? MainHomeState.empty());
  }

  void _onUntilPop(UntilPopEvent event, Emitter<MainHomeState> emit) {
    debugPrint('[MainHomeBloc] _onUntilPop: $event');
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
