import 'dart:math';

import 'package:chord_sight_reading/StaffDrawer.dart';
import 'package:chord_sight_reading/SoundTest.dart';
import 'package:chord_sight_reading/utils.dart';
import 'package:flutter/material.dart';
// function to trigger build when the app is run
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MainPage(),
      '/second': (context) => SecondPage(),
      // '/soundTest': (context) => SoundTest(),
    },
    debugShowCheckedModeBanner: false,
  )); //MaterialApp
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // const MainPage({Key? key}) : super(key: key);


  // should encapsulate all these sliders and switches into a settings widget
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
    print("here");
    super.initState();
    staff.loadImages().then((_) {
      setState(() => ready = true);
    });
  }


  // create my canvas class


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    double sidePadding = width /10.0;

    return Scaffold(

      body: SafeArea(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Choose Your Variables: "),
            Row(
              children:
                  [
                  const Text("Num Notes: "),
                  Expanded(
                    child: Slider(
                      value: noteCountNum,
                      min: minNoteCount,
                      max: maxNoteCount,
                      divisions: (maxNoteCount - minNoteCount).ceil(),
                      label: noteCountNum.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          noteCountNum = value;
                        });
                      },
                    ),
                  ),
                    Text(noteCountNum.toInt().toString()),
                ]
            ),

            Row(
              children: [
                Text("Note Range: "),
                  Expanded(
                    child: Slider(
                      value: rangeNum,
                      min: minRangeNum,
                      max: maxRangeNum,
                      divisions: (maxRangeNum - minRangeNum).ceil(),
                      label: rangeNum.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          rangeNum = value;
                        });
                      },
                    )
                  ),
                Text(rangeNum.toInt().toString()),
              ],
            ),
            Row(
              children: [
                Text("Lowest Note: "),
                Expanded(
                    child: Slider(
                    value: lowestNoteNum,
                    min: minNoteNum,
                    max: maxNoteNum,
                    divisions: (maxNoteNum - minNoteNum).ceil(),
                    label: lowestNoteNum.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        lowestNoteNum = value;
                      });
                    },
                  )
                ),
                Text(pianoNotesMap[lowestNoteNum.toInt()]!),

              ],
            ),

            Row(
              children: [
                Text("Show Treble Clef: "),
                Switch(
                  value: trebleChecked,
                  onChanged: (bool value) {
                    setState(() {
                      trebleChecked = value;
                      if(!value){
                        bassChecked = true;
                      }
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text("Show Bass Clef: "),
                Switch(
                  value: bassChecked,
                  onChanged: (bool value) {
                    setState(() {
                      bassChecked = value;
                      if(!value){
                        trebleChecked = true;
                      }
                    });
                  },
                ),
              ],
            ),



            ready?
              CustomPaint(
                size: Size(width,height * 0.5),
                painter: previewStaffPainter(staff, noteCountNum, rangeNum, lowestNoteNum, trebleChecked, bassChecked, true, true),
              )
            : const SizedBox.shrink(),

            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                  foregroundColor: WidgetStateProperty.all(Colors.white)),
              child: const Text('Start!'),
              onPressed: () {
                Navigator.pushNamed(
                    context,
                    '/second',
                    arguments: {
                      'numNotes': noteCountNum,
                      'noteRange': rangeNum,
                      'lowestNote': lowestNoteNum,
                      'trebleChecked': trebleChecked,
                      'bassChecked': bassChecked
                    }
                );
              },
            ), // ElevatedButton
          ], // <Widget>[]
        ), // Column
      ), // Center
    ); // Scaffold
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  // const SecondRoute({Key? key}) : super(key: key);

  Staff staff = Staff();

  double numNotes = 0;
  double noteRange = 0;
  double lowestNote = 0;
  bool trebleChecked = false;
  bool bassChecked = false;

  bool updateVariable = false;

  bool ready = false;

  @override
  void initState() {
    print("here");
    super.initState();
    staff.loadImages().then((_) {
      setState(() => ready = true);
    });
  }






  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    numNotes = args['numNotes'];
    noteRange = args['noteRange'];
    lowestNote = args['lowestNote'];
    trebleChecked = args['trebleChecked'];
    bassChecked = args['bassChecked'];


    return Scaffold(

      body:
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              ready?
              GestureDetector(
                child: CustomPaint(
                  size: Size(width,height * 0.5),
                  painter: previewStaffPainter(staff, numNotes, noteRange, lowestNote, trebleChecked, bassChecked, false,updateVariable),
                ),
                onTapDown: (TapDownDetails tapDetails){
                  setState(() {
                    updateVariable = !updateVariable;
                  });
                },
              )
                  : const SizedBox.shrink(),

              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                    foregroundColor: WidgetStateProperty.all(Colors.white)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back!'),
              ),
            ]
        ),
        )
// Center
    ); // Scaffold
  }
}


class previewStaffPainter extends CustomPainter {
  final double numNotes;
  final double noteRange;
  final double lowestNote;
  final bool trebleChecked;
  final bool bassChecked;
  final bool drawingRange;
  final bool updateVariable; // kinda janky way to update the drawing, but it works and is
  final Staff staff;


  previewStaffPainter(this.staff, this.numNotes,this.noteRange,this.lowestNote, this.trebleChecked, this.bassChecked, this.drawingRange, this.updateVariable);

  @override
  void paint(Canvas canvas, Size size) {

    List<int> notes = returnNoteArray(numNotes.ceil(), noteRange.ceil(), lowestNote.ceil());

    if(drawingRange){
      int minNote = lowestNote.ceil();
      int maxNote = min(lowestNote+noteRange, 53).ceil();
      staff.drawRange(canvas,size, minNote, maxNote);

      return;
    }

    staff.draw(canvas, size, notes, trebleChecked, bassChecked);

  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Ensures the canvas is redrawn with each update
  }
}
