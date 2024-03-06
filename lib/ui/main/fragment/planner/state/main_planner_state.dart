import 'package:with_it/base/base.dart';

base class MainPlannerState extends BaseModel with BaseState, BaseUntilPopState {
  const MainPlannerState({
    required this.isUntilPop,
  });

  factory MainPlannerState.empty() => _empty;

  @override
  final bool isUntilPop;

  static const MainPlannerState _empty = MainPlannerState(
    isUntilPop: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainPlannerState copyWith({
    MainPlannerState? state,
    bool? isUntilPop,
  }) =>
      MainPlannerState(
        isUntilPop: isUntilPop ?? this.isUntilPop,
      );

  @override
  List<Object?> get props => [isUntilPop];
}
