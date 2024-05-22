import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/ui/common/bottom_sheet/date_time/date_time_bottom_sheet_state.dart';

final class DateTimeBottomSheetCubit extends Cubit<DateTimeBottomSheetState> {
  DateTimeBottomSheetCubit(super.initialState);

  factory DateTimeBottomSheetCubit.empty() => DateTimeBottomSheetCubit(DateTimeBottomSheetState.empty());

  void initial({DateTime? dateTime}) => emit(
        DateTimeBottomSheetState.empty().copyWith(
          dateTime: dateTime,
        ),
      );

  void change(DateTime dateTime) => emit(
        state.copyWith(
          dateTime: dateTime,
        ),
      );

  void loading() => emit(
        state.copyWith(
          isLoading: true,
        ),
      );
}
