import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;
  static const String _idKey = 'icao_id';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  // Save the bool for the temperature unit
  static Future setUnits(bool units) async =>
      await _preferences?.setBool("units", units);

  // Return the value of the temperature unit
  static bool? getUnits() => _preferences?.getBool("units");

  // Save the given ICAO
  Future setICAO(String ICAO) async {
    if (!await isICAOSaved(ICAO)) {
      int id = _getNextId();
      final String key = id.toString();
      await _preferences?.setString(key, ICAO);
      await _preferences?.setInt(_idKey, id);
    }
  }

  int _getNextId() {
    int id = _preferences?.getInt(_idKey) ?? 0;
    return id + 1;
  }

  // Remove the giving ICAO from shared preferences
  Future<void> removeICAO(String ICAO) async {
    final Set<String>? keys = _preferences?.getKeys();
    if (keys != null) {
      for (String key in keys) {
        final dynamic value = _preferences?.get(key);
        if (value is String && value == ICAO) {
          await _preferences?.remove(key);
          break;
        }
      }
    }
  }

  // Check if an ICAO already exists in the shared preferences
  Future<bool> isICAOSaved(String ICAO) async {
    final Set<String>? keys = _preferences?.getKeys();
    if (keys != null) {
      for (String key in keys) {
        final dynamic value = _preferences?.get(key);
        if (value is String && value == ICAO) {
          return true;
        }
      }
    }
    return false;
  }

  // Return a specific ICAO
  static String? getICAO(String id) => _preferences?.getString(id);

  // Return a List of all ICAO ids saved
  static List<String> getICAOIds() {
    final keys = _preferences?.getKeys();
    List<String> ids = [];
    if (keys != null) {
      for (String key in keys) {
        if (key.length == 1) {
          ids.add(key);
        }
      }
    }
    return ids;
  }

  // Return a List of all ICAOs saved
  static List<String> getICAOs() {
    final keys = UserPreferences.getICAOIds();
    List<String> ICAOs = [];
    if (keys != null) {
      for (String key in keys) {
          ICAOs.add(getICAO(key)!);
      }
    }
    return ICAOs;
  }

  // For debugging purpose: show all the favorites in console
  Future<void> checkSharedPreferences() async {
    await UserPreferences.init();

    final Set<String>? keys = _preferences?.getKeys();
    if (keys != null) {
      for (String key in keys) {
        final dynamic value = _preferences?.get(key);
        print('Key: $key, Value: $value');
      }
    }
  }
}
