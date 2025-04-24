import 'package:chord_sight_reading/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

class Staff{
  ui.Image? wholeNote;// = loadImageFromFile("assets/drawable/wholenote.png");
  double middleCYPosition = 0;
  final double middleCValue = 24;
  final double lineSpacing = 30;
  final double noteHeight = 30; // new variable just for clarity
  double wholeNoteAspectRatio = 1.0;
  double noteWidth = 30.0;
  double noteVerticalSpacing = 30 / 2.0;
  double noteOffsetRatio = 0.85; // this value visually looks good, also somewhat near cos(pi/3) * aspectRatio
  double noteLedgerWidthRatio = 1.8; // once again just looks good visually

  final paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2
    ..filterQuality = FilterQuality.high;

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

    wholeNoteAspectRatio = wholeNote!.width.toDouble() / wholeNote!.height.toDouble();
    noteWidth = wholeNoteAspectRatio * noteHeight;
  }


  draw(Canvas canvas, Size size, List<int> notes, bool trebleChecked, bool bassChecked){


    // define some useful constants for drawing
    double sidePadding = size.width / 15.0;
    // double lineSpacing = 30;
    double ledgerWidth = size.width / 10.0;

    // center our rendering around middle C
    if(!trebleChecked && !bassChecked){
      trebleChecked = true;
    }

    if(trebleChecked && bassChecked){
      middleCYPosition = size.height * (1/2);
    }else if(trebleChecked){
      middleCYPosition = size.height * (3/5);
    }else if(bassChecked){
      middleCYPosition = size.height * (2/5);
    }





    // crude staff

    if(trebleChecked){
      for(int i=5;i>0;i--){
        double lineY = middleCYPosition - ((i-0.5) * lineSpacing);
        canvas.drawLine(Offset(sidePadding, lineY),Offset(size.width-sidePadding, lineY),paint);
      }
    }

    if(bassChecked){
      for(int i=5;i>0;i--){
        double lineY = middleCYPosition + ((i+0.5) * lineSpacing);
        canvas.drawLine(Offset(sidePadding, lineY),Offset(size.width-sidePadding, lineY),paint);
      }
    }


    List<int> noteOffsets = returnOffsetList(notes);

    for(int i=0;i<notes.length;i++){
      int note = notes[i];

      if (wholeNote != null) {
        // canvas.drawImage(wholeNote!, Offset(60, note * 10), paint);

        double wholeNoteAspectRatio = wholeNote!.width.toDouble() / wholeNote!.height.toDouble();
        double noteHeight = lineSpacing; // new variable just for clarity
        double noteWidth = wholeNoteAspectRatio * noteHeight;
        double xOffset = noteOffsets[i] * noteOffsetRatio * noteWidth;
        double noteTopLeftX = (size.width - noteWidth) / 2.0 - xOffset;
        double noteTopLeftY = (middleCValue - note) * noteVerticalSpacing + middleCYPosition;

        // final paint = Paint();
        final src = Rect.fromLTWH(0, 0, wholeNote!.width.toDouble(), wholeNote!.height.toDouble());
        final dst = Rect.fromLTWH(noteTopLeftX, noteTopLeftY, noteWidth, noteHeight); // Resize to 40x40 and draw at (100, 100)

        canvas.drawImageRect(wholeNote!, src, dst, paint);

        drawLedgerLines(canvas, size, notes, trebleChecked, bassChecked);
      }else{
        print("not loaded");
      }

    }

  }

  drawLedgerLines(Canvas canvas, Size size,  List<int> notes, bool trebleChecked, bool bassChecked){
    // draw ledger lines
    // currently may be drawing duplicates in the case
    double ledgerY = middleCYPosition + noteVerticalSpacing;
    double ledgerX = size.width * 0.5;// + (noteWidth * 0.5);
    double ledgerXOffset = noteWidth * noteLedgerWidthRatio * 0.5;

    int minNote = notes.reduce((a, b) => a < b ? a : b);
    int maxNote = notes.reduce((a, b) => a > b ? a : b);

    int highA = 36;

    // the uncovered case in either staff
    if(notes.contains(middleCValue.ceil())){
      canvas.drawLine(Offset(ledgerX - ledgerXOffset,ledgerY), Offset(ledgerX + ledgerXOffset,ledgerY), paint);
    }
    if(!trebleChecked && maxNote >= 26){
      int distance = (maxNote - middleCValue).ceil();
      int lineCount = 1+ (distance / 2).floor();

      for(int i=0;i<lineCount;i++){
        ledgerY = middleCYPosition - noteHeight * (i - 0.5);
        canvas.drawLine(Offset(ledgerX - ledgerXOffset,ledgerY), Offset(ledgerX + ledgerXOffset,ledgerY), paint);

      }
    }else if(maxNote >= highA){
      int distance = (maxNote - highA).ceil();
      int lineCount = 1+ (distance / 2).floor();

      for(int i=0;i<lineCount;i++){
        ledgerY = middleCYPosition - noteHeight * (i - 0.5 - 10);
        canvas.drawLine(Offset(ledgerX - ledgerXOffset,ledgerY), Offset(ledgerX + ledgerXOffset,ledgerY), paint);

      }
    }
    if(!bassChecked && minNote <= 22){

    }
  }
}