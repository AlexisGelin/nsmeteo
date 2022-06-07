import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';

class UiUtils {
  static Color HexaColor(String strcolor, {int opacity = 15}) {
    strcolor = strcolor.replaceAll("#", "");
    String stropacity = opacity.toRadixString(16);
    return Color(int.parse("$stropacity$stropacity" + strcolor, radix: 16));
  }

  static String getIcons(String id) {
    if (id == "701" ||
        id == "622" ||
        id == "621" ||
        id == "620" ||
        id == "616" ||
        id == "615" ||
        id == "531" ||
        id == "522" ||
        id == "521" ||
        id == "520" ||
        id == "511" ||
        id == "504" ||
        id == "503" ||
        id == "502" ||
        id == "501" ||
        id == "500" ||
        id == "321" ||
        id == "314" ||
        id == "313" ||
        id == "312" ||
        id == "311" ||
        id == "310" ||
        id == "302" ||
        id == "301" ||
        id == "300") {
      return "rain.png";
    } else if (id == "232" ||
        id == "231" ||
        id == "230" ||
        id == "221" ||
        id == "212" ||
        id == "211" ||
        id == "210" ||
        id == "202" ||
        id == "201" ||
        id == "960" ||
        id == "200" ||
        id == "961") {
      return "thunder.png";
    } else if (id == "962" ||
        id == "959" ||
        id == "958" ||
        id == "957" ||
        id == "956" ||
        id == "955" ||
        id == "954" ||
        id == "953" ||
        id == "952" ||
        id == "905" ||
        id == "902" ||
        id == "901" ||
        id == "900" ||
        id == "781" ||
        id == "771" ||
        id == "761" ||
        id == "751" ||
        id == "731") {
      return "wind.png";
    } else if (id == "906" ||
        id == "903" ||
        id == "612" ||
        id == "611" ||
        id == "602" ||
        id == "601" ||
        id == "600") {
      return "snow.png";
    } else if (id == "762" || id == "741" || id == "721" || id == "711") {
      return "haze.png";
    } else if (id == "801" || id == "802" || id == "803" || id == "804") {
      return "cloudysun.png";
    } else {
      return "sun.png";
    }
  }
}
