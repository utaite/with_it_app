import 'package:equatable/equatable.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';

mixin BaseErrorLoadingState on Equatable implements BaseLoadingState {
  AppException get error => AppException.empty();

  bool get isError => !error.isEmpty;

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
