import 'package:with_it/base/base.dart';
import 'package:with_it/ui/main/model/main_model.dart';

base class MainState extends BaseModel with BaseState {
  const MainState({
    required this.model,
  });

  factory MainState.values() => _values;

  final MainModel model;

  static final MainState _empty = MainState(
    model: MainModel.empty(),
  );

  static final MainState _values = _empty.copyWith(
    model: MainModel.values(),
  );

  @override
  bool get isEmpty => this == _empty;

  @override
  MainState copyWith({
    MainState? state,
    MainModel? model,
  }) =>
      MainState(
        model: model ?? state?.model ?? this.model,
      );

  @override
  List<Object?> get props => [model];
}
