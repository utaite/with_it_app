import 'package:with_it/base/base.dart';
import 'package:with_it/ui/name/request/name_request.dart';

base class NameState extends BaseModel with BaseState, BaseLoadingState {
  const NameState({
    required this.request,
    required this.isLoading,
    required this.isListen,
  });

  factory NameState.empty() => _empty;

  final NameRequest request;
  @override
  final bool isLoading;
  @override
  final bool isListen;

  @override
  bool get isActive => request.name.isNotEmpty;

  static final NameState _empty = NameState(
    request: NameRequest.empty(),
    isLoading: false,
    isListen: false,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  NameState copyWith({
    NameState? state,
    NameRequest? request,
    bool? isLoading,
    bool? isListen,
  }) =>
      NameState(
        request: request ?? state?.request ?? this.request,
        isLoading: isLoading ?? this.isLoading,
        isListen: isListen ?? this.isListen,
      );

  @override
  List<Object?> get props => [request, isLoading, isListen];
}
