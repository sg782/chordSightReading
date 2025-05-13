import 'package:chord_sight_reading/StaffDrawer.dart';
import 'package:chord_sight_reading/app_settings.dart';
import 'package:chord_sight_reading/app_theme.dart'; // Add this

import 'package:flutter/material.dart';

import 'package:chord_sight_reading/note_listen.dart';
import 'package:chord_sight_reading/utils.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => TrainingPageState();
}

class TrainingPageState extends State<TrainingPage> {
  Staff staff = Staff();

  double numNotes = 0;
  double noteRange = 0;
  double lowestNote = 0;
  bool trebleChecked = false;
  bool bassChecked = false;

  bool updateVariable = false;
  bool ready = false;

  NoteListener noteListener = NoteListener();


  @override
  void initState() {
    super.initState();
    staff.loadImages().then((_) {
      setState(() => ready = true);
    });

    if(AppSettings().useNoteListener){
      initListener();
    }
  }

  Future <void> initListener() async {
    await noteListener.getCapture().init();
    noteListener.startCapture();
  }

  @override
  Widget build(BuildContext context) {
    final style = AppTheme().current;

    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    // Load settings from global singleton
    numNotes = AppSettings().numNotes;
    noteRange = AppSettings().noteRange;
    lowestNote = AppSettings().lowestNote;
    trebleChecked = AppSettings().useTrebleClef;
    bassChecked = AppSettings().useBassClef;

    return Scaffold(
      backgroundColor: style.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ready
                ? GestureDetector(
              child: CustomPaint(
                size: Size(width, height * 0.5),
                painter: PreviewStaffPainter(
                  staff,
                  false,
                  updateVariable,
                ),
              ),
              onTapDown: (TapDownDetails tapDetails) {
                setState(() {
                  updateVariable = !updateVariable;
                });
              },
            )
                : const SizedBox.shrink(),

            AppSettings().useNoteListener
              ? ValueListenableBuilder<List<int>>(
                  valueListenable: noteListener.latestSamples,
                  builder: (context, notes, _) {
                  return Text('Current Note: ${notes.map((i) => noteNames[i]).toList()}');
                  },
                  )
              : const Text("Not Listening"),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: style.primary,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back!', style: style.buttonText),
            ),
          ],
        ),
      ),
    );
  }
}

