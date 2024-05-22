import 'package:with_it/base/base.dart';

final class MainPlannerRequest extends BaseModel {
  const MainPlannerRequest({
    required this.selectedDay,
    required this.focusedDay,
  });

  factory MainPlannerRequest.empty() => _empty;

  final DateTime selectedDay;
  final DateTime focusedDay;

  static final MainPlannerRequest _empty = MainPlannerRequest(
    selectedDay: DateTime.now(),
    focusedDay: DateTime.now(),
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainPlannerRequest copyWith({
    DateTime? selectedDay,
    DateTime? focusedDay,
  }) =>
      MainPlannerRequest(
        selectedDay: selectedDay ?? this.selectedDay,
        focusedDay: focusedDay ?? this.focusedDay,
      );

  @override
  List<Object?> get props => [selectedDay, focusedDay];
}
