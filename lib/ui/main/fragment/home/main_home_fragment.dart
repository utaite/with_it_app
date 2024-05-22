import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:with_it/messages/home.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/home/main_home_bloc.dart';
import 'package:with_it/ui/main/fragment/home/main_home_controller.dart';
import 'package:with_it/ui/main/fragment/home/state/main_home_error_state.dart';
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
        child: BlocSelector<MainHomeBloc, MainHomeState, Status>(
          selector: (state) => state.status,
          builder: (context, status) {
            if (status.isLoading) {
              return const PlatformScaffold(
                body: PlatformPlaceholder(),
              );
            } else if (status.isError) {
              return PlatformScaffold(
                body: BlocSelector<MainHomeBloc, MainHomeState, GlobalException>(
                  selector: (state) => state is MainHomeErrorState ? state.error : GlobalException.empty(),
                  builder: (context, error) => Center(
                    child: Text(error.title),
                  ),
                ),
              );
            }

            return PlatformScaffold(
              backgroundColor: Resource.colorGrey[S.s100.s],
              body: RefreshIndicator(
                onRefresh: context.controller.onRefresh,
                child: CustomScrollView(
                  slivers: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BlocSelector<MainHomeBloc, MainHomeState, Iterable<HomeReadResponsePlan>>(
                          selector: (state) => state.homeRead.data.plans,
                          builder: (context, plans) {
                            final duration = plans
                                .map((x) => parseDateTime(x.endedAt).elvis.difference(parseDateTime(x.startedAt).elvis))
                                .fold(Duration.zero, (a, c) => a + c);

                            return Column(
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
                                            child: BlocSelector<MainHomeBloc, MainHomeState, DateTime>(
                                              selector: (state) => state.request.dateTime,
                                              builder: (context, dateTime) => Text(
                                                dateTime.fullDate,
                                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                                  color: Resource.colorBlack,
                                                ),
                                              ),
                                            ),
                                          ),
                                          PlatformButton(
                                            onPressed: context.controller.onPressedDate,
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
                                                  duration.format,
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
                                              onPressed: context.controller.onPressedShare,
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
                                ...plans.indexed.expand(
                                      (x) {
                                    final diff = parseDateTime(plans[x.$1.minusInt(1)]?.startedAt).elvis.difference(parseDateTime(x.$2.endedAt).elvis);

                                    return [
                                      if (x.$1.isPositive && diff.inMinutes.isPositive) ...[
                                        Paddings.height16,
                                        Padding(
                                          padding: Paddings.paddingHorizontal16,
                                          child: Center(
                                            child: Text(
                                              diff.rest,
                                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                color: Resource.colorGrey[S.s600.s],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
                                                  Text(
                                                    '${x.$2.name} > ${x.$2.detail}',
                                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                      color: Resource.colorBlack,
                                                    ),
                                                  ),
                                                  Paddings.width16,
                                                  UI.spacer,
                                                  PlatformButton(
                                                    onPressed: () async => context.controller.onPressedMore(x.$2.id.toInt()),
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
                                                      parseDateTime(x.$2.endedAt).elvis.difference(parseDateTime(x.$2.startedAt).elvis).format,
                                                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                                        color: Resource.colorGrey[S.s700.s],
                                                      ),
                                                    ),
                                                  ),
                                                  Paddings.width16,
                                                  Text(
                                                    [
                                                      parseDateTime(x.$2.startedAt).elvis.text,
                                                      parseDateTime(x.$2.endedAt).elvis.text,
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
                                  },
                                ),
                                Paddings.height16,
                              ],
                            );
                          },
                        ),
                      ],
                    ).sliverFill,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
