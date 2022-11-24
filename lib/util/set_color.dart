import 'package:app/util/design.dart';
import 'package:flutter/animation.dart';

Color setColor(String color) {
  Color newColor;

  if (color == "blue") {
    newColor = Design.lightBlue;
  } else {
    newColor = Design.primaryYellow;
  }

  return newColor;
}
