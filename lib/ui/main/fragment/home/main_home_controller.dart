import 'package:flutter/material.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/ui/main/fragment/home/main_home_bloc.dart';
import 'package:with_it/ui/main/fragment/home/state/main_home_state.dart';

final class MainHomeController extends BaseController<MainHomeBloc, MainHomeState> with BaseRouteMixin, BaseUntilPopMixin {
  MainHomeController(this.context);

  @override
  final BuildContext context;

  void onPressedMore() {}
}
