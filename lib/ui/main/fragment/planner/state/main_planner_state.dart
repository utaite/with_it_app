import 'package:with_it/base/base.dart';
import 'package:with_it/ui/main/fragment/planner/model/main_planner_model.dart';

base class MainPlannerState extends BaseModel with BaseState, BaseUntilPopState {
  const MainPlannerState({
    required this.model,
    required this.isUntilPop,
  });

  factory MainPlannerState.empty() => _empty;

  final MainPlannerModel model;
  @override
  final bool isUntilPop;

  static final MainPlannerState _empty = MainPlannerState(
    model: MainPlannerModel.empty(),
    isUntilPop: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainPlannerState copyWith({
    MainPlannerState? state,
    MainPlannerModel? model,
    bool? isUntilPop,
  }) =>
      MainPlannerState(
        model: model ?? state?.model ?? this.model,
        isUntilPop: isUntilPop ?? this.isUntilPop,
      );

  @override
  List<Object?> get props => [model, isUntilPop];
}
