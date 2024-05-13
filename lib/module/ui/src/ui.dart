import 'package:flutter/material.dart';
import 'package:with_it/module/module.dart';

final class UI {
  static const SizedBox empty = SizedBox.shrink();
  static const Spacer spacer = Spacer();

  static const Radius radiusBottomSheet = Radius.circular(Values.radiusBottomSheetValue);
  static const Radius radiusButton = Radius.circular(Values.radiusButtonValue);
  static const Radius radiusCard = Radius.circular(Values.radiusCardValue);
  static const Radius radiusCardSmall = Radius.circular(Values.radiusCardSmallValue);
  static const Radius radiusCircle = Radius.circular(Values.radiusCircleValue);
  static const Radius radiusDialog = Radius.circular(Values.radiusDialogValue);
  static const Radius radiusGraph = Radius.circular(Values.radiusGraphValue);
  static const Radius radiusMessage = Radius.circular(Values.radiusMessageValue);
  static const Radius radiusTab = Radius.circular(Values.radiusTabValue);
  static const Radius radiusText = Radius.circular(Values.radiusTextValue);

  static const BorderRadius borderRadiusBottomSheet = BorderRadius.vertical(top: radiusBottomSheet);
  static const BorderRadius borderRadiusButton = BorderRadius.all(radiusButton);
  static const BorderRadius borderRadiusCard = BorderRadius.all(radiusCard);
  static const BorderRadius borderRadiusCardSmall = BorderRadius.all(radiusCardSmall);
  static const BorderRadius borderRadiusCircle = BorderRadius.all(radiusCircle);
  static const BorderRadius borderRadiusDialog = BorderRadius.all(radiusDialog);
  static const BorderRadius borderRadiusGraph = BorderRadius.all(radiusGraph);
  static const BorderRadius borderRadiusMessage = BorderRadius.all(radiusMessage);
  static const BorderRadius borderRadiusTab = BorderRadius.all(radiusTab);
  static const BorderRadius borderRadiusText = BorderRadius.all(radiusText);
}
