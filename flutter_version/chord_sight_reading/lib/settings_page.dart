import 'package:chord_sight_reading/StaffDrawer.dart';
import 'package:chord_sight_reading/styles.dart';
import 'package:chord_sight_reading/utils.dart';
import 'package:chord_sight_reading/app_settings.dart';
import 'package:chord_sight_reading/app_theme.dart'; // Add this


import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double noteCountNum = AppSettings().numNotes;
  double minNoteCount = 1;
  double maxNoteCount = 10;

  double rangeNum = AppSettings().noteRange;
  double minRangeNum = 2;
  double maxRangeNum = 52;

  double lowestNoteNum = AppSettings().lowestNote;
  double minNoteNum = 1;
  double maxNoteNum = 52;

  bool trebleChecked = AppSettings().useTrebleClef;
  bool bassChecked = AppSettings().useBassClef;

  bool useNoteListener = AppSettings().useNoteListener;

  Staff staff = Staff();
  bool ready = false;

  @override
  void initState() {
    super.initState();
    staff.loadImages().then((_) {
      setState(() => ready = true);
    });
  }



  @override
  Widget build(BuildContext context) {
    dynamic style = AppTheme().current;

    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: style.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Text("Sight Reading Trainer", style: style.title),
              const SizedBox(height: 10),
              Text("Choose Your Variables:", style: style.subtitle),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Use Note Listener (Experimental/Buggy):", style: style.text),
                  Switch(
                    activeColor: style.primary,
                    value: useNoteListener,
                    onChanged: (bool value) {
                      setState(() {
                        useNoteListener = value;
                        AppSettings().useNoteListener = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              DropdownButton<String>(
                value: 'light', // must be one of the keys
                items: Styles.themes.keys.map((theme) {
                  return DropdownMenuItem<String>(
                    value: theme,
                    child: Text(theme),
                  );
                }).toList(),
                onChanged: (value) {
                  AppTheme().setTheme(value!);
                  setState(() {
                    style = Styles.themes[value]!;
                  });
                },
              ),

              
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: style.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text('Save Settings!', style: style.buttonText),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
