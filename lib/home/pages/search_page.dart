import 'package:flutter/material.dart';
import 'package:sky_cast/home/widgets/weather_screen.dart';
import 'package:sky_cast/services/user_preferences.dart';
import 'package:sky_cast/services/utils.dart';
import 'package:sky_cast/models/avwx.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textEditingController = TextEditingController();
  METAR? _metar;
  String? _searchResult;
  String _errorMessage = '';
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLength: 4,
                        controller: _textEditingController,
                        textCapitalization: TextCapitalization.characters,
                        onChanged: (value) {
                          _search(
                              value); // Execute search each time text changes
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter ICAO code',
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(8), // Added this
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Center(
                        child: Row(children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: IconButton(
                            icon: isFavorite
                                ? const Icon(
                                    size: 40, color: Colors.red, Icons.favorite)
                                : const Icon(
                                    size: 40,
                                    color: Colors.red,
                                    Icons.favorite_border),
                            onPressed: () async {
                              if (_metar != null) {
                                if (isFavorite) {
                                  // Add ICAO to favorites
                                  await UserPreferences()
                                      .removeICAO(_metar!.station);
                                } else {
                                  // Remove ICAO from favorites
                                  await UserPreferences()
                                      .setICAO(_metar!.station);
                                }
                                // Update the value of isFavorite
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              }
                            },
                          ))
                    ])),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      return const Center(
        child: Text('No result'),
      );
    } else {
      return WeatherScreen(
        metar: _metar!,
      );
    }
  }

  void _search(String searchText) async {
    if (searchText.isEmpty) {
      setState(() {
        _metar = null;
        _errorMessage = 'No ICAO code entered';
        isFavorite = false; // Update the value of isFavorite
      });
      return;
    }

    try {
      METAR metar = await fetchMetar(searchText.toUpperCase());
      bool isICAOSaved = await UserPreferences().isICAOSaved(searchText);

      setState(() {
        _metar = metar;
        _searchResult = searchText;
        _errorMessage = '';
        isFavorite = isICAOSaved; // Update the value of isFavorite
      });
    } catch (e) {
      setState(() {
        _metar = null;
        _errorMessage = 'There is no airport with ICAO: $searchText';
        isFavorite = false; // Update the value of isFavorite
      });
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
