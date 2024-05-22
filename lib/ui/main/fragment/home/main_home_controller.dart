import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:with_it/base/base.dart';
import 'package:with_it/module/module.dart';
import 'package:with_it/ui/common/bottom_sheet/date_time/date_time_bottom_sheet_cubit.dart';
import 'package:with_it/ui/common/bottom_sheet/date_time/date_time_bottom_sheet_state.dart';
import 'package:with_it/ui/main/fragment/home/main_home_bloc.dart';
import 'package:with_it/ui/main/fragment/home/main_home_event.dart';
import 'package:with_it/ui/main/fragment/home/state/main_home_state.dart';
import 'package:with_it/ui/widget/widget.dart';

final class MainHomeController extends BaseController<MainHomeBloc, MainHomeState> with BaseRouteMixin, BaseUntilPopMixin {
  MainHomeController(this.context);

  @override
  final BuildContext context;

  Future<void> onPressedDate() async {
    final cubit = context.read<DateTimeBottomSheetCubit>()..initial(dateTime: state.request.dateTime);
    final result = await showModalBottomSheet<DateTime?>(
      context: context,
      useRootNavigator: true,
      builder: (context) => Material(
        shape: const RoundedRectangleBorder(
          borderRadius: UI.borderRadiusBottomSheet,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: PlatformButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Padding(
                  padding: Paddings.paddingAll16,
                  child: Icon(
                    Icons.close,
                    color: Resource.colorGrey[S.s600.s],
                  ),
                ),
              ),
            ),
            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Resource.colorGrey[S.s700.s],
                        ),
                  ),
                ),
                child: CupertinoDatePicker(
                  onDateTimeChanged: cubit.change,
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: cubit.state.dateTime,
                  maximumYear: DateTime.now().year,
                  itemExtent: Paddings.paddingValue40 + Paddings.paddingValue8,
                ),
              ),
            ),
            Padding(
              padding: Paddings.paddingHorizontal16,
              child: BlocSelector<DateTimeBottomSheetCubit, DateTimeBottomSheetState, DateTime>(
                selector: (state) => state.dateTime,
                builder: (context, dateTime) => FilledButton(
                  onPressed: dateTime.midnight.isBefore(DateTime.now()) ? () => Navigator.of(context).pop(cubit.state.dateTime) : null,
                  child: Text(
                    '${dateTime.fullDate} 선택',
                    style: Theme.of(context).filledButtonTextStyle(),
                  ),
                ),
              ),
            ),
            Paddings.height24,
          ],
        ),
      ),
    );

    if (result is DateTime) {
      bloc.add(ChangedDateTimeEvent(dateTime: result));
    }
  }

  Future<void> onPressedMore(int planId) async {
    final result = await showModalBottomSheet<int?>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => Material(
        shape: const RoundedRectangleBorder(
          borderRadius: UI.borderRadiusBottomSheet,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Paddings.width16,
                Expanded(
                  child: Text(
                    '과목명 선택',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Resource.colorBlack,
                        ),
                  ),
                ),
                PlatformButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Padding(
                    padding: Paddings.paddingAll16,
                    child: Icon(
                      Icons.close,
                      color: Resource.colorGrey[S.s600.s],
                    ),
                  ),
                ),
              ],
            ),
            ...state.homeRead.data.subjects.indexed.expand(
              (x) => [
                if (x.$1.isPositive) Paddings.height8,
                ListTile(
                  onTap: () => Navigator.of(context).pop(x.$2.id.toInt()),
                  contentPadding: Paddings.paddingHorizontal16,
                  leading: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(int.parse(x.$2.backgroundColor.toInt().toRadixString(16).substring(0, 6), radix: 16) + 0xFF000000),
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: Text(
                          x.$2.code,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Color(int.parse(x.$2.color.toInt().toRadixString(16).substring(0, 6), radix: 16) + 0xFF000000),
                              ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(x.$2.name),
                ),
              ],
            ),
            Paddings.height16,
            Padding(
              padding: Paddings.paddingHorizontal16,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(-1),
                child: Text(
                  '기록 삭제하기',
                  style: Theme.of(context).filledButtonTextStyle(),
                ),
              ),
            ),
            Paddings.height16,
          ],
        ),
      ),
    );

    if (result is int) {
      if (result == -1) {
        bloc.add(DeleteEvent(planId: planId));
      } else {
        bloc.add(UpdateEvent(planId: planId, subjectId: result));
      }
    }
  }

  void onPressedShare() {}

  Future<void> onRefresh() async {
    bloc.add(ReadEvent());
  }
}
