import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/common/dialog/dialog_error_state.dart';
import 'package:with_it/ui/common/dialog/dialog_state.dart';

final class DialogCubit extends Cubit<DialogState> {
  DialogCubit(super.initialState);

  factory DialogCubit.empty() => DialogCubit(DialogState.empty());

  void initial() => emit(DialogState.empty());

  void loading() => emit(
        state.copyWith(
          isLoading: true,
        ),
      );

  void error(GlobalException e) => emit(
        DialogErrorState.empty().copyWith(
          error: e.copyWith(
            type: ErrorType.dialogText,
            messages: e.messages.length.minusInt(1).isPositive ? e.messages.skip(1) : e.messages,
          ),
        ),
      );
}
