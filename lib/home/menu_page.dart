import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sky_cast/models/avwx.dart';
import 'package:sky_cast/utils/utils.dart';
import 'pages/home_page.dart' as Home;
import 'pages/search_page.dart' as Search;
import 'pages/fav_page.dart' as Fav;
import 'pages/setting_page.dart' as Setting;

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late Future<METAR> metar;
  int _selectedIndex = 0;

  void initState() {
    super.initState();
    metar = fetchMetar();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    Home.HomePage(), // Utilisez les classes des pages
    Search.SearchPage(), // Utilisez les classes des pages
    Fav.FavPage(), // Utilisez les classes des pages
    Setting.SettingPage(), // Utilisez les classes des pages
  ];

  final Map<int, Color> _selectedItemColors = {
    0: Colors.indigo,
    1: Colors.brown,
    2: Colors.red,
    3: Colors.black45,
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: const Text('SkyCast'),
      ),*/
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
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
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:  _selectedItemColors[_selectedIndex],
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
