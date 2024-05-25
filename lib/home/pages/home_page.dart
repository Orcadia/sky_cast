import 'package:flutter/material.dart';
import 'package:sky_cast/home/widgets/weather_screen.dart';
import 'package:sky_cast/models/avwx.dart';
import 'package:sky_cast/services/utils.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<METAR> metar;

  @override
  void initState() {
    super.initState();
    metar = fetchMetar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<METAR>(
        future: metar,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occured : ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return WeatherScreen(
                metar: snapshot.data!); // Call this widget to make the display
          } else {
            return const Center(child: Text('No datas available!'));
          }
        },
      ),
    );
  }
}
