import 'package:with_it/base/base.dart';
import 'package:with_it/messages/user.pb.dart';
import 'package:with_it/ui/main/model/main_model.dart';

base class MainState extends BaseModel with BaseState, BaseLoadingState {
  const MainState({
    required this.model,
    required this.userCreate,
    required this.userRead,
    required this.isSignIn,
    required this.isLoading,
  });

  factory MainState.values() => _values;

  final MainModel model;
  final UserCreateResponse userCreate;
  final UserReadResponse userRead;
  final bool isSignIn;
  @override
  final bool isLoading;

  static final MainState _empty = MainState(
    model: MainModel.empty(),
    userCreate: UserCreateResponse.create(),
    userRead: UserReadResponse.create(),
    isSignIn: false,
    isLoading: false,
  );

  static final MainState _values = _empty.copyWith(
    model: MainModel.values(),
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainState copyWith({
    MainState? state,
    MainModel? model,
    UserCreateResponse? userCreate,
    UserReadResponse? userRead,
    bool? isSignIn,
    bool? isLoading,
  }) =>
      MainState(
        model: model ?? state?.model ?? this.model,
        userCreate: userCreate ?? this.userCreate,
        userRead: userRead ?? this.userRead,
        isSignIn: isSignIn ?? this.isSignIn,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [model, userCreate, userRead, isSignIn, isLoading];
}
