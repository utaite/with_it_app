import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/model/model.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/setting/main_setting_bloc.dart';
import 'package:with_it/ui/main/fragment/setting/main_setting_controller.dart';
import 'package:with_it/ui/main/fragment/setting/state/main_setting_state.dart';
import 'package:with_it/ui/widget/widget.dart';

extension on BuildContext {
  MainSettingController get controller => MainSettingController(this);
}

final class MainSettingFragment extends StatelessWidget {
  const MainSettingFragment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('[MainSettingFragment] build: ${context.controller.state}');
    return MultiBlocListener(
      listeners: [
        BlocListener<MainSettingBloc, MainSettingState>(
          listenWhen: context.controller.listenWhenError,
          listener: context.controller.onListenError,
        ),
        BlocListener<MainSettingBloc, MainSettingState>(
          listenWhen: context.controller.listenWhenUntilPop,
          listener: context.controller.onListenUntilPop,
        ),
      ],
      child: GestureDetector(
        onTap: context.controller.unfocus,
        child: PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text(RouteModel.mainSetting().title),
            actions: [
              PlatformButton(
                onPressed: context.controller.onPressedTest,
                icon: const Icon(Icons.add),
              ),
              PlatformButton(
                onPressed: context.controller.onPressedChange,
                icon: const Icon(Icons.change_circle_outlined),
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  UI.spacer,
                  Center(
                    child: Text('Hello, MainSettingFragment!'),
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
