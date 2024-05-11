import 'package:with_it/base/base.dart';

base class MainSettingState extends BaseModel with BaseState, BaseLoadingState, BaseUntilPopState {
  const MainSettingState({
    required this.output,
    required this.isLoading,
    required this.isUntilPop,
  });

  factory MainSettingState.empty() => _empty;

  final String output;
  @override
  final bool isLoading;
  @override
  final bool isUntilPop;

  static const MainSettingState _empty = MainSettingState(
    output: '',
    isLoading: false,
    isUntilPop: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainSettingState copyWith({
    MainSettingState? state,
    String? output,
    bool? isLoading,
    bool? isUntilPop,
  }) =>
      MainSettingState(
        output: output ?? this.output,
        isLoading: isLoading ?? this.isLoading,
        isUntilPop: isUntilPop ?? this.isUntilPop,
      );

  @override
  List<Object?> get props => [output, isLoading, isUntilPop];
}
