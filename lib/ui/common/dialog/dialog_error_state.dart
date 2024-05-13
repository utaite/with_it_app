import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/common/dialog/dialog_state.dart';

final class DialogErrorState extends DialogState with BaseErrorLoadingState {
  const DialogErrorState({
    required this.error,
    required super.isLoading,
  });

  factory DialogErrorState.empty() => _empty;

  @override
  final GlobalException error;

  static final DialogErrorState _empty = DialogErrorState(
    error: GlobalException.empty(),
    isLoading: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  DialogErrorState copyWith({
    GlobalException? error,
    bool? isLoading,
  }) =>
      DialogErrorState(
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading,
      );
}
