import 'package:nsmeteo/models/futureWeatherData.dart';
import 'package:intl/intl.dart';
import 'package:nsmeteo/utils/Ui.dart';

class TransformData {
  static List<List<dynamic>> MinMaxByDays(FutureWeatherData fWeatherData) {
    int currentDay = 0;
    String? currentDayTxt = "";
    List<int> tempDay = [];
    List<String> iconname = [];
    List<dynamic> MinMaxDay = [];
    List<List<dynamic>> result = [];
    fWeatherData.list!.forEach((element) {
      if (DateTime.parse("${element.dtTxt}").day == currentDay ||
          currentDay == 0) {
        tempDay.add(element.main!.temp!.round());
        iconname.add(UiUtils.getIcons(element.weather![0].id.toString()));
      } else {
        tempDay.sort();
        MinMaxDay.add(tempDay[0]);
        MinMaxDay.add(tempDay[tempDay.length - 1]);
        MinMaxDay.add(
            DateFormat('EEEE').format(DateTime.parse("${currentDayTxt}")));
        MinMaxDay.add(getTheIcon(iconname));
        result.add(MinMaxDay);
        tempDay = [];
        MinMaxDay = [];
        iconname = [];
        tempDay.add(element.main!.temp!.round());
      }
      currentDayTxt = element.dtTxt;
      currentDay = DateTime.parse("${element.dtTxt}").day;
    });
    return result;
  }

  static String getTheIcon(List<String> myList) {
    String resp = "";
    myList.forEach((element) {
      if (resp == "") {
        resp = element;
      } else {
        if (element == "thunder.png") {
          resp = "thunder.png";
        } else if (element == "rain.png") {
          if (resp == "sun.png" ||
              resp == "cloudysun.png" ||
              resp == "haze.png" ||
              resp == "wind.png" ||
              resp == "snow.png") {
            resp = "rain.png";
          }
        } else if (element == "snow.png") {
          if (resp == "sun.png" ||
              resp == "cloudysun.png" ||
              resp == "haze.png" ||
              resp == "wind.png") {
            resp = "snow.png";
          }
        } else if (element == "wind.png") {
          if (resp == "sun.png" ||
              resp == "cloudysun.png" ||
              resp == "haze.png") {
            resp = "wind.png";
          }
        } else if (element == "haze.png") {
          if (resp == "sun.png" || resp == "cloudysun.png") {
            resp = "haze.png";
          }
        } else if (element == "cloudysun.png") {
          if (resp == "sun.png") {
            resp = "cloudysun.png";
          }
        } else if (element == "sun.png") {}
      }
    });
    return resp;
  }

  static String ConvertDayInFrench(String day) {
    String newday = "";
    switch (day) {
      case "Monday":
        {
          newday = "Lun.";
        }
        break;
      case "Tuesday":
        {
          newday = "Mar.";
        }
        break;
      case "Wednesday":
        {
          newday = "Mer.";
        }
        break;
      case "Thursday":
        {
          newday = "Jeu.";
        }
        break;
      case "Friday":
        {
          newday = "Ven.";
        }
        break;

      case "Saturday":
        {
          newday = "Sam.";
        }
        break;
      case "Sunday":
        {
          newday = "Dim.";
        }
        break;
    }
    return newday;
  }
}
