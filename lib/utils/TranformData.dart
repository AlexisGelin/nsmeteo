import 'package:nsmeteo/models/futureWeatherData.dart';
import 'package:intl/intl.dart';

class TransformData {
  static List<List<dynamic>> MinMaxByDays(FutureWeatherData fWeatherData) {
    num currentDay = 0;
    String? currentDayTxt = "";
    List<num> tempDay = [];
    List<dynamic> MinMaxDay = [];
    List<List<dynamic>> result = [];
    fWeatherData.list!.forEach((element) {
      if (DateTime.parse("${element.dtTxt}").day == currentDay ||
          currentDay == 0) {
        tempDay.add(element.main!.temp!.round());
      } else {
        tempDay.sort();
        MinMaxDay.add(tempDay[0]);
        MinMaxDay.add(tempDay[tempDay.length - 1]);
        MinMaxDay.add(
            DateFormat('EEEE').format(DateTime.parse("${currentDayTxt}")));
        result.add(MinMaxDay);
        tempDay = [];
        MinMaxDay = [];
        tempDay.add(element.main!.temp!.round());
      }
      currentDayTxt = element.dtTxt;
      currentDay = DateTime.parse("${element.dtTxt}").day;
    });
    return result;
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
