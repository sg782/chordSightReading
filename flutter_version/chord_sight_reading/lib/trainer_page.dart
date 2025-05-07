// import 'package:chord_sight_reading/StaffDrawer.dart';
// import 'package:chord_sight_reading/app_settings.dart';
//
// import 'package:flutter/material.dart';
//
//
//
//
// class TrainingPage extends StatefulWidget {
//   const TrainingPage({super.key});
//
//   @override
//   State<TrainingPage> createState() => TrainingPageState();
// }
//
// class TrainingPageState extends State<TrainingPage> {
//   // const SecondRoute({Key? key}) : super(key: key);
//
//   Staff staff = Staff();
//
//   double numNotes = 0;
//   double noteRange = 0;
//   double lowestNote = 0;
//   bool trebleChecked = false;
//   bool bassChecked = false;
//
//   bool updateVariable = false;
//
//   bool ready = false;
//
//   @override
//   void initState() {
//     print("here");
//     super.initState();
//     staff.loadImages().then((_) {
//       setState(() => ready = true);
//     });
//   }
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.sizeOf(context).width;
//     double height = MediaQuery.sizeOf(context).height;
//     // final args = ModalRoute.of(context)!.settings.arguments as Map;
//     //
//     //
//     //
//     // numNotes = args['numNotes'];
//     // noteRange = args['noteRange'];
//     // lowestNote = args['lowestNote'];
//     // trebleChecked = args['trebleChecked'];
//     // bassChecked = args['bassChecked'];
//
//     numNotes = AppSettings().numNotes;
//     noteRange = AppSettings().noteRange;
//     lowestNote = AppSettings().lowestNote;
//
//     trebleChecked = AppSettings().useTrebleClef;
//     bassChecked = AppSettings().useBassClef;
//
//
//     return Scaffold(
//
//         body:
//         SafeArea(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children:
//               [
//                 ready?
//                 GestureDetector(
//                   child: CustomPaint(
//                     size: Size(width,height * 0.5),
//                     painter: PreviewStaffPainter(staff, numNotes, noteRange, lowestNote, trebleChecked, bassChecked, false,updateVariable),
//                   ),
//                   onTapDown: (TapDownDetails tapDetails){
//                     setState(() {
//                       updateVariable = !updateVariable;
//                     });
//                   },
//                 )
//                     : const SizedBox.shrink(),
//
//                 ElevatedButton(
//                   style: ButtonStyle(
//                       backgroundColor: WidgetStateProperty.all(Colors.black),
//                       foregroundColor: WidgetStateProperty.all(Colors.white)),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Back!'),
//                 ),
//               ]
//           ),
//         )
// // Center
//     ); // Scaffold
//   }
// }
//

import 'package:chord_sight_reading/StaffDrawer.dart';
import 'package:chord_sight_reading/app_settings.dart';
import 'package:chord_sight_reading/app_theme.dart'; // Add this

import 'package:flutter/material.dart';

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
                  numNotes,
                  noteRange,
                  lowestNote,
                  trebleChecked,
                  bassChecked,
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

