import 'package:flutter/material.dart';

// Extension to convert color hex to Color
extension ColorHex on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    // FF make color's opacity 100%
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
