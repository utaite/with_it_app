import 'package:with_it/base/base.dart';

base class MainHomeState extends BaseModel with BaseState, BaseUntilPopState {
  const MainHomeState({
    required this.isUntilPop,
  });

  factory MainHomeState.empty() => _empty;

  @override
  final bool isUntilPop;

  static const MainHomeState _empty = MainHomeState(
    isUntilPop: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainHomeState copyWith({
    MainHomeState? state,
    bool? isUntilPop,
  }) =>
      MainHomeState(
        isUntilPop: isUntilPop ?? this.isUntilPop,
      );

  @override
  List<Object?> get props => [isUntilPop];
}
