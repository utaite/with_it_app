import 'package:equatable/equatable.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';

mixin BaseErrorLoadingState on Equatable implements BaseLoadingState {
  GlobalException get error => GlobalException.empty();

  bool get isError => !error.isEmpty && error.isTypeText;

  @override
  Status get status {
    if (isLoading) {
      return Status.loading;
    } else if (isError) {
      return Status.error;
    } else if (isActive) {
      return Status.active;
    }

    return Status.empty;
  }

  @override
  List<Object?> get props => [...super.props, error];
}
