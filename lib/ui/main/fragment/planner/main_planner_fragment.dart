import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/model/model.dart';
import 'package:with_it/module/module.dart';
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
          body: CustomScrollView(
            slivers: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  UI.spacer,
                  Center(
                    child: Text('Hello, MainPlannerFragment!'),
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
