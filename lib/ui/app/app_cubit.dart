import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/app/app_state.dart';

final class AppCubit extends Cubit<AppState> {
  AppCubit(super.initialState);

  factory AppCubit.empty() => AppCubit(AppState.empty());

  void toggleTheme() {
    debugPrint('[AppCubit] toggleTheme');
    return emit(
      AppState.empty().copyWith(
        state: state,
        brightness: state.brightness.toggle,
      ),
    );
  }
}
