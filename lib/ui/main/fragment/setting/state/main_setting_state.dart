import 'package:with_it/base/base.dart';

base class MainSettingState extends BaseModel with BaseState, BaseUntilPopState {
  const MainSettingState({
    required this.isUntilPop,
  });

  factory MainSettingState.empty() => _empty;

  @override
  final bool isUntilPop;

  static const MainSettingState _empty = MainSettingState(
    isUntilPop: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainSettingState copyWith({
    MainSettingState? state,
    bool? isUntilPop,
  }) =>
      MainSettingState(
        isUntilPop: isUntilPop ?? this.isUntilPop,
      );

  @override
  List<Object?> get props => [isUntilPop];
}
