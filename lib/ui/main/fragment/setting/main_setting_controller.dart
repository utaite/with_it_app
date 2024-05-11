import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/ui/app/app_cubit.dart';
import 'package:with_it/ui/main/fragment/setting/main_setting_bloc.dart';
import 'package:with_it/ui/main/fragment/setting/state/main_setting_state.dart';

final class MainSettingController extends BaseController<MainSettingBloc, MainSettingState> with BaseRouteMixin, BaseUntilPopMixin {
  MainSettingController(this.context);

  @override
  final BuildContext context;

  void onPressedChange() {
    context.read<AppCubit>().toggleTheme();
  }
}
