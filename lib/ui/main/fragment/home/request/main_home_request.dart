import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';

final class MainHomeRequest extends BaseModel {
  const MainHomeRequest({
    required this.dateTime,
  });

  factory MainHomeRequest.empty() => _empty;

  final DateTime dateTime;

  static final MainHomeRequest _empty = MainHomeRequest(
    dateTime: DateTime.now().midnight,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainHomeRequest copyWith({
    DateTime? dateTime,
  }) =>
      MainHomeRequest(
        dateTime: dateTime ?? this.dateTime,
      );

  @override
  List<Object?> get props => [dateTime];
}
