import 'package:with_it/base/base.dart';
import 'package:with_it/messages/planner.pb.dart';
import 'package:with_it/ui/main/fragment/planner/request/main_planner_request.dart';

base class MainPlannerState extends BaseModel with BaseState, BaseLoadingState, BaseUntilPopState {
  const MainPlannerState({
    required this.request,
    required this.plannerRead,
    required this.isLoading,
    required this.isUntilPop,
  });

  factory MainPlannerState.empty() => _empty;

  final MainPlannerRequest request;
  final PlannerReadResponse plannerRead;
  @override
  final bool isLoading;
  @override
  final bool isUntilPop;

  static final MainPlannerState _empty = MainPlannerState(
    request: MainPlannerRequest.empty(),
    plannerRead: PlannerReadResponse.create(),
    isLoading: false,
    isUntilPop: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainPlannerState copyWith({
    MainPlannerState? state,
    MainPlannerRequest? request,
    PlannerReadResponse? plannerRead,
    bool? isLoading,
    bool? isUntilPop,
  }) =>
      MainPlannerState(
        request: request ?? state?.request ?? this.request,
        plannerRead: plannerRead ?? state?.plannerRead ?? this.plannerRead,
        isLoading: isLoading ?? this.isLoading,
        isUntilPop: isUntilPop ?? this.isUntilPop,
      );

  @override
  List<Object?> get props => [request, plannerRead, isLoading, isUntilPop];
}
