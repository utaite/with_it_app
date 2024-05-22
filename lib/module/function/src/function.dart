import 'dart:io';

import 'package:with_it/messages/result.pb.dart';
import 'package:with_it/module/module.dart';

DateTime get initialDateTime => DateTime(1970);

DateTime? parseDateTime(Object? json) {
  final str = json.toString();
  return str.isNotEmpty ? DateTime.tryParse(str) : null;
}

void validate(Iterable<Result> result) {
  result
      .map(
        (x) => switch (x.status) {
          HttpStatus.internalServerError => GlobalException.empty().copyWith(
              code: ErrorCode.retry,
              messages: [
                '위드 잇에 연결할 수 없어요.',
                '네트워크 상태를 확인 후 다시 시도해 주세요.',
              ],
            ),
          HttpStatus.badGateway || HttpStatus.serviceUnavailable || HttpStatus.gatewayTimeout => GlobalException.empty().copyWith(
              code: ErrorCode.retry,
              messages: [
                '위드 잇에 연결할 수 없어요.',
                '잠시 후 다시 시도해 주세요.',
              ],
            ),
          _ => switch (x.code.toUpperCase()) {
              Strings.success => null,
              _ => GlobalException.empty().copyWith(
                  type: x.type.toErrorType(),
                  code: x.code.toErrorCode(),
                  messages: x.messages,
                ),
            },
        },
      )
      .nonNulls
      .forEach((x) => throw x);
}
