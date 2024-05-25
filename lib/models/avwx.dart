import 'dart:convert';
import 'package:sky_cast/services/user_preferences.dart';

// This file aims to parse the given request into different variables
class METAR
{

  final String raw;
  final String station;
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
    required this.station,
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

  factory METAR.fromJson(Map<String, dynamic> json)
  {
    String pressure = json["translate"]["altimeter"];
    if (json["units"]["altimeter"] == "hPa") // Check the units of the pressure
    {
      pressure = pressure.substring(0, pressure.indexOf("("));
    }
    else
    {
      pressure = pressure.substring(pressure.indexOf("(")).replaceAll("(", "").replaceAll(")", "");
    }

    String visibility = json["translate"]["visibility"];
    if (json["units"]["visibility"] == "m") // Check the units of the visibility
    {
      visibility = visibility.substring(0, visibility.indexOf("("));
    }
    else
    {
      visibility = "${double.parse(visibility.substring(visibility.indexOf("(")).replaceAll("(", "").replaceAll("km)", "")).toStringAsFixed(0)}km";
    }

    String remarks = jsonEncode(json["translate"]["remarks"]).replaceAll("{" , "").replaceAll("}", "");
    if (remarks == "") // Check if the remarks is empty
    {
      remarks = "No remarks from this station";
    }
    else // Subdivide the remarks into n elements
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

    String weather = json["translate"]["wx_codes"];
    if (weather.isEmpty) { // Check if the weather is empty
      weather = "-";
    }

    String temperature = json["translate"]["temperature"];
    String dewpoint = json["translate"]["dewpoint"];
    final unitsValue = UserPreferences.getUnits();
    if (unitsValue != null && unitsValue) // Check if the unitsValue from shared preferences is true or false to display the correct unit
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
      station:            json["station"],
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
      weather:            weather,
    );
  }


  factory METAR.empty() {

    return const METAR(
      raw:                "",
      station:            "",
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