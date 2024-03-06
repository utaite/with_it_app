import 'package:with_it/base/base.dart';
import 'package:with_it/ui/main/fragment/setting/state/main_setting_state.dart';

abstract base class MainSettingEvent extends BaseEvent {}

final class InitialEvent extends MainSettingEvent {
  InitialEvent({
    this.state,
  });

  final MainSettingState? state;

  @override
  List<Object?> get props => [state];
}

final class UntilPopEvent extends MainSettingEvent {}
