import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:with_it/messages/home.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/home/main_home_event.dart';
import 'package:with_it/ui/main/fragment/home/repository/main_home_repository.dart';
import 'package:with_it/ui/main/fragment/home/repository/main_home_rest_repository.dart';
import 'package:with_it/ui/main/fragment/home/state/main_home_error_state.dart';
import 'package:with_it/ui/main/fragment/home/state/main_home_state.dart';

final class MainHomeBloc extends Bloc<MainHomeEvent, MainHomeState> {
  MainHomeBloc({
    required this.repository,
    required MainHomeState initialState,
  }) : super(initialState) {
    on<InitialEvent>(_onInitial);
    on<ChangedDateTimeEvent>(_onChangedDateTime);
    on<DeleteEvent>(_onDelete);
    on<ReadEvent>(_onRead);
    on<UpdateEvent>(_onUpdate);
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

  Future<void> _onChangedDateTime(ChangedDateTimeEvent event, Emitter<MainHomeState> emit) async {
    debugPrint('[MainHomeBloc] _onChangedDateTime: $event');
    emit(
      MainHomeState.empty().copyWith(
        state: state,
        request: state.request.copyWith(
          dateTime: event.dateTime,
        ),
        isLoading: true,
      ),
    );

    final homeRead = await repository.readHome(
      HomeReadRequest(
        data: HomeReadRequestData(
          deviceToken: await FirebaseMessaging.instance.getToken(),
          dateTime: state.request.dateTime.format,
        ),
      ),
    );
    debugPrint('[MainHomeBloc] _onChangedDateTime homeRead: $homeRead');

    try {
      validate([homeRead.result]);
      return emit(
        state.copyWith(
          homeRead: homeRead,
          isLoading: false,
        ),
      );
    } on GlobalException catch (e) {
      debugPrint('[MainHomeBloc] _onChangedDateTime error: $e');
      return emit(
        MainHomeErrorState.empty().copyWith(
          state: state,
          homeRead: homeRead,
          error: e.copyWith(
            type: e.isTypeEmpty ? ErrorType.text : e.type,
          ),
        ),
      );
    }
  }

  Future<void> _onDelete(DeleteEvent event, Emitter<MainHomeState> emit) async {
    debugPrint('[MainHomeBloc] _onDelete: $event');
    emit(
      MainHomeState.empty().copyWith(
        state: state,
        isLoading: true,
      ),
    );

    final homeDelete = await repository.deleteHome(
      HomeDeleteRequest(
        data: HomeDeleteRequestData(
          planId: Int64(event.planId),
        ),
      ),
    );
    debugPrint('[MainHomeBloc] _onDelete homeDelete: $homeDelete');
    final homeRead = await repository.readHome(
      HomeReadRequest(
        data: HomeReadRequestData(
          deviceToken: await FirebaseMessaging.instance.getToken(),
          dateTime: state.request.dateTime.format,
        ),
      ),
    );
    debugPrint('[MainHomeBloc] _onDelete homeRead: $homeRead');

    try {
      validate([homeDelete.result, homeRead.result]);
      return emit(
        state.copyWith(
          homeRead: homeRead,
          isLoading: false,
        ),
      );
    } on GlobalException catch (e) {
      debugPrint('[MainHomeBloc] _onDelete error: $e');
      return emit(
        MainHomeErrorState.empty().copyWith(
          state: state,
          homeRead: homeRead,
          error: e.copyWith(
            type: e.isTypeEmpty ? ErrorType.text : e.type,
          ),
        ),
      );
    }
  }

  Future<void> _onRead(ReadEvent event, Emitter<MainHomeState> emit) async {
    debugPrint('[MainHomeBloc] _onRead: $event');
    emit(
      MainHomeState.empty().copyWith(
        state: state,
        isLoading: true,
      ),
    );

    final homeRead = await repository.readHome(
      HomeReadRequest(
        data: HomeReadRequestData(
          deviceToken: await FirebaseMessaging.instance.getToken(),
          dateTime: state.request.dateTime.format,
        ),
      ),
    );
    debugPrint('[MainHomeBloc] _onRead homeRead: $homeRead');

    try {
      validate([homeRead.result]);
      return emit(
        state.copyWith(
          homeRead: homeRead,
          isLoading: false,
        ),
      );
    } on GlobalException catch (e) {
      debugPrint('[MainHomeBloc] _onRead error: $e');
      return emit(
        MainHomeErrorState.empty().copyWith(
          state: state,
          homeRead: homeRead,
          error: e.copyWith(
            type: e.isTypeEmpty ? ErrorType.text : e.type,
          ),
        ),
      );
    }
  }

  Future<void> _onUpdate(UpdateEvent event, Emitter<MainHomeState> emit) async {
    debugPrint('[MainHomeBloc] _onUpdate: $event');
    emit(
      MainHomeState.empty().copyWith(
        state: state,
        isLoading: true,
      ),
    );

    final homeUpdate = await repository.updateHome(
      HomeUpdateRequest(
        data: HomeUpdateRequestData(
          planId: Int64(event.planId),
          subjectId: Int64(event.subjectId),
        ),
      ),
    );
    debugPrint('[MainHomeBloc] _onDelete homeUpdate: $homeUpdate');
    final homeRead = await repository.readHome(
      HomeReadRequest(
        data: HomeReadRequestData(
          deviceToken: await FirebaseMessaging.instance.getToken(),
          dateTime: state.request.dateTime.format,
        ),
      ),
    );
    debugPrint('[MainHomeBloc] _onUpdate homeRead: $homeRead');

    try {
      validate([homeRead.result]);
      return emit(
        state.copyWith(
          homeRead: homeRead,
          isLoading: false,
        ),
      );
    } on GlobalException catch (e) {
      debugPrint('[MainHomeBloc] _onUpdate error: $e');
      return emit(
        MainHomeErrorState.empty().copyWith(
          state: state,
          homeRead: homeRead,
          error: e.copyWith(
            type: e.isTypeEmpty ? ErrorType.text : e.type,
          ),
        ),
      );
    }
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
