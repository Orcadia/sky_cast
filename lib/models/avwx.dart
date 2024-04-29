class AVWX {
  final String raw;
  final String flight_rules;
  final String relative_humidity;
  /*final String time_of_capture;
  final String pressure;
  final String clouds;
  final String dewpoint;
  final String translate;
  final String remarks;
  final String temperature;
  final String visibility;
  final String wind;
  final String weather;*/

  const AVWX({
    required this.raw,
    required this.flight_rules,
    required this.relative_humidity,
    /*required this.time_of_capture,
    required this.pressure,
    required this.clouds,
    required this.dewpoint,
    required this.translate,
    required this.remarks,
    required this.temperature,
    required this.visibility,
    required this.wind,
    required this.weather,*/
  });

  factory AVWX.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'raw': String raw,
        'flight_rules': String flight_rules,
        'relative_humidity': double relative_humidity,
        /*'time_of_capture': String time_of_capture,
        'pressure': String pressure,
        'clouds': String clouds,
        'dewpoint': String dewpoint,
        'translate': String translate,
        'remarks': String remarks,
        'temperature': String temperature,
        'visibility': String visibility,
        'wind': String wind,
        'weather': String weather,*/
      } =>
          AVWX(
            raw: raw,
            flight_rules: flight_rules,
            relative_humidity: relative_humidity.toString(),
            /*time_of_capture: time_of_capture,
            pressure: pressure,
            clouds: clouds,
            dewpoint: dewpoint,
            translate: translate,
            remarks: remarks,
            temperature: temperature,
            visibility: visibility,
            wind: wind,
            weather: weather,*/
          ),
      _ => throw const FormatException('Failed to load METAR.'),
    };
  }
}
