import 'dart:convert';
import 'package:sky_cast/utils/user_preferences.dart';

class METAR {

  final String raw;
  final String city;
  final String country;
  final String flight_rules;
  final String relative_humidity;
  final String time_of_capture;
  final String pressure;
  final String clouds;
  final String dewpoint;
  final String remarks;
  final String temperature;
  final String visibility;
  final String wind;
  final String weather;

  const METAR({
    required this.raw,
    required this.city,
    required this.country,
    required this.flight_rules,
    required this.relative_humidity,
    required this.time_of_capture,
    required this.pressure,
    required this.clouds,
    required this.dewpoint,
    required this.remarks,
    required this.temperature,
    required this.visibility,
    required this.wind,
    required this.weather,
  });

  factory METAR.fromJson(Map<String, dynamic> json) {
    //print(json["translate"]["clouds"]);
    String pressure = json["translate"]["altimeter"];
    if (json["units"]["altimeter"] == "hPa")
    {
      pressure = pressure.substring(0, pressure.indexOf("("));
    }
    else
    {
      pressure = pressure.substring(pressure.indexOf("(")).replaceAll("(", "").replaceAll(")", "");
    }

    String visibility = json["translate"]["visibility"];
    if (json["units"]["visibility"] == "m")
    {
      visibility = visibility.substring(0, visibility.indexOf("("));
    }
    else
    {
      visibility = "${double.parse(visibility.substring(visibility.indexOf("(")).replaceAll("(", "").replaceAll("km)", "")).toStringAsFixed(0)}km";
    }

    String remarks = jsonEncode(json["translate"]["remarks"]).replaceAll("{" , "").replaceAll("}", "");
    if (remarks == "")
    {
      remarks = "No remarks";
    }
    else
    {
      List<String> parts = remarks.split(',');
      remarks = "";
      for (int i = 0; i < parts.length; i++)
      {
        String s = parts[i];
        if (s.isNotEmpty && s.contains(":"))
        {
          remarks += s.substring(s.indexOf(":")).replaceAll(":\"", "").replaceAll("\"", "");
          if (i != parts.length - 1)
          {
            remarks += "\n";
          }
        }
      }
    }

    String temperature = json["translate"]["temperature"];
    String dewpoint = json["translate"]["dewpoint"];
    final unitsValue = UserPreferences.getUnits();
    if (unitsValue != null && unitsValue)
    {
      temperature = temperature.substring(0, json["translate"]["temperature"].indexOf("("));
      dewpoint = json["translate"]["dewpoint"].substring(0,json["translate"]["dewpoint"].indexOf("("));
    }
    else
    {
      temperature = temperature.substring(temperature.indexOf("(")).replaceAll("(", "").replaceAll(")", "");
      dewpoint = dewpoint.substring(dewpoint.indexOf("(")).replaceAll("(", "").replaceAll(")", "");
    }

    return METAR(
      raw:                json["raw"],
      city:               json["info"]["city"],
      country:            json["info"]["country"],
      flight_rules:       json["flight_rules"],
      relative_humidity:  json["relative_humidity"] * 100 % 10 == 0 ? "${(json["relative_humidity"] * 100).toStringAsFixed(0)} %" : "${(json["relative_humidity"] * 100).toStringAsFixed(2)} %",
      time_of_capture:    json["time"]["dt"].replaceAll("T", " ").replaceAll(":00Z", ""),
      pressure:           pressure,
      clouds:             json["translate"]["clouds"],
      dewpoint:           dewpoint,
      remarks:            remarks,
      temperature:        temperature,
      visibility:         visibility,
      wind:               json["translate"]["wind"],
      weather:            json["translate"]["wx_codes"],
    );
  }


  factory METAR.empty() {

    return METAR(
      raw:                "",
      city:               "",
      country:            "",
      flight_rules:       "",
      relative_humidity:  "",
      time_of_capture:    "",
      pressure:           "",
      clouds:             "",
      dewpoint:           "",
      remarks:            "",
      temperature:        "",
      visibility:         "",
      wind:               "",
      weather:            "",
    );
  }
}

class TAF {
  
}