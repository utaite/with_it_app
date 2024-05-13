import 'package:with_it/module/module.dart';

enum ErrorType {
  empty,
  dialog,
  dialogText,
  text,
}

extension StringErrorTypeEx on String {
  ErrorType toErrorType() => ErrorType.values.where((x) => x.name.snake == this).firstOrNull ?? ErrorType.empty;
}
