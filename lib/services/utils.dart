import 'dart:convert';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:sky_cast/models/avwx.dart';

// Get the current locaation of the phone
Future<String> getLocation() async {
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  /*print(position.latitude);
  print(position.longitude);*/ // For debugging purpose

  return "${position.latitude},${position.longitude}";
}

// Request the permission to access the location of the phone
Future<bool> requestLocationPermissions() async {
  final PermissionStatus statusWhenInUse =
      await Permission.locationWhenInUse.request();
  if (statusWhenInUse.isGranted) {
    return true;
  } else if (statusWhenInUse.isDenied) {
    return false;
  } else if (statusWhenInUse.isPermanentlyDenied) {
    await openAppSettings();
    return false;
  } else {
    return false;
  }
}

// Fetch the METAR with the current location or with the given ICAO
Future<METAR> fetchMetar([String? icao]) async {
  if (icao != null) {
    final response = await http
        .get(Uri.parse('http://[YOUR_SERVER_IP]:8000/api/metar/$icao?options=translate,info'));
    if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
      return METAR.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.git c
      throw Exception('Failed to load METAR');
    }
  } else {
    if (await requestLocationPermissions()) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      final response = await http
          .get(Uri.parse('http://[YOUR_SERVER_IP]:8000/api/metar/${position.latitude},${position.longitude}?options=translate,info'));
      if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
        return METAR
            .fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.git c
        throw Exception('Failed to load METAR');
      }
    } else {
      return METAR.empty();
    }
  }
}