import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';

final class DateTimeBottomSheetState extends BaseModel with BaseState, BaseLoadingState {
  const DateTimeBottomSheetState({
    required this.dateTime,
    required this.isLoading,
  });

  factory DateTimeBottomSheetState.empty() => _empty;

  final DateTime dateTime;
  @override
  final bool isLoading;

  static final DateTimeBottomSheetState _empty = DateTimeBottomSheetState(
    dateTime: initialDateTime,
    isLoading: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  bool get isActive => true;

  @override
  DateTimeBottomSheetState copyWith({
    DateTime? dateTime,
    bool? isLoading,
  }) =>
      DateTimeBottomSheetState(
        dateTime: dateTime ?? this.dateTime,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [dateTime, isLoading];
}
