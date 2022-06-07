import 'dart:ui';

class Ui {
  static Color HexaColor(String strcolor, {int opacity = 15}) {
    strcolor = strcolor.replaceAll("#", "");
    String stropacity = opacity.toRadixString(16);
    return Color(int.parse("$stropacity$stropacity" + strcolor, radix: 16));
  }
}
