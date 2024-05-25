import 'package:flutter/material.dart';
import 'package:sky_cast/home/widgets/airport_widget.dart';
import 'package:sky_cast/home/widgets/date_time_widget.dart';
import 'package:sky_cast/home/widgets/tableau_widget.dart';
import 'package:sky_cast/home/widgets/weather_info_widget.dart';
import 'package:sky_cast/home/widgets/weather_info_widget_big.dart';
import 'package:sky_cast/models/avwx.dart';

class WeatherScreen extends StatelessWidget {
  final METAR metar;

  const WeatherScreen({super.key, required this.metar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header with date-time of capture
              DateTimeWidget(date: metar.time_of_capture),
              // Widget to display the time of the capture (from the API)

              const SizedBox(height: 10),
              // airport information
              AirportDescription(
                  city: metar.city,
                  country: metar.country,
                  icao: metar.station),
              // Widget to display the city, the country and the station of the capture (from the API)

              const SizedBox(height: 16),

              WeatherInfoBigWidget(title: metar.clouds, subtitle: "Clouds"),
              // Widget to display the cloud (from the API)
              const SizedBox(height: 6),
              WeatherInfoBigWidget(title: metar.wind, subtitle: "Wind"),
              // Widget to display the wind (from the API)

              const SizedBox(height: 6),
              // meteorologic information grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  WeatherInfoWidget(
                      title: metar.flight_rules, subtitle: 'Flight rules'),
                  // Widget to display the flight rules (from the API)
                  WeatherInfoWidget(
                      title: metar.visibility, subtitle: 'Visibility'),
                  // Widget to display the visibility (from the API)
                  WeatherInfoWidget(title: metar.weather, subtitle: 'Weather'),
                  // Widget to display the weather condition (from the API)
                  WeatherInfoWidget(
                      title: metar.temperature, subtitle: 'Temperature'),
                  // Widget to display the temperature (from the API)
                ],
              ),

              const SizedBox(height: 16),
              Center(
                  child: TableauWidget(
                data: [
                  ['Pressure', metar.pressure],
                  // Widget to display the pressure, relative humidity and the dewpoint (from the API)
                  ['Humidity', metar.relative_humidity],
                  ['Dewpoint', metar.dewpoint]
                ],
              )),

              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Remarks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    metar.remarks,
                    // Display the remarks of the station (from the API)
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
