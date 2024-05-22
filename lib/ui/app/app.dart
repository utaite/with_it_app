import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rinf/rinf.dart';
import 'package:with_it/model/model.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/app/app_controller.dart';
import 'package:with_it/ui/app/app_cubit.dart';
import 'package:with_it/ui/app/app_state.dart';
import 'package:with_it/ui/common/bottom_sheet/date_time/date_time_bottom_sheet_cubit.dart';
import 'package:with_it/ui/common/dialog/dialog_cubit.dart';
import 'package:with_it/ui/widget/widget.dart';

extension on BuildContext {
  AppController get controller => AppController(this);
}

final class App extends StatefulWidget {
  const App({
    required this.initialRoute,
    super.key,
    this.brightness,
    this.platform,
  });

  final RouteModel initialRoute;
  final Brightness? brightness;
  final TargetPlatform? platform;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appLifecycleListener = AppLifecycleListener(
    onExitRequested: () async {
      await Rinf.ensureFinalized();
      return AppExitResponse.exit;
    },
  );

  @override
  void dispose() {
    _appLifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (context) => context.singleton(
              () => AppCubit(
                AppState.empty().copyWith(
                  brightness: widget.brightness,
                  platform: widget.platform,
                ),
              ),
            ),
          ),
          BlocProvider<DialogCubit>(
            create: (context) => context.singleton(DialogCubit.empty),
          ),
          BlocProvider<DateTimeBottomSheetCubit>(
            create: (context) => context.singleton(DateTimeBottomSheetCubit.empty),
          ),
        ],
        child: BlocSelector<AppCubit, AppState, Brightness>(
          selector: (state) => state.brightness,
          builder: (context, brightness) {
            SystemChrome.setSystemUIOverlayStyle(brightness.statusBarStyle);

            return PlatformApp(
              title: '위드 잇',
              initialRoute: widget.initialRoute,
              routes: context.controller.routes,
              brightness: brightness,
              cupertinoThemeData: CupertinoThemeData(brightness: brightness).applyTheme(brightness.theme),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: context.controller.locales.firstOrNull,
              supportedLocales: context.controller.locales,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      );
}
