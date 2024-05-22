import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/messages/user.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/name/name_event.dart';
import 'package:with_it/ui/name/repository/name_repository.dart';
import 'package:with_it/ui/name/repository/name_rest_repository.dart';
import 'package:with_it/ui/name/state/name_error_state.dart';
import 'package:with_it/ui/name/state/name_state.dart';

final class NameBloc extends Bloc<NameEvent, NameState> {
  NameBloc({
    required this.repository,
    required NameState initialState,
  }) : super(initialState) {
    on<InitialEvent>(_onInitial);
    on<ChangedNameEvent>(_onChangedName);
    on<PressedConfirmEvent>(_onPressedConfirm);
  }

  factory NameBloc.empty({NameRepository? repository, NameState? initialState}) => NameBloc(
        repository: repository ?? const NameRestRepository(),
        initialState: initialState ?? NameState.empty(),
      );

  final NameRepository repository;

  void _onInitial(InitialEvent event, Emitter<NameState> emit) {
    debugPrint('[NameBloc] _onInitial: $event');
    return emit(event.state ?? NameState.empty());
  }

  void _onChangedName(ChangedNameEvent event, Emitter<NameState> emit) {
    debugPrint('[NameBloc] _onChangedName: $event');
    return emit(
      NameState.empty().copyWith(
        state: state,
        request: state.request.copyWith(
          name: event.name,
        ),
      ),
    );
  }

  Future<void> _onPressedConfirm(PressedConfirmEvent event, Emitter<NameState> emit) async {
    debugPrint('[NameBloc] _onPressedConfirm: $event');
    emit(
      NameState.empty().copyWith(
        state: state,
        isLoading: true,
      ),
    );

    final userCreate = await repository.createUser(
      UserCreateRequest(
        data: UserCreateRequestData(
          name: state.request.name,
          deviceToken: await FirebaseMessaging.instance.getToken(),
        ),
      ),
    );
    debugPrint('[NameBloc] _onPressedConfirm userCreate: $userCreate');

    try {
      validate([userCreate.result]);
      return emit(
        state.copyWith(
          isLoading: false,
          isListen: true,
        ),
      );
    } on GlobalException catch (e) {
      debugPrint('[NameBloc] _onPressedConfirm error: $e');
      return emit(
        NameErrorState.empty().copyWith(
          state: state,
          error: e.copyWith(
            type: e.isTypeEmpty ? ErrorType.text : e.type,
          ),
        ),
      );
    }
  }
}
