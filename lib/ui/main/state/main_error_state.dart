import 'package:with_it/base/base.dart';
import 'package:with_it/messages/user.pb.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/main/model/main_model.dart';
import 'package:with_it/ui/main/state/main_state.dart';

final class MainErrorState extends MainState with BaseErrorLoadingState {
  const MainErrorState({
    required super.model,
    required super.userCreate,
    required super.userRead,
    required this.error,
    required super.isSignIn,
    required super.isLoading,
  });

  factory MainErrorState.empty() => _empty;

  @override
  final GlobalException error;

  static final MainErrorState _empty = MainErrorState(
    model: MainModel.empty(),
    userCreate: UserCreateResponse.create(),
    userRead: UserReadResponse.create(),
    error: GlobalException.empty(),
    isSignIn: false,
    isLoading: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainErrorState copyWith({
    MainState? state,
    MainModel? model,
    UserCreateResponse? userCreate,
    UserReadResponse? userRead,
    GlobalException? error,
    bool? isSignIn,
    bool? isLoading,
  }) =>
      MainErrorState(
        model: model ?? state?.model ?? this.model,
        userCreate: userCreate ?? state?.userCreate ?? this.userCreate,
        userRead: userRead ?? state?.userRead ?? this.userRead,
        error: error ?? this.error,
        isSignIn: isSignIn ?? this.isSignIn,
        isLoading: isLoading ?? this.isLoading,
      );
}
