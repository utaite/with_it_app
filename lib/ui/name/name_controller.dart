import 'package:flutter/material.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/model/model.dart';
import 'package:with_it/ui/name/name_bloc.dart';
import 'package:with_it/ui/name/name_event.dart';
import 'package:with_it/ui/name/state/name_state.dart';

final class NameController extends BaseController<NameBloc, NameState> with BaseRouteMixin {
  NameController(this.context);

  @override
  final BuildContext context;

  Future<void> onListen(BuildContext context, NameState state) async {
    await super.offNamed(RouteModel.main());
  }

  void onChangedName(String name) {
    bloc.add(ChangedNameEvent(name: name));
  }

  Future<void> onPressedConfirm() async {
    bloc.add(PressedConfirmEvent());
  }
}
