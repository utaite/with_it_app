import 'package:with_it/base/base.dart';

mixin BaseUntilPopMixin<T extends BaseUntilPopState> on BaseMixin {
  bool listenWhenUntilPop(T previous, T current) => !previous.isUntilPop && current.isUntilPop;
}
