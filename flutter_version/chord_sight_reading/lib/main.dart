import 'dart:math';

import 'package:chord_sight_reading/MyCanvas.dart';
import 'package:chord_sight_reading/utils.dart';
import 'package:flutter/material.dart';
// function to trigger build when the app is run
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MainPage(),
      '/second': (context) => const SecondRoute(),
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
    staff.loadImage('assets/drawable/wholenote.png').then((_) {
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
      appBar: AppBar(
        title: const Text('Front Page'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ), // AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Slider(
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
            Slider(
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
            ),
            Slider(
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
            ),
            
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                  foregroundColor: WidgetStateProperty.all(Colors.white)),
              child: const Text('Start!'),
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
            ), // ElevatedButton
            CustomPaint(
              size: Size(width,height * 0.5),
              painter: previewStaffPainter(staff, noteCountNum, rangeNum, lowestNoteNum),
            ),
          ], // <Widget>[]
        ), // Column
      ), // Center
    ); // Scaffold
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Click Me Page"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ), // AppBar
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.green),
              foregroundColor: WidgetStateProperty.all(Colors.white)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back!'),
        ), // ElevatedButton
      ), // Center
    ); // Scaffold
  }
}


class previewStaffPainter extends CustomPainter {
  final double numNotes;
  final double noteRange;
  final double lowestNote;
  final Staff staff;

  previewStaffPainter(this.staff, this.numNotes,this.noteRange,this.lowestNote);

  @override
  void paint(Canvas canvas, Size size) {

    // Staff staff  = Staff();
    List<int> notes = returnNoteArray(numNotes.ceil(), noteRange.ceil(), lowestNote.ceil());
    staff.draw(canvas,size, notes);


    // Repaints any time its params update

    // should make staff class



    //for path in path list { draw path }

  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Ensures the canvas is redrawn with each update
  }
}
