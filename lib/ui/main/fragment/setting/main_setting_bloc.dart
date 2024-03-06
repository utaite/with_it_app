import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/setting/main_setting_event.dart';
import 'package:with_it/ui/main/fragment/setting/repository/main_setting_mock_repository.dart';
import 'package:with_it/ui/main/fragment/setting/repository/main_setting_repository.dart';
import 'package:with_it/ui/main/fragment/setting/repository/main_setting_rest_repository.dart';
import 'package:with_it/ui/main/fragment/setting/state/main_setting_state.dart';

final class MainSettingBloc extends Bloc<MainSettingEvent, MainSettingState> {
  MainSettingBloc({
    required this.repository,
    required MainSettingState initialState,
  }) : super(initialState) {
    on<InitialEvent>(_onInitial);
    on<UntilPopEvent>(
      _onUntilPop,
      transformer: (events, mapper) => events.throttleTime(Values.duration).exhaustMap(mapper),
    );
  }

  factory MainSettingBloc.empty({MainSettingRepository? repository, MainSettingState? initialState}) => MainSettingBloc(
        repository: repository ?? (Env.isMock ? const MainSettingMockRepository() : const MainSettingRestRepository()),
        initialState: initialState ?? MainSettingState.empty(),
      );

  final MainSettingRepository repository;

  void _onInitial(InitialEvent event, Emitter<MainSettingState> emit) {
    debugPrint('[MainSettingBloc] _onInitial: $event');
    return emit(event.state ?? MainSettingState.empty());
  }

  void _onUntilPop(UntilPopEvent event, Emitter<MainSettingState> emit) {
    debugPrint('[MainSettingBloc] _onUntilPop: $event');
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
