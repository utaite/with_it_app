import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_bloc.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_event.dart';
import 'package:with_it/ui/main/fragment/planner/state/main_planner_state.dart';

final class MainPlannerController extends BaseController<MainPlannerBloc, MainPlannerState> with BaseRouteMixin, BaseUntilPopMixin {
  MainPlannerController(this.context);

  @override
  final BuildContext context;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    bloc.add(
      ChangedFocusedDayEvent(
        selectedDay: selectedDay,
        focusedDay: focusedDay,
      ),
    );
  }

  void onPressedPlan() {}

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    bloc.add(
      ChangedRangeEvent(
        start: start,
        end: end,
        focusedDay: focusedDay,
      ),
    );
  }

  bool selectedDayPredicate(DateTime day) => isSameDay(day, state.model.selectedDay);
}
