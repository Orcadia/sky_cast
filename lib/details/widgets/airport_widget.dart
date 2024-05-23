import 'package:flutter/material.dart';

class AirportDescription extends StatelessWidget {
  final String city;
  final String country;
  final String other;

  const AirportDescription(
      {super.key,
      required this.city,
      required this.country,
      required this.other});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.cyan, Colors.blue],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            '$other - $city airport, ($country)',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 10),
          Icon(
            Icons.flight,
            color: Colors.black,
            size: 24,
          ),
        ],
      ),
    );
  }
}
