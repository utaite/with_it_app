import 'package:flutter/material.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/ui/main/fragment/statistics/main_statistics_bloc.dart';
import 'package:with_it/ui/main/fragment/statistics/state/main_statistics_state.dart';

final class MainStatisticsController extends BaseController<MainStatisticsBloc, MainStatisticsState> with BaseRouteMixin, BaseUntilPopMixin {
  MainStatisticsController(this.context);

  @override
  final BuildContext context;
}
