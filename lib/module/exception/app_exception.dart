import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';

final class AppException extends BaseModel implements Exception {
  const AppException({
    required this.messages,
  });

  factory AppException.empty() => _empty;

  final Iterable<String> messages;

  static const AppException _empty = AppException(
    messages: Iterable.empty(),
  );

  @override
  bool get isEmpty => this == _empty;

  String get title => messages.length.minusInt(1).isPositive ? messages.firstOrNull.elvis : '안내';

  String get content => messages.length.isPositive ? messages.skip(messages.length.minusInt(1)).firstOrNull.elvis : '';

  @override
  AppException copyWith({
    Iterable<String>? messages,
  }) =>
      AppException(
        messages: messages ?? this.messages,
      );

  @override
  List<Object?> get props => [messages];
}
