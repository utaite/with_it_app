import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/name/name_bloc.dart';
import 'package:with_it/ui/name/name_controller.dart';
import 'package:with_it/ui/name/state/name_state.dart';
import 'package:with_it/ui/widget/widget.dart';

extension on BuildContext {
  NameController get controller => NameController(this);
}

final class NamePage extends StatelessWidget {
  const NamePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('[NamePage] build: ${context.controller.state}');
    return MultiBlocListener(
      listeners: [
        BlocListener<NameBloc, NameState>(
          listenWhen: context.controller.listenWhen,
          listener: context.controller.onListen,
        ),
        BlocListener<NameBloc, NameState>(
          listenWhen: context.controller.listenWhenError,
          listener: context.controller.onListenError,
        ),
      ],
      child: PopScope(
        canPop: Platform.isIOS,
        onPopInvoked: context.controller.onPopInvoked,
        child: GestureDetector(
          onTap: context.controller.unfocus,
          child: PlatformScaffold(
            backgroundColor: Resource.colorGrey[S.s100.s],
            body: CustomScrollView(
              slivers: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Paddings.height60,
                    Paddings.height8,
                    Padding(
                      padding: Paddings.paddingHorizontal16,
                      child: Center(
                        child: Text(
                          '닉네임 또는 이름을 입력해주세요',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Resource.colorBlack,
                              ),
                        ),
                      ),
                    ),
                    Paddings.height8,
                    Padding(
                      padding: Paddings.paddingHorizontal16,
                      child: Center(
                        child: Text(
                          '앞으로 데이터 저장을 위해 필요한 정보예요',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Resource.colorBlack,
                              ),
                        ),
                      ),
                    ),
                    Paddings.height40,
                    Padding(
                      padding: Paddings.paddingHorizontal16,
                      child: TextField(
                        onChanged: context.controller.onChangedName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Resource.colorGrey[S.s500.s],
                            ),
                      ),
                    ),
                    Paddings.height12,
                    Padding(
                      padding: Paddings.paddingHorizontal16,
                      child: BlocSelector<NameBloc, NameState, Status>(
                        selector: (state) => state.status,
                        builder: (context, status) => FilledButton(
                          onPressed: status.isActive ? context.controller.onPressedConfirm : null,
                          child: PlatformButtonPlaceholder(
                            isLoading: status.isLoading,
                            child: Text(
                              '완료',
                              style: Theme.of(context).filledButtonTextStyle(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Paddings.height40,
                    Paddings.height8,
                    Padding(
                      padding: Paddings.paddingHorizontal16,
                      child: Center(
                        child: Text(
                          '어플을 삭제하면 저장된 데이터는 모두 사라집니다.\n설정한 닉네임 또는 이름은 수정이 불가능합니다.',
                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Resource.colorGrey[S.s700.s],
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ).sliverFill,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
