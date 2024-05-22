import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/app/app_cubit.dart';
import 'package:with_it/ui/app/app_state.dart';
import 'package:with_it/ui/main/fragment/home/main_home_bloc.dart';
import 'package:with_it/ui/main/fragment/home/main_home_event.dart' as main_home;
import 'package:with_it/ui/main/fragment/home/state/main_home_state.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_bloc.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_event.dart' as main_planner;
import 'package:with_it/ui/main/fragment/planner/state/main_planner_state.dart';
import 'package:with_it/ui/main/fragment/setting/main_setting_bloc.dart';
import 'package:with_it/ui/main/fragment/setting/main_setting_event.dart' as main_setting;
import 'package:with_it/ui/main/fragment/statistics/main_statistics_bloc.dart';
import 'package:with_it/ui/main/main_bloc.dart';
import 'package:with_it/ui/main/main_event.dart' as main;
import 'package:with_it/ui/main/main_page.dart';
import 'package:with_it/ui/main/state/main_state.dart';
import 'package:with_it/ui/name/name_bloc.dart';
import 'package:with_it/ui/name/name_page.dart';

final class AppController extends BaseController<AppCubit, AppState> {
  AppController(this.context);

  @override
  final BuildContext context;

  Map<String, WidgetBuilder> get routes => {
        '/${Routes.main.name}': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<MainBloc>(
                  create: (context) {
                    final mainBloc = MainBloc.values(
                      initialState: MainState.values().copyWith(
                        isLoading: true,
                      ),
                    );
                    final event = main.InitialEvent(
                      state: mainBloc.state.copyWith(
                        isSignIn: true,
                      ),
                    );

                    return mainBloc..add(event);
                  },
                ),
                BlocProvider<MainHomeBloc>(
                  create: (context) => context.singleton(
                    () => MainHomeBloc.empty(
                      initialState: MainHomeState.empty().copyWith(
                        isLoading: true,
                      ),
                    ),
                  )..add(main_home.ReadEvent()),
                ),
                BlocProvider<MainPlannerBloc>(
                  create: (context) => context.singleton(
                    () => MainPlannerBloc.empty(
                      initialState: MainPlannerState.empty().copyWith(
                        isLoading: true,
                      ),
                    ),
                  )..add(main_planner.ReadEvent()),
                ),
                BlocProvider<MainSettingBloc>(
                  create: (context) => context.singleton(MainSettingBloc.empty)..add(main_setting.ReadEvent()),
                ),
                BlocProvider<MainStatisticsBloc>(
                  create: (context) => context.singleton(MainStatisticsBloc.empty),
                ),
              ],
              child: const MainPage(),
            ),
        '/${Routes.name.name}': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<NameBloc>(
                  create: (context) => context.singleton(NameBloc.empty),
                ),
              ],
              child: const NamePage(),
            ),
      };

  Iterable<Locale> get locales => const {
        'ko': 'KR',
        'en': 'US',
        'ja': 'JP',
      }.entries.map((x) => Locale(x.key, x.value));
}
