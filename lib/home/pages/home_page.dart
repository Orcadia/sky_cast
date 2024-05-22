import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sky_cast/models/avwx.dart';
import 'package:sky_cast/utils/utils.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  late Future<METAR> metar;

  void initState() {
    super.initState();
    metar = fetchMetar();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: FutureBuilder<METAR>(
            future: metar,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.raw + "\n" +
                    snapshot.data!.city + "\n" +
                    snapshot.data!.country + "\n" +
                    snapshot.data!.flight_rules + "\n" +
                    snapshot.data!.relative_humidity + "\n" +
                    snapshot.data!.time_of_capture + "\n" +
                    snapshot.data!.pressure + "\n" +
                    snapshot.data!.clouds + "\n" +
                    snapshot.data!.dewpoint + "\n" +
                    snapshot.data!.remarks + "\n" +
                    snapshot.data!.temperature + "\n" +
                    snapshot.data!.visibility + "\n" +
                    snapshot.data!.wind + "\n" +
                    snapshot.data!.weather + "\n");
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator(
                color: Colors.indigo,
              );
            }
        ),
      ),
    );
  }
}

