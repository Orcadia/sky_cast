import 'package:flutter/material.dart';
import 'widget/airport_widget.dart';
import 'package:sky_cast/utils/utils.dart';
import 'package:sky_cast/models/avwx.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  TextEditingController _textEditingController = TextEditingController();
  METAR? _metar;
  String? _searchResult;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 4,
                controller: _textEditingController,
                onChanged: (value) {
                  _search(value); // Exécute la recherche chaque fois que le texte change
                },
                decoration: InputDecoration(
                  labelText: 'Entrez le code ICAO',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Text(_errorMessage),
      );
    } else if (_metar == null) {
      return Center(
        child: Text('Aucun résultat de recherche'),
      );
    } else {
      return AirportWidget(
        metarAirportCode: _metar!,
      );
    }
  }

  void _search(String searchText) async {
    if (searchText.isEmpty) {
      setState(() {
        _metar = null;
        _errorMessage = 'Aucun code ICAO entré';
      });
      return;
    }

    try {
      METAR metar = await fetchMetar(searchText.toUpperCase());
      setState(() {
        _metar = metar;
        _searchResult = searchText;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _metar = null;
        _errorMessage = 'Il n\'existe pas d\'aéroport avec le code $searchText';
      });
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
