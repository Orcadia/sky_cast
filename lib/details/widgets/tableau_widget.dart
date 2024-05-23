import 'package:flutter/material.dart';

class TableauWidget extends StatelessWidget {
  final List<List<String>> data;
  const TableauWidget({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container( 
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: data.map((row) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  row[0],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  row[1],
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ),
    );



  }
}
