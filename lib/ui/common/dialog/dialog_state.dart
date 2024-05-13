import 'package:with_it/base/base.dart';

base class DialogState extends BaseModel with BaseState, BaseLoadingState {
  const DialogState({
    required this.isLoading,
  });

  factory DialogState.empty() => _empty;

  @override
  final bool isLoading;

  static const DialogState _empty = DialogState(
    isLoading: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  bool get isActive => true;

  @override
  DialogState copyWith({
    bool? isLoading,
  }) =>
      DialogState(
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [isLoading];
}
