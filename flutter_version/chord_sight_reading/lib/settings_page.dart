import 'package:chord_sight_reading/StaffDrawer.dart';
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
  double noteCountNum = 5;
  double minNoteCount = 1;
  double maxNoteCount = 10;

  double rangeNum = 10;
  double minRangeNum = 2;
  double maxRangeNum = 52;

  double lowestNoteNum = 25;
  double minNoteNum = 1;
  double maxNoteNum = 52;

  bool trebleChecked = true;
  bool bassChecked = false;

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
    final style = AppTheme().current;

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
                children: [
                  const SizedBox(width: 16),
                  Text("Num Notes:", style: style.text),
                  Expanded(
                    child: Slider(
                      activeColor: style.primary,
                      value: noteCountNum,
                      min: minNoteCount,
                      max: maxNoteCount,
                      divisions: (maxNoteCount - minNoteCount).ceil(),
                      label: noteCountNum.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          noteCountNum = value;
                          AppSettings().numNotes = value;
                        });
                      },
                    ),
                  ),
                  Text(noteCountNum.toInt().toString(), style: style.text),
                  const SizedBox(width: 16),
                ],
              ),

              Row(
                children: [
                  const SizedBox(width: 16),
                  Text("Note Range:", style: style.text),
                  Expanded(
                    child: Slider(
                      activeColor: style.primary,
                      value: rangeNum,
                      min: minRangeNum,
                      max: maxRangeNum,
                      divisions: (maxRangeNum - minRangeNum).ceil(),
                      label: rangeNum.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          rangeNum = value;
                          AppSettings().noteRange = value;
                        });
                      },
                    ),
                  ),
                  Text(rangeNum.toInt().toString(), style: style.text),
                  const SizedBox(width: 16),
                ],
              ),

              Row(
                children: [
                  const SizedBox(width: 16),
                  Text("Lowest Note:", style: style.text),
                  Expanded(
                    child: Slider(
                      activeColor: style.primary,
                      value: lowestNoteNum,
                      min: minNoteNum,
                      max: maxNoteNum,
                      divisions: (maxNoteNum - minNoteNum).ceil(),
                      label: lowestNoteNum.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          lowestNoteNum = value;
                          AppSettings().lowestNote = value;
                        });
                      },
                    ),
                  ),
                  Text(pianoNotesMap[lowestNoteNum.toInt()]!, style: style.text),
                  const SizedBox(width: 16),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Treble Clef:", style: style.text),
                  Switch(
                    activeColor: style.primary,
                    value: trebleChecked,
                    onChanged: (bool value) {
                      setState(() {
                        trebleChecked = value;
                        AppSettings().useTrebleClef = value;
                        if (!value) {
                          bassChecked = true;
                          AppSettings().useBassClef = true;
                        }
                      });
                    },
                  ),
                  Text("Bass Clef:", style: style.text),
                  Switch(
                    activeColor: style.primary,
                    value: bassChecked,
                    onChanged: (bool value) {
                      setState(() {
                        bassChecked = value;
                        AppSettings().useBassClef = value;
                        if (!value) {
                          trebleChecked = true;
                          AppSettings().useTrebleClef = true;
                        }
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              if (ready)
                CustomPaint(
                  size: Size(width, height * 0.5),
                  painter: PreviewStaffPainter(
                    staff,
                    noteCountNum,
                    rangeNum,
                    lowestNoteNum,
                    trebleChecked,
                    bassChecked,
                    true,
                    true,
                  ),
                ),

              const SizedBox(height: 30),

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
