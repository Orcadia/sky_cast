import 'package:flutter/material.dart';
import 'package:sky_cast/models/avwx.dart';
import 'package:sky_cast/services/utils.dart';
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

  @override
  void initState() {
    super.initState();
    metar = fetchMetar();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const Home.HomePage(), // Utilisez les classes des pages
    const Search.SearchPage(), // Utilisez les classes des pages
    const Fav.FavPage(), // Utilisez les classes des pages
    const Setting.SettingPage(), // Utilisez les classes des pages
  ];

  final Map<int, Color> _selectedItemColors = {
    0: Colors.indigo,
    1: Colors.brown,
    2: Colors.red,
    3: Colors.black45,
  };

  final Map<int, Icon> _selectedTitle = {
    0: const Icon(size: 50, color: Colors.indigo, Icons.home),
    1: const Icon(size: 50, color: Colors.brown, Icons.search),
    2: const Icon(size: 50, color: Colors.red, Icons.favorite),
    3: const Icon(size: 50, color: Colors.black45, Icons.settings),
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: _selectedTitle[_selectedIndex]!,
      )),
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
        selectedItemColor: _selectedItemColors[_selectedIndex],
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
