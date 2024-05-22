import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/main_bloc.dart';
import 'package:with_it/ui/main/main_controller.dart';
import 'package:with_it/ui/main/model/main_model.dart';
import 'package:with_it/ui/main/state/main_error_state.dart';
import 'package:with_it/ui/main/state/main_state.dart';
import 'package:with_it/ui/widget/widget.dart';

extension on BuildContext {
  MainController get controller => MainController(this);
}

final class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('[MainPage] build: ${context.controller.state}');
    return MultiBlocListener(
      listeners: [
        BlocListener<MainBloc, MainState>(
          listenWhen: context.controller.listenWhenSignIn,
          listener: context.controller.onListenSignIn,
        ),
        BlocListener<MainBloc, MainState>(
          listenWhen: context.controller.listenWhenError,
          listener: context.controller.onListenError,
        ),
      ],
      child: PopScope(
        canPop: Platform.isIOS,
        onPopInvoked: context.controller.onPopInvoked,
        child: GestureDetector(
          onTap: context.controller.unfocus,
          child: BlocSelector<MainBloc, MainState, Status>(
            selector: (state) => state.status,
            builder: (context, status) {
              if (status.isLoading) {
                return const PlatformScaffold(
                  body: PlatformPlaceholder(),
                );
              } else if (status.isError) {
                return PlatformScaffold(
                  body: BlocSelector<MainBloc, MainState, GlobalException>(
                    selector: (state) => state is MainErrorState ? state.error : GlobalException.empty(),
                    builder: (context, error) => Center(
                      child: Text(error.title),
                    ),
                  ),
                );
              }

              return BlocSelector<MainBloc, MainState, MainModel>(
                selector: (state) => state.model,
                builder: (context, model) {
                  final items = model.routes.map(
                    (x) => BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                        '${Assets.assets}/${Assets.icon}/${x.icon}.${Assets.svg}',
                        colorFilter: Theme.of(context).bottomNavigationBarTheme.selectedItemColor.colorFilter,
                      ),
                      icon: SvgPicture.asset('${Assets.assets}/${Assets.icon}/${x.icon}.${Assets.svg}'),
                      label: x.title,
                      tooltip: '',
                    ),
                  );

                  return PlatformScaffold(
                    body: IndexedStack(
                      index: model.index,
                      children: [
                        ...model.routes.map(
                          (x) => LayoutKeepAlive(
                            child: ClipRect(
                              child: Navigator(
                                key: context.controller.getNavigatorKey(x),
                                initialRoute: x.routeName,
                                onGenerateRoute: context.controller.onGenerateRoute,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    androidBottomNavigationBar: items.length > 2
                        ? BottomNavigationBar(
                            onTap: context.controller.onNavigationTap,
                            currentIndex: model.index,
                            items: [
                              ...items,
                            ],
                          )
                        : null,
                    iosBottomNavigationBar: items.length > 2
                        ? CupertinoTabBar(
                            onTap: context.controller.onNavigationTap,
                            currentIndex: model.index,
                            activeColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
                            inactiveColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor.elvis,
                            items: [
                              ...items,
                            ],
                          )
                        : null,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
