import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sky_cast/utils/user_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();

}
class _SettingPageState extends State<SettingPage> {
  bool units = true;

  @override
  void initState() {
    super.initState();
    final unitsValue = UserPreferences.getUnits();
    if (unitsValue != null) {
      units = unitsValue;
    } else {
      units = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),// Ajoutez ici le contenu de votre première page
      body: Column(
          children: [
            Row(
              children: [
                Switch(
                  // This bool value toggles the switch.
                  value: units,
                  inactiveTrackColor: Colors.white,
                  inactiveThumbColor: Colors.indigo,
                  onChanged: (bool value) async {
                    // This is called when the user toggles the switch.
                    await UserPreferences.setUnits(value);
                    setState(() {
                      units = value;
                    });
                  },
                ),
                Builder(
                    builder: (context) {
                      if (units)
                        return Text("°C");
                      else
                        return Text("°F");
                    }
                )
              ],
            )
          ]
      ),
    );
  }
}

