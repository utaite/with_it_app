import 'package:with_it/base/base.dart';
import 'package:with_it/messages/home.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/fragment/home/request/main_home_request.dart';
import 'package:with_it/ui/main/fragment/home/state/main_home_state.dart';

final class MainHomeErrorState extends MainHomeState with BaseErrorLoadingState {
  const MainHomeErrorState({
    required super.request,
    required super.homeRead,
    required this.error,
    required super.isLoading,
    required super.isUntilPop,
  });

  factory MainHomeErrorState.empty() => _empty;

  @override
  final GlobalException error;

  static final MainHomeErrorState _empty = MainHomeErrorState(
    request: MainHomeRequest.empty(),
    homeRead: HomeReadResponse.create(),
    error: GlobalException.empty(),
    isLoading: false,
    isUntilPop: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainHomeErrorState copyWith({
    MainHomeState? state,
    MainHomeRequest? request,
    HomeReadResponse? homeRead,
    GlobalException? error,
    bool? isLoading,
    bool? isUntilPop,
  }) =>
      MainHomeErrorState(
        request: request ?? state?.request ?? this.request,
        homeRead: homeRead ?? state?.homeRead ?? this.homeRead,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading,
        isUntilPop: isUntilPop ?? this.isUntilPop,
      );
}
