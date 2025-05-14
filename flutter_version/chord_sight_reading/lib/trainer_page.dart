import 'package:chord_sight_reading/StaffDrawer.dart';
import 'package:chord_sight_reading/app_settings.dart';
import 'package:chord_sight_reading/app_theme.dart'; // Add this

import 'package:flutter/material.dart';

import 'package:chord_sight_reading/note_listen.dart';
import 'package:chord_sight_reading/utils.dart';

import 'package:collection/collection.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => TrainingPageState();
}

class TrainingPageState extends State<TrainingPage> {
  Staff staff = Staff();

  double numNotes = AppSettings().numNotes;
  double noteRange = AppSettings().noteRange;
  double lowestNote = AppSettings().lowestNote;
  bool trebleChecked = AppSettings().useTrebleClef;
  bool bassChecked = AppSettings().useBassClef;

  bool ready = false;
  List<int> notesDisplay = returnNoteArray(AppSettings().numNotes.toInt(), AppSettings().noteRange.toInt(), AppSettings().lowestNote.toInt());
  List<int> notesHeard = [];



  NoteListener noteListener = NoteListener(AppSettings().numNotes.toInt());
  late final VoidCallback _noteEventListener;

  @override
  void initState() {

    // print(whiteKeyIndexToNoteIndex.toString());
    super.initState();
    staff.loadImages().then((_) {
      setState(() => ready = true);
    });

    if(AppSettings().useNoteListener){
      initListener();
    }


    _noteEventListener = () {
      setState(() {
        notesHeard = noteListener.latestSamples.value.toList();

        List<int> displayNotesIdx = notesDisplay.map((i) => whiteKeyIndexToNoteIndex[i] ?? -1).toList();

        // print(displayNotesIdx);

        List<int> notesHeardSorted = [...notesHeard]..sort();
        List<int> displayNotesIdxSorted = [...displayNotesIdx]..sort();

        if(ListEquality().equals(notesHeardSorted,displayNotesIdxSorted)){
          notesDisplay = returnNoteArray(numNotes.ceil(), noteRange.ceil(), lowestNote.ceil());
          // print("equal!!!");
        }

      });
    };

    noteListener.latestSamples.addListener(_noteEventListener);

  }

  @override
  void dispose() {
    noteListener.latestSamples.removeListener(_noteEventListener);
    super.dispose();
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
    // numNotes = AppSettings().numNotes;
    // noteRange = AppSettings().noteRange;
    // lowestNote = AppSettings().lowestNote;
    // trebleChecked = AppSettings().useTrebleClef;
    // bassChecked = AppSettings().useBassClef;

    // make the notes out here

    // return Scaffold(
    //   backgroundColor: style.background,
    //   body: SafeArea(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         ready
    //             ? GestureDetector(
    //           child: RepaintBoundary(
    //             child: CustomPaint(
    //               size: Size(width, height * 0.5),
    //               painter: PreviewStaffPainter(
    //                 staff,
    //                 false,
    //                 notesDisplay,
    //               ),
    //             ),
    //           ),
    //           onTapDown: (TapDownDetails tapDetails) {
    //             setState(() {
    //               notesDisplay = returnNoteArray(numNotes.ceil(), noteRange.ceil(), lowestNote.ceil());
    //             });
    //           },
    //         )
    //             : const SizedBox.shrink(),
    //         // AppSettings().useNoteListener
    //         //   ?   Text(notesHeard.toString())
    //         //     : const Text("Not Listening"),
    //         //
    //         // const SizedBox(height: 30),
    //
    //         // ElevatedButton(
    //         //   style: ElevatedButton.styleFrom(
    //         //     backgroundColor: style.primary,
    //         //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
    //         //   ),
    //         //   onPressed: () {
    //         //     Navigator.pop(context);
    //         //   },
    //         //   child: Text('Back!', style: style.buttonText),
    //         // ),
    //         Align(
    //           alignment: Alignment.bottomLeft,
    //           child: Padding(
    //             padding: const EdgeInsets.all(16.0),
    //             child: IconButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               icon: const Icon(Icons.arrow_back),
    //               color: Colors.black, // Or style.primary if desired
    //               iconSize: 32,
    //               style: ButtonStyle(
    //                 backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    //                 overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
    //                 shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
    //               ),
    //             ),
    //           ),
    //         ),
    //
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      backgroundColor: style.background,
      body: SafeArea(
        child: Stack(
          children: [

            ready
                ? GestureDetector(
              child: RepaintBoundary(
                child: CustomPaint(
                  size: Size(width, height),
                  painter: PreviewStaffPainter(
                    staff,
                    false,
                    notesDisplay,
                  ),
                ),
              ),
              onTapDown: (TapDownDetails tapDetails) {
                setState(() {
                  notesDisplay = returnNoteArray(
                    numNotes.ceil(),
                    noteRange.ceil(),
                    lowestNote.ceil(),
                  );
                });
              },
            )
                : const SizedBox.shrink(),

            Positioned(
              bottom: 20,
              left: 20,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  iconSize: 32,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                    overlayColor: MaterialStateProperty.all<Color>(Colors.black12),
                    shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}

