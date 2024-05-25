import 'package:flutter/material.dart';
import 'package:sky_cast/home/widgets/weather_screen.dart';
import 'package:sky_cast/models/avwx.dart';
import 'package:sky_cast/services/user_preferences.dart';
import 'package:sky_cast/services/utils.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  String? _selectedIcao;

  // Get all the favorites from the saved preferences
  Future<List<String>> _getICAOs() async {
    return UserPreferences.getICAOs();
  }

  void _onDropdownChanged(String? newValue) async {
    setState(() {
      _selectedIcao = newValue; // Change the value of _selectedIcao
    });
    if (newValue != null && newValue != 'Select an ICAO') {
      METAR metar = await fetchMetar(
          newValue); // Fetch the metar with the correct newValue
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherScreen(metar: metar),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: _getICAOs(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<String> icaos = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedIcao,
                    hint: const Text('Select an ICAO'),
                    items: [
                      const DropdownMenuItem<String>(
                        // Dropdown menu of all favorites
                        value: 'Select an ICAO',
                        child: Text('Select an ICAO'),
                      ),
                      ...icaos.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ],
                    onChanged: _onDropdownChanged,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
                child: Text(
                    'No ICAO in the favorites found.')); // If no ICAO in the favorites
          }
        },
      ),
    );
  }
}
