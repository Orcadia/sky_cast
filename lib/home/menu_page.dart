import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:sky_cast/models/avwx.dart';
import 'pages/home_page.dart' as Home;
import 'pages/search_page.dart' as Search;
import 'pages/fav_page.dart' as Fav;
import 'pages/setting_page.dart' as Setting;

class Menupage extends StatefulWidget {
  const Menupage({Key? key}) : super(key: key);

  @override
  State<Menupage> createState() => _HomePageState();
}

class _HomePageState extends State<Menupage> {
  late Future<METAR> metar;
  int _selectedIndex = 0;

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

  Future<METAR> fetchMetar() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    final response = await http.get(Uri.parse('http://82.66.114.193:8000/api/metar/${position.latitude},${position.longitude}?options=translate'));
    if (response.statusCode == 200) {
      return METAR.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load METAR');
    }
  }

  static final List<Widget> _widgetOptions = <Widget>[
    Home.Homepage(), // Utilisez les classes des pages
    Search.Searchpage(), // Utilisez les classes des pages
    Fav.Favpage(), // Utilisez les classes des pages
    Setting.Settingpage(), // Utilisez les classes des pages
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SkyCast'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
