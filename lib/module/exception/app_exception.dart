import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';

final class GlobalException extends BaseModel implements Exception {
  const GlobalException({
    required this.type,
    required this.code,
    required this.messages,
  });

  factory GlobalException.empty() => _empty;

  final ErrorType type;
  final ErrorCode code;
  final Iterable<String> messages;

  static const GlobalException _empty = GlobalException(
    type: ErrorType.empty,
    code: ErrorCode.empty,
    messages: Iterable.empty(),
  );

  @override
  bool get isEmpty => this == _empty;

  String get title => messages.length.minusInt(1).isPositive ? messages.firstOrNull.elvis : '안내';

  String get content => messages.length.isPositive ? messages.skip(messages.length.minusInt(1)).firstOrNull.elvis : '';

  bool get isTypeEmpty => type == ErrorType.empty;

  bool get isTypeDialog => type == ErrorType.dialog;

  bool get isTypePage => type == ErrorType.page;

  bool get isTypeText => type == ErrorType.text;

  @override
  GlobalException copyWith({
    ErrorType? type,
    ErrorCode? code,
    Iterable<String>? messages,
  }) =>
      GlobalException(
        type: type ?? this.type,
        code: code ?? this.code,
        messages: messages ?? this.messages,
      );

  @override
  List<Object?> get props => [type, code, messages];
}
