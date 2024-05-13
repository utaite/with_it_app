import 'package:table_calendar/table_calendar.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';

final class MainPlannerModel extends BaseModel {
  const MainPlannerModel({
    required this.rangeSelectionMode,
    required this.start,
    required this.end,
    required this.selectedDay,
    required this.focusedDay,
  });

  factory MainPlannerModel.empty() => _empty;

  final RangeSelectionMode rangeSelectionMode;
  final DateTime start;
  final DateTime end;
  final DateTime selectedDay;
  final DateTime focusedDay;

  static final MainPlannerModel _empty = MainPlannerModel(
    rangeSelectionMode: RangeSelectionMode.disabled,
    start: initialDateTime,
    end: initialDateTime,
    selectedDay: DateTime.now(),
    focusedDay: DateTime.now(),
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainPlannerModel copyWith({
    RangeSelectionMode? rangeSelectionMode,
    DateTime? start,
    DateTime? end,
    DateTime? selectedDay,
    DateTime? focusedDay,
  }) =>
      MainPlannerModel(
        rangeSelectionMode: rangeSelectionMode ?? this.rangeSelectionMode,
        start: start ?? this.start,
        end: end ?? this.end,
        selectedDay: selectedDay ?? this.selectedDay,
        focusedDay: focusedDay ?? this.focusedDay,
      );

  @override
  List<Object?> get props => [rangeSelectionMode, start, end, selectedDay, focusedDay];
}
