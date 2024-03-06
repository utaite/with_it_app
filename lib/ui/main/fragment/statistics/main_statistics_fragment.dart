import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/model/model.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/statistics/main_statistics_bloc.dart';
import 'package:with_it/ui/main/fragment/statistics/main_statistics_controller.dart';
import 'package:with_it/ui/main/fragment/statistics/state/main_statistics_state.dart';
import 'package:with_it/ui/widget/widget.dart';

extension on BuildContext {
  MainStatisticsController get controller => MainStatisticsController(this);
}

final class MainStatisticsFragment extends StatelessWidget {
  const MainStatisticsFragment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('[MainStatisticsFragment] build: ${context.controller.state}');
    return MultiBlocListener(
      listeners: [
        BlocListener<MainStatisticsBloc, MainStatisticsState>(
          listenWhen: context.controller.listenWhenError,
          listener: context.controller.onListenError,
        ),
        BlocListener<MainStatisticsBloc, MainStatisticsState>(
          listenWhen: context.controller.listenWhenUntilPop,
          listener: context.controller.onListenUntilPop,
        ),
      ],
      child: GestureDetector(
        onTap: context.controller.unfocus,
        child: PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text(RouteModel.mainStatistics().title),
          ),
          body: CustomScrollView(
            slivers: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  UI.spacer,
                  Center(
                    child: Text('Hello, MainStatisticsFragment!'),
                  ),
                  UI.spacer,
                ],
              ).sliverFill,
            ],
          ),
        ),
      ),
    );
  }
}
