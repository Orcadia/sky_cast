import 'package:flutter/material.dart';
import 'package:sky_cast/services/user_preferences.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                const Text(
                  "Temperature: ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Switch(
                  // This bool value toggles the switch.
                  value: units,
                  inactiveTrackColor: Colors.white,
                  inactiveThumbColor: Colors.indigo,
                  onChanged: (bool value) async {
                    // This is called when the user toggles the switch.
                    await UserPreferences.setUnits(value); // Save the units in the shared preferences to use it on other pages
                    setState(() {
                      units = value;
                    });
                  },
                ),
                Builder(builder: (context) {
                  if (units) {
                    return const Text("°C");
                  } else {
                    return const Text("°F");
                  }
                })
              ],
            )
          ]),
        ));
  }
}
