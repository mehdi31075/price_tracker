import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = HexColor("#303F9F");
  static Color secondaryColor = HexColor("#FFBB00");
  static Color successColor = HexColor("#00C247");
  static Color infoColor = HexColor("#004CE8");
  static Color warningColor = HexColor("#FFE16A");
  static Color dangerColor = HexColor("#FF3333");
  static Color disabledColor = HexColor("#D8D8D8");
  static Color disabledButtonColor = HexColor("#BEBEBE");
  static Color txtHeaderColor = HexColor("#3F3F3F");
  static Color txtBodyColor = HexColor("#747474");
  static Color grey900Color = HexColor("#212121");
  static Color grey800Color = HexColor("#424242");
  static Color grey700Color = HexColor("#616161");
  static Color grey600Color = HexColor("#757575");
  static Color grey500Color = HexColor("#9E9E9E");
  static Color grey400Color = HexColor("#BDBDBD");
  static Color grey300Color = HexColor("#E0E0E0");
  static Color grey200Color = HexColor("#E9E9E9");
  static Color grey100Color = HexColor("#F5F5F5");
  static Color bgPrimaryColor = HexColor("#FAFAFA");
  static Color fgPrimaryColor = HexColor("#FDFDFD");
  static Color hintColor = HexColor("#C8C8C8");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
