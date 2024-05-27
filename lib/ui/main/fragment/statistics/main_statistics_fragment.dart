import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    var now = DateTime.now();
    while (now.weekday < 7) {
      now = now.subtract(Values.days);
    }
    final next = now.add(Values.days * 6);
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
          backgroundColor: Resource.colorGrey[S.s100.s],
          body: CustomScrollView(
            slivers: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Paddings.height16,
                  Paddings.height2,
                  Row(
                    children: [
                      Paddings.width8,
                      Paddings.width2,
                      const Icon(Icons.chevron_left),
                      Expanded(
                        child: Center(
                          child: Text(
                            '${now.year}년 ${now.month}월 ${now.day}일 ~ ${next.year}년 ${next.month}월 ${next.day}일',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Resource.colorBlack,
                                ),
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                      Paddings.width8,
                      Paddings.width2,
                    ],
                  ),
                  Paddings.height24,
                  Center(
                    child: Text(
                      '51h 20m',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Resource.colorBlack,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '총 공부시간',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Resource.colorGrey[S.s700.s],
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  Paddings.height24,
                  Row(
                    children: [
                      Paddings.width16,
                      ...Day.values.indexed.expand(
                        (x) => [
                          if (x.$1.isPositive) Paddings.width12,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Stack(
                                  fit: StackFit.passthrough,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Resource.colorGrey[S.s200.s].elvis,
                                        borderRadius: UI.borderRadiusGraph,
                                      ),
                                      child: const SizedBox(
                                        height: 180,
                                      ),
                                    ),
                                    DecoratedBox(
                                      decoration: const BoxDecoration(
                                        color: Resource.colorPrimary,
                                        borderRadius: UI.borderRadiusGraph,
                                      ),
                                      child: SizedBox(
                                        height: [70, 48, 136, 95, 70, 84, 70][x.$1].elvis.toDouble(),
                                      ),
                                    ),
                                  ],
                                ),
                                Paddings.height12,
                                Center(
                                  child: Text(
                                    x.$2.value,
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          color: Resource.colorGrey[S.s600.s],
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Paddings.width16,
                    ],
                  ),
                  Paddings.height40,
                  Padding(
                    padding: Paddings.paddingHorizontal16,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: UI.borderRadiusGraph,
                      ),
                      child: Padding(
                        padding: Paddings.paddingHorizontal16,
                        child: Column(
                          children: [
                            Paddings.height12,
                            Row(
                              children: [
                                const Icon(
                                  Icons.edit,
                                  color: Color(0xFF2B43FF),
                                ),
                                Paddings.width16,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        '7h 20m',
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Resource.colorBlack,
                                            ),
                                      ),
                                      Text(
                                        '하루 평균 공부시간이 지난주와 비슷해요',
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Paddings.height16,
                            Row(
                              children: [
                                const Icon(
                                  Icons.sunny,
                                  color: Color(0xFFFD995D),
                                ),
                                Paddings.width16,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        '2h 10m',
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Resource.colorBlack,
                                            ),
                                      ),
                                      Text(
                                        '하루 평균 휴식시간이 지난주보다 줄었어요',
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Paddings.height12,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Paddings.height24,
                  Padding(
                    padding: Paddings.paddingHorizontal16,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: UI.borderRadiusGraph,
                      ),
                      child: Padding(
                        padding: Paddings.paddingHorizontal16,
                        child: Column(
                          children: [
                            Paddings.height12,
                            Center(
                              child: Text(
                                '플랜 달성률',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Resource.colorBlack,
                                    ),
                              ),
                            ),
                            Stack(
                              fit: StackFit.passthrough,
                              alignment: Alignment.center,
                              children: [
                                const RotatedBox(
                                  quarterTurns: 3,
                                  child: CircularProgressIndicator(
                                    color: Resource.colorPrimary,
                                    backgroundColor: Color(0xFFE9ECF1),
                                    value: 1 / 2,
                                    strokeAlign: 10,
                                    strokeWidth: 8,
                                    strokeCap: StrokeCap.round,
                                  ),
                                ),
                                Text(
                                  '50%',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        color: Resource.colorBlack,
                                      ),
                                ),
                                const SizedBox(height: 160),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Paddings.height24,
                  Padding(
                    padding: Paddings.paddingHorizontal16,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: UI.borderRadiusGraph,
                      ),
                      child: Padding(
                        padding: Paddings.paddingHorizontal16,
                        child: Column(
                          children: [
                            Paddings.height12,
                            Center(
                              child: Text(
                                '과목별 공부 비율',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Resource.colorBlack,
                                    ),
                              ),
                            ),
                            const Stack(
                              fit: StackFit.passthrough,
                              alignment: Alignment.center,
                              children: [
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFFFC224),
                                    backgroundColor: Color(0xFFFF8B8B),
                                    value: 1 / 6,
                                    strokeAlign: 2,
                                    strokeWidth: 32,
                                  ),
                                ),
                                SizedBox(height: 160),
                              ],
                            ),
                            Row(
                              children: [
                                const DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFC224),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SizedBox(
                                    height: 12,
                                    width: 12,
                                  ),
                                ),
                                Paddings.width12,
                                Expanded(
                                  child: Text(
                                    '영어',
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                                Text(
                                  '12시간 8분',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        color: Resource.colorBlack,
                                      ),
                                ),
                              ],
                            ),
                            Paddings.height12,
                            Row(
                              children: [
                                const DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFF8B8B),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SizedBox(
                                    height: 12,
                                    width: 12,
                                  ),
                                ),
                                Paddings.width12,
                                Expanded(
                                  child: Text(
                                    '국어',
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                                Text(
                                  '39시간 10분',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        color: Resource.colorBlack,
                                      ),
                                ),
                              ],
                            ),
                            Paddings.height24,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Paddings.height32,
                  Row(
                    children: [
                      Paddings.width24,
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFEF9D),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: Paddings.paddingAll4,
                          child: Text(
                            'A',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: const Color(0xFFFFC224),
                                ),
                          ),
                        ),
                      ),
                      Paddings.width8,
                      Text(
                        '영어',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Resource.colorBlack,
                            ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '12시간 8분',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Resource.colorBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Paddings.height4,
                            Text(
                              '5일 | 모의고사 1회',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: const Color(0xFF7C7C7C),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Paddings.width24,
                    ],
                  ),
                  Paddings.height24,
                  Row(
                    children: [
                      Paddings.width16,
                      ...Day.values.indexed.expand(
                        (x) => [
                          if (x.$1.isPositive) Paddings.width12,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Stack(
                                  fit: StackFit.passthrough,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Resource.colorGrey[S.s200.s].elvis,
                                        borderRadius: UI.borderRadiusGraph,
                                      ),
                                      child: const SizedBox(
                                        height: 120,
                                      ),
                                    ),
                                    DecoratedBox(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFFC224),
                                        borderRadius: UI.borderRadiusGraph,
                                      ),
                                      child: SizedBox(
                                        height: [70, 48, 136, 95, 70, 84, 70].map((x) => x * 2 / 3)[x.$1].elvis,
                                      ),
                                    ),
                                  ],
                                ),
                                Paddings.height12,
                                Center(
                                  child: Text(
                                    x.$2.value,
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          color: Resource.colorGrey[S.s600.s],
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Paddings.width16,
                    ],
                  ),
                  Paddings.height24,
                  Paddings.height32,
                  Row(
                    children: [
                      Paddings.width24,
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFDADA),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: Paddings.paddingAll4,
                          child: Text(
                            'A',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: const Color(0xFFFF8B8B),
                                ),
                          ),
                        ),
                      ),
                      Paddings.width8,
                      Text(
                        '국어',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Resource.colorBlack,
                            ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '39시간 10분',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Resource.colorBlack,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Paddings.height4,
                            Text(
                              '7일 | 모의고사 1회',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: const Color(0xFF7C7C7C),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Paddings.width24,
                    ],
                  ),
                  Paddings.height24,
                  Row(
                    children: [
                      Paddings.width16,
                      ...Day.values.indexed.expand(
                        (x) => [
                          if (x.$1.isPositive) Paddings.width12,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Stack(
                                  fit: StackFit.passthrough,
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Resource.colorGrey[S.s200.s].elvis,
                                        borderRadius: UI.borderRadiusGraph,
                                      ),
                                      child: const SizedBox(
                                        height: 120,
                                      ),
                                    ),
                                    DecoratedBox(
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFF8B8B),
                                        borderRadius: UI.borderRadiusGraph,
                                      ),
                                      child: SizedBox(
                                        height: [70, 48, 136, 95, 70, 84, 70].map((x) => x * 2 / 3)[x.$1].elvis,
                                      ),
                                    ),
                                  ],
                                ),
                                Paddings.height12,
                                Center(
                                  child: Text(
                                    x.$2.value,
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                          color: Resource.colorGrey[S.s600.s],
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Paddings.width16,
                    ],
                  ),
                  Paddings.height24,
                ],
              ).sliverFill,
            ],
          ),
        ),
      ),
    );
  }
}
