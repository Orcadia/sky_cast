import 'package:flutter/material.dart';
import '../../../models/avwx.dart';

class AirportWidget extends StatelessWidget {
  final METAR metarAirportCode;
  // Ajoutez d'autres propriétés d'information sur l'aéroport si nécessaire

  AirportWidget({
    required this.metarAirportCode,
    // Ajoutez d'autres paramètres de constructeur si nécessaire
  });

  @override
  Widget build(BuildContext context) {
    // Obtenez les informations de l'aéroport en fonction du code
    // Remplacez ce bloc de code par votre logique pour récupérer les informations de l'aéroport en fonction du code
    String airportName = "trou";//metarAirportCode.icao;
    String? airportLocation = metarAirportCode.city;
    String? airportTemp = metarAirportCode.temperature;
    String? airportWeather = metarAirportCode.weather;

    return Container(
      width: double.infinity, // Prend toute la largeur de l'écran
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Bordure autour du conteneur
        borderRadius: BorderRadius.circular(10), // Coins arrondis du conteneur
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            airportName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          if (airportLocation != null)
            Text(
              'Location: $airportLocation', // Affiche la localisation si elle est disponible
              style: TextStyle(fontSize: 16),
            ),
          Text(
            '$airportTemp', // Affiche la localisation si elle est disponible
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Météo: $airportWeather', // Affiche la localisation si elle est disponible
            style: TextStyle(fontSize: 16),
          ),
          // Ajoutez ici d'autres informations sur l'aéroport si nécessaire
        ],
      ),
    );
  }

  // Fonction de simulation pour récupérer le nom de l'aéroport à partir du code
  String getAirportNameFromCode(String code) {
    // Ici, vous pouvez utiliser une logique pour récupérer le nom de l'aéroport en fonction du code
    // Pour l'exemple, nous renvoyons simplement un texte fixe
    return 'Nom de l\'aéroport $code';
  }

  // Fonction de simulation pour récupérer la localisation de l'aéroport à partir du code
  String? getAirportLocationFromCode(String code) {
    // Ici, vous pouvez utiliser une logique pour récupérer la localisation de l'aéroport en fonction du code
    // Pour l'exemple, nous renvoyons null pour indiquer que la localisation n'est pas disponible
    return 'Localisation de l\'aéroport $code';
  }
}
