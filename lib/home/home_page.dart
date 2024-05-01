import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:sky_cast/models/avwx.dart';



class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}



class _HomePageState extends State<Homepage> {
  late Future<METAR> metar;

  void initState() {
    super.initState();
    metar = fetchMetar();
  }


  Future<String> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position.latitude);
    print(position.longitude);

    return "${position.latitude},${position.longitude}";
  }

  Future<METAR> fetchMetar() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    final response = await http
        //.get(Uri.parse('http://192.168.152.11:8000/api/metar/' + '${position.latitude},${position.longitude}' + '?options=translate'));
        .get(Uri.parse('http://192.168.1.130:8000/api/metar/' + '${position.latitude},${position.longitude}' + '?options=translate'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return METAR.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load METAR');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        /*child: ElevatedButton(
          //color: Colors.red,
          onPressed: () async {
            await getLocation();
          },
          child: Text('Get Location'),
        ),*/
        child: FutureBuilder<METAR>(
        future: metar,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.raw + "\n" +
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
          return const CircularProgressIndicator();
        }
        ),
      ),
    );
  }
}

