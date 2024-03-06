import 'package:flutter/material.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_bloc.dart';
import 'package:with_it/ui/main/fragment/planner/state/main_planner_state.dart';

final class MainPlannerController extends BaseController<MainPlannerBloc, MainPlannerState> with BaseRouteMixin, BaseUntilPopMixin {
  MainPlannerController(this.context);

  @override
  final BuildContext context;
}
