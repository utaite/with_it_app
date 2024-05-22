import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/model/model.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/home/main_home_bloc.dart';
import 'package:with_it/ui/main/fragment/home/main_home_event.dart' as main_home;
import 'package:with_it/ui/main/fragment/home/main_home_fragment.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_bloc.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_event.dart' as main_planner;
import 'package:with_it/ui/main/fragment/planner/main_planner_fragment.dart';
import 'package:with_it/ui/main/fragment/setting/main_setting_bloc.dart';
import 'package:with_it/ui/main/fragment/setting/main_setting_event.dart' as main_setting;
import 'package:with_it/ui/main/fragment/setting/main_setting_fragment.dart';
import 'package:with_it/ui/main/fragment/statistics/main_statistics_bloc.dart';
import 'package:with_it/ui/main/fragment/statistics/main_statistics_event.dart' as main_statistics;
import 'package:with_it/ui/main/fragment/statistics/main_statistics_fragment.dart';
import 'package:with_it/ui/main/main_bloc.dart';
import 'package:with_it/ui/main/main_event.dart';
import 'package:with_it/ui/main/state/main_error_state.dart';
import 'package:with_it/ui/main/state/main_state.dart';

final Map<RouteModel, GlobalKey<NavigatorState>> _navigatorKeys = {};

final class MainController extends BaseController<MainBloc, MainState> with BaseNavigatorMixin, BaseRouteMixin {
  MainController(this.context);

  @override
  final BuildContext context;

  bool listenWhenSignIn(MainState previous, MainState current) => !previous.isSignIn && current.isSignIn;

  @override
  bool onWillPop() {
    final currentState = navigatorKeys[state.model.routes[state.model.index]]?.currentState;
    if ((currentState?.canPop()).elvis) {
      currentState?.pop();
      return false;
    } else if (state.model.index.isPositive) {
      bloc.add(ChangedIndexEvent(index: 0));
      return false;
    }

    return super.onWillPop();
  }

  @override
  Future<void> onListenError(BuildContext context, MainState state) async {
    await super.onListenError(context, state);
    if (state is MainErrorState && state.error.isTypePage) {
      await super.offNamed(RouteModel.name());
    }
  }

  Future<void> onListenSignIn([_, __]) async {
    bloc.add(SignInEvent());
  }

  Future<void> onNavigationTap(int index) async {
    if (index == state.model.index) {
      final functions = [
        () => context.read<MainHomeBloc>().add(main_home.UntilPopEvent()),
        () => context.read<MainPlannerBloc>().add(main_planner.UntilPopEvent()),
        () => context.read<MainSettingBloc>().add(main_setting.UntilPopEvent()),
        () => context.read<MainStatisticsBloc>().add(main_statistics.UntilPopEvent()),
        () {},
      ].asMap();
      functions[index]?.call();
    } else {
      bloc.add(ChangedIndexEvent(index: index));
    }
  }

  @override
  Map<RouteModel, GlobalKey<NavigatorState>> get navigatorKeys => _navigatorKeys;

  @override
  Map<String, WidgetBuilder> get fragments => {
        '/${Routes.mainHome.name}': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<MainHomeBloc>.value(
                  value: BlocProvider.of(context),
                ),
              ],
              child: const MainHomeFragment(),
            ),
        '/${Routes.mainPlanner.name}': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<MainPlannerBloc>.value(
                  value: BlocProvider.of(context),
                ),
              ],
              child: const MainPlannerFragment(),
            ),
        '/${Routes.mainSetting.name}': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<MainSettingBloc>.value(
                  value: BlocProvider.of(context),
                ),
              ],
              child: const MainSettingFragment(),
            ),
        '/${Routes.mainStatistics.name}': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<MainStatisticsBloc>.value(
                  value: BlocProvider.of(context),
                ),
              ],
              child: const MainStatisticsFragment(),
            ),
      };
}
