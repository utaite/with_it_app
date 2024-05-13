import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final now = DateTime.now();
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
          backgroundColor: Resource.colorGrey[S.s100.s].elvis,
          body: CustomScrollView(
            slivers: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Paddings.height24,
                        Row(
                          children: [
                            Paddings.width24,
                            Flexible(
                              child: Text(
                                [
                                  '${now.year}년',
                                  '${now.month}월',
                                  '${now.day}일',
                                  '(${Day.values[now.weekday.minusInt(1)].value})',
                                ].join(' '),
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Resource.colorBlack,
                                    ),
                              ),
                            ),
                            PlatformButton(
                              icon: SvgPicture.asset('${Assets.assets}/${Assets.icon}/${Assets.home}_${Assets.edit}.${Assets.svg}'),
                            ),
                            Paddings.width24,
                          ],
                        ),
                        Paddings.height24,
                        Row(
                          children: [
                            Paddings.width24,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '총 공부시간',
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          color: Resource.colorGrey[S.s700.s],
                                        ),
                                  ),
                                  Paddings.height4,
                                  Text(
                                    '00:00:00',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: Resource.colorGrey[S.s800.s],
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: Resource.colorGrey[S.s200.s].elvis,
                                shape: BoxShape.circle,
                              ),
                              child: PlatformButton(
                                icon: SvgPicture.asset('${Assets.assets}/${Assets.icon}/${Assets.share}.${Assets.svg}'),
                              ),
                            ),
                            Paddings.width24,
                          ],
                        ),
                        Paddings.height24,
                      ],
                    ),
                  ),
                  ...[
                    ('2번째 공부', '03:00:00', '오후 12:58', '오후 12:58', false),
                    '휴식 1h 33m',
                    ('영어', '03:00:00', '오후 12:58', '오후 12:58', true),
                  ].expand(
                    (x) {
                      if (x is (String, String, String, String, bool)) {
                        return [
                          Paddings.height16,
                          Padding(
                            padding: Paddings.paddingHorizontal16,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Paddings.height16,
                                  Row(
                                    children: [
                                      Paddings.width16,
                                      if (x.$5) ...[
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Resource.colorYellow[S.s200.s],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: Paddings.paddingAll4,
                                            child: Text(
                                              'C',
                                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                    color: Resource.colorYellow,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Paddings.width8,
                                      ],
                                      Text(
                                        x.$1,
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                              color: Resource.colorBlack,
                                            ),
                                      ),
                                      Paddings.width12,
                                      if (x.$5)
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Resource.colorPrimary[S.s100.s],
                                            borderRadius: const BorderRadius.all(Radius.circular(18)),
                                          ),
                                          child: Padding(
                                            padding: Paddings.paddingHorizontal8.copyWith(
                                              top: 4,
                                              bottom: 4,
                                            ),
                                            child: Text(
                                              '카운트다운',
                                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                    color: Resource.colorPrimary[S.s600.s],
                                                  ),
                                            ),
                                          ),
                                        ),
                                      Paddings.width4,
                                      UI.spacer,
                                      PlatformButton(
                                        onPressed: context.controller.onPressedMore,
                                        icon: const Icon(Icons.more_vert),
                                      ),
                                      Paddings.width4,
                                    ],
                                  ),
                                  Paddings.height16,
                                  Row(
                                    children: [
                                      Paddings.width16,
                                      Expanded(
                                        child: Text(
                                          x.$2,
                                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                                color: Resource.colorGrey[S.s700.s],
                                              ),
                                        ),
                                      ),
                                      Paddings.width16,
                                      Text(
                                        [
                                          x.$3,
                                          x.$4,
                                        ].join(' ~ '),
                                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                              color: Resource.colorGrey[S.s600.s],
                                            ),
                                      ),
                                      Paddings.width16,
                                    ],
                                  ),
                                  Paddings.height16,
                                ],
                              ),
                            ),
                          ),
                        ];
                      } else if (x is String) {
                        return [
                          Paddings.height16,
                          Padding(
                            padding: Paddings.paddingHorizontal16,
                            child: Center(
                              child: Text(
                                x,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: Resource.colorGrey[S.s600.s],
                                    ),
                              ),
                            ),
                          ),
                        ];
                      }

                      return [];
                    },
                  ),
                ],
              ).sliverFill,
            ],
          ),
        ),
      ),
    );
  }
}
