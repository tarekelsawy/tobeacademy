import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

extension StringExtension on String{
  String get capFirstChar => '${this[0].toUpperCase()}${substring(1)}';
  Color get color {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return kPrimary;
  }

  String get price => '$this ${'ج.م'}';

}