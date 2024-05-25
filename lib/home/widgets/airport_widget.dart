import 'package:flutter/material.dart';

class AirportDescription extends StatelessWidget {
  final String city;
  final String country;
  final String icao;

  const AirportDescription(
      {super.key,
      required this.city,
      required this.country,
      required this.icao});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.lightBlue,
            Colors.blue,
            Colors.blueAccent,
            Colors.indigo
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            '$icao - $city airport ($country)',
            // Display the data from the API in the element
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          const Icon(
            Icons.flight,
            color: Colors.white,
            size: 24,
          ),
        ],
      ),
    );
  }
}
