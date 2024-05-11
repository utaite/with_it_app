import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:with_it/model/model.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_bloc.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_controller.dart';
import 'package:with_it/ui/main/fragment/planner/state/main_planner_state.dart';
import 'package:with_it/ui/widget/widget.dart';

extension on BuildContext {
  MainPlannerController get controller => MainPlannerController(this);
}

final class MainPlannerFragment extends StatelessWidget {
  const MainPlannerFragment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('[MainPlannerFragment] build: ${context.controller.state}');
    return MultiBlocListener(
      listeners: [
        BlocListener<MainPlannerBloc, MainPlannerState>(
          listenWhen: context.controller.listenWhenError,
          listener: context.controller.onListenError,
        ),
        BlocListener<MainPlannerBloc, MainPlannerState>(
          listenWhen: context.controller.listenWhenUntilPop,
          listener: context.controller.onListenUntilPop,
        ),
      ],
      child: GestureDetector(
        onTap: context.controller.unfocus,
        child: PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text(RouteModel.mainPlanner().title),
          ),
          body: TableCalendar(
            availableCalendarFormats: const {
              CalendarFormat.month: '',
            },
            availableGestures: AvailableGestures.horizontalSwipe,
            locale: 'ko_KR',
            focusedDay: DateTime.now(),
            firstDay: DateTime(2024),
            lastDay: DateTime(2025),
          ),
        ),
      ),
    );
  }
}
