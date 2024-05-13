import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_bloc.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_controller.dart';
import 'package:with_it/ui/main/fragment/planner/model/main_planner_model.dart';
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
          backgroundColor: Resource.colorGrey[S.s100.s].elvis,
          body: CustomScrollView(
            slivers: [
              BlocSelector<MainPlannerBloc, MainPlannerState, MainPlannerModel>(
                selector: (state) => state.model,
                builder: (context, model) {
                  final now = DateTime.now();

                  return TableCalendar(
                    availableCalendarFormats: const {
                      CalendarFormat.month: '',
                    },
                    availableGestures: AvailableGestures.horizontalSwipe,
                    focusedDay: model.focusedDay,
                    rangeStartDay: model.start.isEmpty ? null : model.start,
                    rangeEndDay: model.end.isEmpty ? null : model.end,
                    firstDay: DateTime(now.year),
                    lastDay: DateTime(now.year.plusInt(1)),
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      leftChevronMargin: EdgeInsets.zero,
                      rightChevronMargin: EdgeInsets.zero,
                      leftChevronPadding: EdgeInsets.zero,
                      rightChevronPadding: EdgeInsets.zero,
                    ),
                    calendarBuilders: CalendarBuilders(
                      headerTitleBuilder: (context, day) => Center(
                        child: Text(
                          '${day.year}년 ${day.month}월',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Resource.colorBlack,
                              ),
                        ),
                      ),
                      dowBuilder: (context, day) => Center(
                        child: Text(
                          Day.values[day.weekday.minusInt(1)].value,
                          style: Theme.of(context).textTheme.bodyMedium.elvis,
                        ),
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: Theme.of(context).textTheme.bodyMedium.elvis,
                      outsideTextStyle: Theme.of(context).textTheme.bodyMedium.elvis.copyWith(
                            color: Resource.colorGrey[S.s600.s].elvis,
                          ),
                      todayDecoration: BoxDecoration(
                        border: Border.all(
                          color: Resource.colorPrimary[S.s600.s].elvis,
                        ),
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: Theme.of(context).textTheme.bodyMedium.elvis.copyWith(
                            color: Resource.colorPrimary[S.s600.s],
                          ),
                      selectedDecoration: BoxDecoration(
                        color: Resource.colorPrimary[S.s600.s].elvis,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: Theme.of(context).textTheme.bodyMedium.elvis.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                      rangeStartDecoration: BoxDecoration(
                        color: Resource.colorPrimary[S.s600.s].elvis,
                        shape: BoxShape.circle,
                      ),
                      rangeStartTextStyle: Theme.of(context).textTheme.bodyMedium.elvis.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                      rangeEndDecoration: BoxDecoration(
                        color: Resource.colorPrimary[S.s600.s].elvis,
                        shape: BoxShape.circle,
                      ),
                      rangeEndTextStyle: Theme.of(context).textTheme.bodyMedium.elvis.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                      rangeHighlightColor: Resource.colorPrimary[S.s200.s].elvis,
                    ),
                    rangeSelectionMode: model.rangeSelectionMode,
                    selectedDayPredicate: context.controller.selectedDayPredicate,
                    onDaySelected: context.controller.onDaySelected,
                    onRangeSelected: context.controller.onRangeSelected,
                  );
                },
              ).sliverBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Paddings.height40,
                  UI.spacer,
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...[
                          (
                            '수학',
                            [
                              ('기백: 기출의 미래: 함수의 극한', 100),
                              ('기백: 기출의 미래: 함수의 극한', 100),
                            ],
                          ),
                          (
                            '수학',
                            [
                              ('기백: 기출의 미래: 함수의 극한', 100),
                              ('기백: 기출의 미래: 함수의 극한', 100),
                            ],
                          ),
                        ].expand(
                          (x) => [
                            Paddings.height16,
                            Padding(
                              padding: Paddings.paddingHorizontal16,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Resource.colorBlue[S.s200.s],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: Paddings.paddingAll4,
                                          child: Text(
                                            'B',
                                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                  color: Resource.colorBlue,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const WidgetSpan(child: Paddings.width4),
                                    TextSpan(text: x.$1),
                                  ],
                                ),
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: Resource.colorGrey[S.s800.s],
                                    ),
                              ),
                            ),
                            Paddings.height12,
                            ...x.$2.map(
                              (y) => Padding(
                                padding: Paddings.paddingVertical12,
                                child: Row(
                                  children: [
                                    Paddings.width16,
                                    Expanded(
                                      child: Text(
                                        y.$1,
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                              color: Resource.colorBlack,
                                            ),
                                      ),
                                    ),
                                    Paddings.width16,
                                    Text(
                                      '${y.$2}%',
                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                            color: Resource.colorBlack,
                                          ),
                                    ),
                                    Paddings.width16,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Paddings.height24,
                        Center(
                          child: FilledButton(
                            onPressed: context.controller.onPressedPlan,
                            style: FilledButton.styleFrom(
                              backgroundColor: Resource.colorGrey[S.s200.s],
                            ),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: SvgPicture.asset('${Assets.assets}/${Assets.icon}/${Assets.edit}.${Assets.svg}'),
                                  ),
                                  const WidgetSpan(child: Paddings.width4),
                                  const TextSpan(
                                    text: '플랜 편집',
                                  ),
                                ],
                              ),
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Resource.colorGrey[S.s600.s],
                                  ),
                            ),
                          ),
                        ),
                        Paddings.height40,
                      ],
                    ),
                  ),
                ],
              ).sliverFill,
            ],
          ),
        ),
      ),
    );
  }
}
