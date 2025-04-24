import 'package:chord_sight_reading/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

class Staff{
  ui.Image? wholeNote;// = loadImageFromFile("assets/drawable/wholenote.png");

  // Future<void> loadImage(String path) async {
  //   print("going to load");
  //   final bytes = await File(path).readAsBytes();
  //   final codec = await ui.instantiateImageCodec(bytes);
  //   final frame = await codec.getNextFrame();
  //   wholeNote = frame.image;
  // }

  // turn into loadImages (plural) and just load all necessary images
  Future<void> loadImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      // targetWidth: 50,
      // targetHeight: 50,
    );
    final frame = await codec.getNextFrame();
    wholeNote = frame.image;
  }


  draw(Canvas canvas, Size size, List<int> notes){

    // define some useful constants for drawing
    double sidePadding = size.width / 15.0;
    double lineSpacing = 30;
    double ledgerWidth = size.width / 10.0;

    // center our rendering around middle C
    // define dynamically in the future depending on which staves are visible
    // for now we default to just treble clef
    double middleCYPosition = size.height/2;
    int middleCValue = 24; // note 24 in our set
    double noteVerticalSpacing = lineSpacing / 2.0;
    double noteOffsetRatio = 0.85; // this value visually looks good, also somewhat near cos(pi/3) * aspectRatio









    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..filterQuality = FilterQuality.high;

    // crude staff
    for(int i=5;i>0;i--){
      double lineY = middleCYPosition - ((i-0.5) * lineSpacing);
      canvas.drawLine(Offset(sidePadding, lineY),Offset(size.width-sidePadding, lineY),paint);
    }

    List<int> noteOffsets = returnOffsetList(notes);

    for(int i=0;i<notes.length;i++){
      int note = notes[i];

      if (wholeNote != null) {
        // canvas.drawImage(wholeNote!, Offset(60, note * 10), paint);

        double wholeNoteAspectRatio = wholeNote!.width.toDouble() / wholeNote!.height.toDouble();
        print(wholeNoteAspectRatio);
        double noteHeight = lineSpacing; // new variable just for clarity
        double noteWidth = wholeNoteAspectRatio * noteHeight;
        double xOffset = noteOffsets[i] * noteOffsetRatio * noteWidth;
        double noteTopLeftX = (size.width - noteWidth) / 2.0;
        double noteTopLeftY = (middleCValue - note) * noteVerticalSpacing + middleCYPosition;

        // final paint = Paint();
        final src = Rect.fromLTWH(0, 0, wholeNote!.width.toDouble(), wholeNote!.height.toDouble());
        final dst = Rect.fromLTWH(noteTopLeftX - xOffset, noteTopLeftY, noteWidth, noteHeight); // Resize to 40x40 and draw at (100, 100)

        canvas.drawImageRect(wholeNote!, src, dst, paint);
      }else{
        print("not loaded");
      }

    }

  }
}