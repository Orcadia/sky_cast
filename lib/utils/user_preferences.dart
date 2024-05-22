import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  
  static Future setUnits(bool units) async =>
      await _preferences?.setBool("units", units);

  static bool? getUnits() => _preferences?.getBool("units");

  int id = -1;
  Future setICAO(String ICAO) async =>
      await _preferences?.setString((id++).toString(), ICAO);

  static String? getICAO(int id) => _preferences?.getString(id.toString());
}