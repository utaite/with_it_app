import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:with_it/module/module.dart';

extension BoolOptionalEx on bool? {
  bool get elvis => this ?? false;
}

extension BrightnessOptionalEx on Brightness? {
  bool get isDark => this == Brightness.dark;

  ThemeData get theme => (isDark ? ThemeData.dark() : ThemeData.light()).applyTheme();

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  Brightness get toggle => isDark ? Brightness.light : Brightness.dark;

  SystemUiOverlayStyle get statusBarStyle => isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
}

extension ColorOptionalEx on Color? {
  Color get elvis => this ?? Colors.transparent;

  ColorFilter get colorFilter => ColorFilter.mode(elvis, BlendMode.srcIn);
}

extension CupertinoThemeDataEx on CupertinoThemeData {
  CupertinoThemeData applyTheme(ThemeData? theme) => copyWith(
        brightness: theme?.brightness,
        primaryColor: theme?.primaryColor,
        barBackgroundColor: theme?.scaffoldBackgroundColor,
        scaffoldBackgroundColor: theme?.scaffoldBackgroundColor,
      );
}

extension DateTimeOptionalEx on DateTime? {
  DateTime get elvis => this ?? initialDateTime;

  bool get isEmpty => elvis.millisecondsSinceEpoch <= initialDateTime.millisecondsSinceEpoch;
}

extension DateTimeEx on DateTime {
  DateTime get midnight => DateTime(year, month, day);

  String get format => [year.toString().padLeft(4, '0'), month.toString().padLeft(2, '0'), day.toString().padLeft(2, '0')].join('-');

  String get text => [
        if (hour >= 12) '오후' else '오전',
        ' ',
        (hour > 12 ? hour - 12 : hour).toString().padLeft(2, '0'),
        ':',
        minute.toString().padLeft(2, '0'),
      ].join();

  String get fullDate => ['$year년', '$month월', '$day일', '(${Day.values[weekday.minusInt(1)].value})'].join(' ');
}

extension DoubleOptionalEx on double? {
  double get elvis => this ?? 0.0;
}

extension DoubleEx on double {
  double plus(num other) => this + other;

  double minus(num other) => this - other;

  double times(num other) => this * other;

  double div(num other) => this / other;

  int divToInt(num other) => this ~/ other;

  double rem(num other) => this % other;
}

extension DurationOptinoalEx on Duration? {
  Duration get elvis => this ?? Duration.zero;
}

extension DurationEx on Duration {
  String get format => [
        inHours.toString().padLeft(2, '0'),
        inMinutes.remInt(60).toString().padLeft(2, '0'),
        inSeconds.remInt(60).toString().padLeft(2, '0'),
      ].join(':');

  String get rest => [
        '휴식',
        if (inHours.isPositive) '${inHours}h',
        if (inMinutes.remInt(60).isPositive) '${inMinutes.remInt(60).toString().padLeft(2, '0')}m',
      ].join(' ');
}

extension IntOptionalEx on int? {
  int get elvis => this ?? 0;
}

extension IntEx on int {
  double plus(double other) => this + other;

  double minus(double other) => this - other;

  double times(double other) => this * other;

  double div(double other) => this / other;

  int divToInt(num other) => this ~/ other;

  double rem(double other) => this % other;

  int plusInt(int other) => this + other;

  int minusInt(int other) => this - other;

  int timesInt(int other) => this * other;

  double divInt(int other) => this / other;

  int remInt(int other) => this % other;
}

extension IterableOptionalEx<T> on Iterable<T>? {
  Iterable<T> get elvis => this ?? const Iterable.empty();

  T? operator [](int? i) => (i?.isNotNegative).elvis && elvis.length > i.elvis ? elvis.elementAt(i.elvis) : null;
}

extension NumEx on num {
  bool get isNotNegative => !isNegative;

  bool get isPositive => this > 0;

  bool get isNotPositive => !isPositive;

  double get tween => max(0, min(1, toDouble()));

  bool get isInt => this is int || this == roundToDouble();

  num toIfInt() => isInt ? toInt() : this;
}

extension StatusEx on Status {
  bool get isEmpty => this == Status.empty;

  bool get isActive => this == Status.active;

  bool get isError => this == Status.error;

  bool get isLoading => this == Status.loading;
}

extension StringOptionalEx on String? {
  String get elvis => this ?? '';

  bool get isNullOrEmpty => this == null || (this?.isEmpty).elvis;

  String get snake => elvis.characters.expand((x) => [if (x == x.toUpperCase() && int.tryParse(x) == null) '_', x]).join().toUpperCase();
}

extension TextStyleOptionalEx on TextStyle? {
  TextStyle get elvis => this ?? const TextStyle();
}

extension Uint8ListEx on Uint8List? {
  List<int> get elvis => this ?? [];
}

extension WidgetOptionalEx on Widget? {
  Widget get elvis => this ?? const SizedBox();
}

extension WidgetEx on Widget {
  Widget get sliverBox => SliverToBoxAdapter(child: this);

  Widget get sliverFill => SliverFillRemaining(hasScrollBody: false, child: this);

  Widget get red => ColoredBox(color: Colors.red, child: this);

  Widget get green => ColoredBox(color: Colors.green, child: this);

  Widget get blue => ColoredBox(color: Colors.blue, child: this);
}
