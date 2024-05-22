import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/common/dialog/dialog_cubit.dart';
import 'package:with_it/ui/common/dialog/dialog_error_state.dart';
import 'package:with_it/ui/common/dialog/dialog_state.dart';
import 'package:with_it/ui/widget/widget.dart';

extension BuildContextEx on BuildContext {
  T? arguments<T>() => ModalRoute.of(this)?.settings.arguments is T ? ModalRoute.of(this)?.settings.arguments as T : null;

  T singleton<T extends StateStreamableSource<Object?>>(T Function() create) {
    try {
      return read<T>();
    } on Exception {
      return create.call();
    }
  }

  Future<bool?> showDialog({
    required String content,
    String title = '안내',
    Iterable<Widget> children = const Iterable.empty(),
    String positive = '확인',
    ValueChanged<BuildContext>? onPressedPositive,
    bool isPositiveDestructiveAction = false,
    String? negative,
    ValueChanged<BuildContext>? onPressedNegative,
    bool isNegativeDestructiveAction = false,
    bool barrierDismissible = true,
  }) async {
    read<DialogCubit>().initial();

    return material.showDialog<bool>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        titlePadding: Paddings.paddingHorizontal16.copyWith(
          top: Paddings.paddingValue32,
        ),
        contentPadding: Paddings.paddingHorizontal16.copyWith(
          top: Paddings.paddingValue12,
          bottom: Paddings.paddingValue24,
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).dialogTheme.titleTextStyle,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              content,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            ...children,
            BlocSelector<DialogCubit, DialogState, GlobalException?>(
              selector: (state) => state is DialogErrorState ? state.error : null,
              builder: (context, error) => error is GlobalException
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...error.messages.expand(
                          (x) => [
                            Paddings.height12,
                            Text(
                              x,
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Resource.colorRed,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    )
                  : UI.empty,
            ),
          ],
        ),
        actions: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (negative is String) ...[
                  Expanded(
                    child: ClipRRect(
                      borderRadius: UI.borderRadiusButton,
                      child: FilledButtonThemeBuilder(
                        filledButtonTheme: isNegativeDestructiveAction
                            ? Theme.of(context).redFilledButtonTheme()
                            : Theme.of(context).isColoredFilledButtonTheme(isColored: false),
                        builder: (context) => FilledButton(
                          onPressed:
                              onPressedNegative is ValueChanged<BuildContext> ? () => onPressedNegative(context) : () => Navigator.of(context).pop(false),
                          child: Text(
                            negative,
                            style: Theme.of(context).filledButtonTextStyle(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Paddings.width8,
                ],
                Expanded(
                  child: ClipRRect(
                    borderRadius: UI.borderRadiusButton,
                    child: BlocBuilder<DialogCubit, DialogState>(
                      builder: (context, state) => FilledButtonThemeBuilder(
                        filledButtonTheme: isPositiveDestructiveAction
                            ? Theme.of(context).redFilledButtonTheme()
                            : Theme.of(context).isColoredFilledButtonTheme(isColored: true),
                        builder: (context) => FilledButton(
                          onPressed: state.isActive
                              ? state.isLoading
                                  ? () {}
                                  : onPressedPositive is ValueChanged<BuildContext>
                                      ? () => onPressedPositive(context)
                                      : () => Navigator.of(context).pop(true)
                              : null,
                          child: PlatformButtonPlaceholder(
                            isLoading: state.isLoading,
                            child: Text(
                              positive,
                              style: Theme.of(context).filledButtonTextStyle(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
