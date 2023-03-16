import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color buttonColor = "#004539".toColor();
Color bgColor = "#99b8b2".toColor();
Color borderColor = "#b3cac5".toColor();
Color hintColor = "#7E7E7E".toColor();
Color fieldBg = "#F4F4F4".toColor();
Color bgWhite = "#FDFDFD".toColor();
Color lightBorder = "#F1F1F1".toColor();
Color textHintColor = "#A5A4AA".toColor();

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

setStatusBarColor(Color color) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: color,
  ));
}
