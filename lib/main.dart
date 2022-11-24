import "dart:ui" as ui;
import 'package:app/app.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MediaQuery(
      data: MediaQueryData.fromWindow(ui.window),
      child: const Directionality(
          textDirection: TextDirection.ltr, child: MyApp())));
}
