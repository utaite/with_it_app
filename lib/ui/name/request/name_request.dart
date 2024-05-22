import 'package:with_it/base/base.dart';

final class NameRequest extends BaseModel {
  const NameRequest({
    required this.name,
  });

  factory NameRequest.empty() => _empty;

  final String name;

  static const NameRequest _empty = NameRequest(
    name: '',
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  NameRequest copyWith({
    String? name,
  }) =>
      NameRequest(
        name: name ?? this.name,
      );

  @override
  List<Object?> get props => [name];
}
