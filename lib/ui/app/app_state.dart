import 'package:flutter/foundation.dart';
import 'package:with_it/base/base.dart';

final class AppState extends BaseModel with BaseState {
  const AppState({
    required this.platform,
    required this.brightness,
  });

  factory AppState.empty() => _empty;

  factory AppState.dark() => _dark;

  final TargetPlatform platform;
  final Brightness brightness;

  static final AppState _empty = AppState(
    platform: defaultTargetPlatform,
    brightness: Brightness.light,
  );

  static final AppState _dark = _empty.copyWith(
    brightness: Brightness.dark,
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  AppState copyWith({
    AppState? state,
    TargetPlatform? platform,
    Brightness? brightness,
  }) =>
      AppState(
        platform: platform ?? state?.platform ?? this.platform,
        brightness: brightness ?? state?.brightness ?? this.brightness,
      );

  @override
  List<Object?> get props => [platform, brightness];
}
