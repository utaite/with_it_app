import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/name/request/name_request.dart';
import 'package:with_it/ui/name/state/name_state.dart';

final class NameErrorState extends NameState with BaseErrorLoadingState {
  const NameErrorState({
    required super.request,
    required this.error,
    required super.isLoading,
    required super.isListen,
  });

  factory NameErrorState.empty() => _empty;

  @override
  final GlobalException error;

  static final NameErrorState _empty = NameErrorState(
    request: NameRequest.empty(),
    error: GlobalException.empty(),
    isLoading: false,
    isListen: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  NameErrorState copyWith({
    NameState? state,
    NameRequest? request,
    GlobalException? error,
    bool? isLoading,
    bool? isListen,
  }) =>
      NameErrorState(
        request: request ?? state?.request ?? this.request,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading,
        isListen: isListen ?? this.isListen,
      );
}
