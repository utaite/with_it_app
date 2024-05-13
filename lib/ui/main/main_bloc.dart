import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/messages/user.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/main_event.dart';
import 'package:with_it/ui/main/repository/main_repository.dart';
import 'package:with_it/ui/main/repository/main_rest_repository.dart';
import 'package:with_it/ui/main/state/main_error_state.dart';
import 'package:with_it/ui/main/state/main_state.dart';

final class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({
    required this.repository,
    required MainState initialState,
  }) : super(initialState) {
    on<InitialEvent>(_onInitial);
    on<ChangedIndexEvent>(_onChangedIndex);
    on<SignInEvent>(_onSignIn);
  }

  factory MainBloc.values({MainRepository? repository, MainState? initialState}) => MainBloc(
        repository: repository ?? const MainRestRepository(),
        initialState: initialState ?? MainState.values(),
      );

  final MainRepository repository;

  void _onInitial(InitialEvent event, Emitter<MainState> emit) {
    debugPrint('[MainBloc] _onInitial: $event');
    return emit(event.state ?? MainState.values());
  }

  void _onChangedIndex(ChangedIndexEvent event, Emitter<MainState> emit) {
    debugPrint('[MainBloc] _onChangedIndex: $event');
    return emit(
      MainState.values().copyWith(
        state: state,
        model: state.model.copyWith(
          index: event.index,
        ),
      ),
    );
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<MainState> emit) async {
    debugPrint('[MainBloc] _onSignIn: $event');
    emit(
      MainState.values().copyWith(
        state: state,
        isLoading: true,
      ),
    );

    final userRead = await repository.readUser(
      UserReadRequest(
        data: UserReadRequestData(
          deviceToken: event.deviceToken,
        ),
      ),
    );
    debugPrint('[MainBloc] _onSignIn userRead: $userRead');

    try {
      validate([userRead.result]);
      return emit(
        state.copyWith(
          userRead: userRead,
        ),
      );
    } on GlobalException catch (e) {
      debugPrint('[MainBloc] _onSignIn error: $e');
      return emit(
        MainErrorState.empty().copyWith(
          state: state,
          userRead: userRead,
          error: e.copyWith(
            type: e.isTypeEmpty ? ErrorType.text : e.type,
          ),
        ),
      );
    }
  }
}
