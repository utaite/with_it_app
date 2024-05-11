import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/app/app_cubit.dart';
import 'package:with_it/ui/app/app_state.dart';
import 'package:with_it/ui/main/fragment/home/main_home_bloc.dart';
import 'package:with_it/ui/main/fragment/planner/main_planner_bloc.dart';
import 'package:with_it/ui/main/fragment/setting/main_setting_bloc.dart';
import 'package:with_it/ui/main/fragment/setting/main_setting_event.dart' as setting;
import 'package:with_it/ui/main/fragment/statistics/main_statistics_bloc.dart';
import 'package:with_it/ui/main/main_bloc.dart';
import 'package:with_it/ui/main/main_page.dart';

final class AppController extends BaseController<AppCubit, AppState> {
  AppController(this.context);

  @override
  final BuildContext context;

  Map<String, WidgetBuilder> get routes => {
        '$slash${Routes.main.name}': (context) => MultiBlocProvider(
              providers: [
                BlocProvider<MainBloc>(
                  create: (context) => context.singleton(MainBloc.values),
                ),
                BlocProvider<MainHomeBloc>(
                  create: (context) => context.singleton(MainHomeBloc.empty),
                ),
                BlocProvider<MainPlannerBloc>(
                  create: (context) => context.singleton(MainPlannerBloc.empty),
                ),
                BlocProvider<MainSettingBloc>(
                  create: (context) => context.singleton(MainSettingBloc.empty)..add(setting.ReadEvent()),
                ),
                BlocProvider<MainStatisticsBloc>(
                  create: (context) => context.singleton(MainStatisticsBloc.empty),
                ),
              ],
              child: const MainPage(),
            ),
      };

  Iterable<Locale> get locales => const {
        'ko': 'KR',
        'en': 'US',
        'ja': 'JP',
      }.entries.map((x) => Locale(x.key, x.value));
}
