import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
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

  Future<bool> requestLocationPermissions() async {
    final PermissionStatus statusWhenInUse = await Permission.locationWhenInUse.request();
    if (statusWhenInUse.isGranted) {
      return true;
    } else if (statusWhenInUse.isDenied) {
      return false;
    } else if (statusWhenInUse.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
    else
    {
      return false;
    }
  }

  Future<METAR> fetchMetar() async {
    if(await requestLocationPermissions())
    {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      final response = await http
      //.get(Uri.parse('http://192.168.1.130:8000/api/metar/${position.latitude},${position.longitude}?options=translate')); // For debugging purposes
          .get(Uri.parse('http://82.66.114.193:8000/api/metar/${position.latitude},${position.longitude}?options=translate,info'));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return METAR.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.git c
        throw Exception('Failed to load METAR');
      }
    }
    else
      return METAR.empty();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            color: Colors.lightBlue,
          );
        }
        ),
      ),
    );
  }
}

