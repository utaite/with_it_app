import 'package:equatable/equatable.dart';

abstract base class BaseModel extends Equatable {
  const BaseModel();

  bool get isEmpty;

  BaseModel copyWith();

  @override
  bool? get stringify => true;
}
