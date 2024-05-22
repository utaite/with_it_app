import 'package:with_it/base/base.dart';
import 'package:with_it/messages/planner.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/planner/request/main_planner_request.dart';
import 'package:with_it/ui/main/fragment/planner/state/main_planner_state.dart';

final class MainPlannerErrorState extends MainPlannerState with BaseErrorLoadingState {
  const MainPlannerErrorState({
    required super.request,
    required super.plannerRead,
    required this.error,
    required super.isLoading,
    required super.isUntilPop,
  });

  factory MainPlannerErrorState.empty() => _empty;

  @override
  final GlobalException error;

  static final MainPlannerErrorState _empty = MainPlannerErrorState(
    request: MainPlannerRequest.empty(),
    plannerRead: PlannerReadResponse.create(),
    error: GlobalException.empty(),
    isLoading: false,
    isUntilPop: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainPlannerErrorState copyWith({
    MainPlannerState? state,
    MainPlannerRequest? request,
    PlannerReadResponse? plannerRead,
    GlobalException? error,
    bool? isLoading,
    bool? isUntilPop,
  }) =>
      MainPlannerErrorState(
        request: request ?? state?.request ?? this.request,
        plannerRead: plannerRead ?? state?.plannerRead ?? this.plannerRead,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading,
        isUntilPop: isUntilPop ?? this.isUntilPop,
      );
}
