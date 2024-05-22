import 'package:with_it/base/base.dart';
import 'package:with_it/messages/home.pb.dart';
import 'package:with_it/ui/main/fragment/home/request/main_home_request.dart';

base class MainHomeState extends BaseModel with BaseState, BaseLoadingState, BaseUntilPopState {
  const MainHomeState({
    required this.request,
    required this.homeRead,
    required this.isLoading,
    required this.isUntilPop,
  });

  factory MainHomeState.empty() => _empty;

  final MainHomeRequest request;
  final HomeReadResponse homeRead;
  @override
  final bool isLoading;
  @override
  final bool isUntilPop;

  static final MainHomeState _empty = MainHomeState(
    request: MainHomeRequest.empty(),
    homeRead: HomeReadResponse.create(),
    isLoading: false,
    isUntilPop: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainHomeState copyWith({
    MainHomeState? state,
    MainHomeRequest? request,
    HomeReadResponse? homeRead,
    bool? isLoading,
    bool? isUntilPop,
  }) =>
      MainHomeState(
        request: request ?? state?.request ?? this.request,
        homeRead: homeRead ?? state?.homeRead ?? this.homeRead,
        isLoading: isLoading ?? this.isLoading,
        isUntilPop: isUntilPop ?? this.isUntilPop,
      );

  @override
  List<Object?> get props => [request, homeRead, isLoading, isUntilPop];
}
