import 'package:with_it/base/base.dart';
import 'package:with_it/model/model.dart';

final class MainModel extends BaseModel {
  const MainModel({
    required this.routes,
    required this.index,
  });

  factory MainModel.empty() => _empty;

  factory MainModel.values() => _values;

  final Iterable<RouteModel> routes;
  final int index;

  static const MainModel _empty = MainModel(
    routes: Iterable.empty(),
    index: 0,
  );

  static final MainModel _values = _empty.copyWith(
    routes: RouteModel.mainValues(),
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainModel copyWith({
    Iterable<RouteModel>? routes,
    int? index,
  }) =>
      MainModel(
        routes: routes ?? this.routes,
        index: index ?? this.index,
      );

  @override
  List<Object?> get props => [routes, index];
}
