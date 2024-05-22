import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';

final class RouteModel extends BaseModel {
  const RouteModel({
    required this.routes,
    required this.title,
    required this.icon,
  });

  factory RouteModel.empty() => _empty;

  factory RouteModel.main() => _main;

  factory RouteModel.mainHome() => _mainHome;

  factory RouteModel.mainPlanner() => _mainPlanner;

  factory RouteModel.mainSetting() => _mainSetting;

  factory RouteModel.mainStatistics() => _mainStatistics;

  factory RouteModel.name() => _name;

  final Routes routes;
  final String title;
  final String icon;

  static const RouteModel _empty = RouteModel(
    routes: Routes.empty,
    title: '',
    icon: '',
  );

  static final RouteModel _main = _empty.copyWith(
    routes: Routes.main,
  );

  static final RouteModel _mainHome = _empty.copyWith(
    routes: Routes.mainHome,
    title: '홈',
    icon: Assets.home,
  );

  static final RouteModel _mainPlanner = _empty.copyWith(
    routes: Routes.mainPlanner,
    title: '플래너',
    icon: Assets.planner,
  );

  static final RouteModel _mainSetting = _empty.copyWith(
    routes: Routes.mainSetting,
    title: '설정',
    icon: Assets.setting,
  );

  static final RouteModel _mainStatistics = _empty.copyWith(
    routes: Routes.mainStatistics,
    title: '통계',
    icon: Assets.statistics,
  );

  static final RouteModel _name = _empty.copyWith(
    routes: Routes.name,
  );

  static Iterable<RouteModel> mainValues() => [
        _mainHome,
        _mainPlanner,
        _mainStatistics,
        _mainSetting,
      ];

  @override
  bool get isEmpty => this == _empty;

  String get routeName => '/${routes.name}';

  @override
  RouteModel copyWith({
    Routes? routes,
    String? title,
    String? icon,
  }) =>
      RouteModel(
        routes: routes ?? this.routes,
        title: title ?? this.title,
        icon: icon ?? this.icon,
      );

  @override
  List<Object?> get props => [routes, title, icon];
}
