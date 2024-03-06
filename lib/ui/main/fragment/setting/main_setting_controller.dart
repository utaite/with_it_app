import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinf/rinf.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/messages/test.pb.dart' as test;
import 'package:with_it/messages/test.pb.dart';
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

  Future<void> onPressedTest() async {
    final request = TestRequest(
      input: Int64(6888),
    );

    final result = await requestToRust(
      RustRequest(
        resource: test.ID,
        operation: RustOperation.Read,
        message: request.writeToBuffer(),
      ),
    );

    final response = TestResponse.fromBuffer(result.message ?? []);
    debugPrint('response.output: ${response.output}');
  }
}
