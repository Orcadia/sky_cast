import 'package:flutter/material.dart';
import 'package:sky_cast/details/widgets/airport_widget.dart';
import 'package:sky_cast/details/widgets/date_time_widget.dart';
import 'package:sky_cast/details/widgets/tableau_widget.dart';
import 'package:sky_cast/details/widgets/weather_info_widget.dart';

import '../models/avwx.dart';

class WeatherScreen extends StatelessWidget {
  final METAR metar;
  const WeatherScreen({super.key, required this.metar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Weather App'),
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header with date-time of capture
            DateTimeWidget(date: metar.time_of_capture),

            const SizedBox(height: 10),
            // airport information
            AirportDescription(city: metar.city, country: metar.country, other: metar.remarks),

            const SizedBox(height: 16),
            // meteorologic information grid
               GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  //_buildWeatherInfoCard('210° at 15kt', 'Wind'),
                  WeatherInfoWidget(title:metar.wind, subtitle: 'Wind'),
                  WeatherInfoWidget(title:metar.clouds, subtitle: 'Clouds'),
                  WeatherInfoWidget(title:metar.visibility, subtitle: 'Visibility'),
                  WeatherInfoWidget(title:metar.temperature, subtitle: 'Temperature'),
                ],
              ),

            // Section des informations supplémentaires
            const SizedBox(height: 16),
            Center( child: TableauWidget(data: [['Pressure', metar.pressure],
              ['Humidity', metar.relative_humidity],
              ['Dewpoint', metar.dewpoint]],)
            ),

            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Informations',
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
              child: const Center(
                child: Text(
                  'Aucune information supplémentaire',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
      // Barre de navigation en bas
      /*bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black54,
      ),*/
    );
  }
}
