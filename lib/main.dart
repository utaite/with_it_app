import 'package:flutter/material.dart';
import 'package:rinf/rinf.dart';
import 'package:with_it/model/model.dart';
import 'package:with_it/ui/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Rinf.ensureInitialized();

  runApp(
    App(
      initialRoute: RouteModel.main(),
    ),
  );
}
