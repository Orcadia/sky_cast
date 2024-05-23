import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatelessWidget {

  final String date;

  const DateTimeWidget({super.key, required this.date });

  @override
  Widget build(BuildContext context) {
    return Text('$date (UTC)',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[700],
      ),
    );
  }
}
