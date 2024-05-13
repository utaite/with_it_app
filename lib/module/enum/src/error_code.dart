import 'package:with_it/module/module.dart';

enum ErrorCode {
  empty,
  notFound,
  retry,
}

extension StringErrorCodeEx on String {
  ErrorCode toErrorCode() => ErrorCode.values.where((x) => x.name.snake == this).firstOrNull ?? ErrorCode.empty;
}
