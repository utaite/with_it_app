import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/model/model.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/home/main_home_bloc.dart';
import 'package:with_it/ui/main/fragment/home/main_home_controller.dart';
import 'package:with_it/ui/main/fragment/home/state/main_home_state.dart';
import 'package:with_it/ui/widget/widget.dart';

extension on BuildContext {
  MainHomeController get controller => MainHomeController(this);
}

final class MainHomeFragment extends StatelessWidget {
  const MainHomeFragment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('[MainHomeFragment] build: ${context.controller.state}');
    return MultiBlocListener(
      listeners: [
        BlocListener<MainHomeBloc, MainHomeState>(
          listenWhen: context.controller.listenWhenError,
          listener: context.controller.onListenError,
        ),
        BlocListener<MainHomeBloc, MainHomeState>(
          listenWhen: context.controller.listenWhenUntilPop,
          listener: context.controller.onListenUntilPop,
        ),
      ],
      child: GestureDetector(
        onTap: context.controller.unfocus,
        child: PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text(RouteModel.mainHome().title),
          ),
          body: CustomScrollView(
            slivers: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  UI.spacer,
                  Center(
                    child: Text('Hello, MainHomeFragment!'),
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
