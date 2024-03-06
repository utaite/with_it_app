import 'package:with_it/base/base.dart';

base class MainStatisticsState extends BaseModel with BaseState, BaseUntilPopState {
  const MainStatisticsState({
    required this.isUntilPop,
  });

  factory MainStatisticsState.empty() => _empty;

  @override
  final bool isUntilPop;

  static const MainStatisticsState _empty = MainStatisticsState(
    isUntilPop: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainStatisticsState copyWith({
    MainStatisticsState? state,
    bool? isUntilPop,
  }) =>
      MainStatisticsState(
        isUntilPop: isUntilPop ?? this.isUntilPop,
      );

  @override
  List<Object?> get props => [isUntilPop];
}
