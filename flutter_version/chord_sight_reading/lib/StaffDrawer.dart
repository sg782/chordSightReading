import 'package:chord_sight_reading/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

import 'dart:ui';



class Staff{
  ui.Image? wholeNote;// = loadImageFromFile("assets/drawable/wholenote.png");
  ui.Image? trebleClef;
  ui.Image? bassClef;

  static const double lineSpacing = 15;

  double middleCYPosition = 0;
  final double middleCValue = 24 ;
  final double noteHeight = lineSpacing; // new variable just for clarity
  double wholeNoteAspectRatio = 1.0;
  double trebleClefAspectRatio = 1.0;
  double bassClefAspectRatio = 1.0;
  double trebleClefHeight = 8*lineSpacing; // 8x line spacing roughly
  double trebleClefWidth = 30;
  double bassClefHeight = (10/3) * lineSpacing;
  double bassClefWidth = 30;
  double noteWidth = 30.0;
  double noteVerticalSpacing = lineSpacing / 2.0;
  double noteOffsetRatio = 0.85; // this value visually looks good, also somewhat near cos(pi/3) * aspectRatio
  double noteLedgerWidthRatio = 1.8; // once again just looks good visually

  final paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2
    ..filterQuality = FilterQuality.high;

  // turn into loadImages (plural) and just load all necessary images
  // return boolean
  Future<bool> loadImages() async {
    String wholeNoteImgPath = 'assets/drawable/wholenote.png';
    wholeNote = await getImageData(wholeNoteImgPath);
    wholeNoteAspectRatio = wholeNote!.width.toDouble() / wholeNote!.height.toDouble();
    noteWidth = wholeNoteAspectRatio * noteHeight;

    String trebleClefImgPath = 'assets/drawable/trebleclef.png';
    trebleClef = await getImageData(trebleClefImgPath);
    trebleClefAspectRatio = trebleClef!.width.toDouble() / trebleClef!.height.toDouble();
    trebleClefWidth = trebleClefAspectRatio * trebleClefHeight;

    String bassClefImgPath = 'assets/drawable/bassclef.png';
    bassClef = await getImageData(bassClefImgPath);
    bassClefAspectRatio = bassClef!.width.toDouble() / bassClef!.height.toDouble();
    bassClefWidth = bassClefAspectRatio * bassClefHeight;

    return true;
  }

  Future<ui.Image> getImageData(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
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

    drawStaves(canvas, size, trebleChecked, bassChecked);
    drawNotes(canvas, size, notes);
    drawLedgerLines(canvas, size, notes, trebleChecked, bassChecked);


  }

  drawLedgerLines(Canvas canvas, Size size,  List<int> notes, bool trebleChecked, bool bassChecked){
    // draw ledger lines
    // currently may be drawing duplicates in the case
    double ledgerY = middleCYPosition + noteVerticalSpacing;
    double ledgerX = size.width * 0.5;// + (noteWidth * 0.5);
    double ledgerXOffset = noteWidth * noteLedgerWidthRatio * 0.5;

    int minNote = notes.reduce((a, b) => a < b ? a : b);
    int maxNote = notes.reduce((a, b) => a > b ? a : b);

    int highAValue = 36;
    int lowEValue = 12;

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
    }else if(trebleChecked && maxNote >= highAValue){
      int distance = (maxNote - highAValue).ceil();
      int lineCount = 1+ (distance / 2).floor();

      double highAValueYPosition = middleCYPosition - (highAValue - middleCValue) * noteVerticalSpacing;

      for(int i=0;i<lineCount;i++){
        ledgerY = highAValueYPosition - noteHeight * (i - 0.5);
        canvas.drawLine(Offset(ledgerX - ledgerXOffset,ledgerY), Offset(ledgerX + ledgerXOffset,ledgerY), paint);

      }
    }

    if(!bassChecked && minNote <= 22){
      int distance = (middleCValue - minNote).ceil();
      int lineCount = 1+ (distance / 2).floor();

      for(int i=0;i<lineCount;i++){
        ledgerY = middleCYPosition + noteHeight * (i + 0.5);
        canvas.drawLine(Offset(ledgerX - ledgerXOffset,ledgerY), Offset(ledgerX + ledgerXOffset,ledgerY), paint);
      }

    }else if(bassChecked && minNote <= lowEValue){
      
      int distance = (lowEValue - minNote).ceil();
      int lineCount = 1+ (distance / 2).floor();

      double lowEYPosition = middleCYPosition - (lowEValue - middleCValue) * noteVerticalSpacing;


      for(int i=0;i<lineCount;i++){
        ledgerY = lowEYPosition + noteHeight * (i + 0.5);
        canvas.drawLine(Offset(ledgerX - ledgerXOffset,ledgerY), Offset(ledgerX + ledgerXOffset,ledgerY), paint);
      }
    }
  }

  drawStaves(Canvas canvas, Size size, bool trebleChecked, bool bassChecked){
    double sidePadding = size.width / 15.0;

    if(trebleChecked){
      for(int i=5;i>0;i--){
        double lineY = middleCYPosition - ((i-0.5) * lineSpacing);
        canvas.drawLine(Offset(sidePadding, lineY),Offset(size.width-sidePadding, lineY),paint);
      }

      double trebleClefYPosition = middleCYPosition - trebleClefHeight * (4/5); // adjusted by hand to fit nice
      double trebleClefXPosition = 0;
      final src = Rect.fromLTWH(0, 0, trebleClef!.width.toDouble(), trebleClef!.height.toDouble());
      final dst = Rect.fromLTWH(trebleClefXPosition, trebleClefYPosition, trebleClefWidth, trebleClefHeight); // Resize to 40x40 and draw at (100, 100)

      canvas.drawImageRect(trebleClef!, src, dst, paint);

    }

    if(bassChecked){
      for(int i=5;i>0;i--){
        double lineY = middleCYPosition + ((i+0.5) * lineSpacing);
        canvas.drawLine(Offset(sidePadding, lineY),Offset(size.width-sidePadding, lineY),paint);
      }

      double bassClefYPosition = middleCYPosition + lineSpacing * (3/2); // adjusted by hand to fit nice
      double bassClefXPosition = 40;

      final src = Rect.fromLTWH(0, 0, bassClef!.width.toDouble(), bassClef!.height.toDouble());
      final dst = Rect.fromLTWH(bassClefXPosition, bassClefYPosition, bassClefWidth, bassClefHeight); // Resize to 40x40 and draw at (100, 100)

      canvas.drawImageRect(bassClef!, src, dst, paint);
    }



  }

  drawNotes(Canvas canvas, Size size, List<int> notes){
    List<int> noteOffsets = returnOffsetList(notes);

    if(wholeNote== null){
      print("Whole Note Not Loaded");
      return;
    }

    for(int i=0;i<notes.length;i++){
      int note = notes[i];

        // canvas.drawImage(wholeNote!, Offset(60, note * 10), paint);

        double wholeNoteAspectRatio = wholeNote!.width.toDouble() / wholeNote!.height.toDouble();
        double noteHeight = lineSpacing; // new variable just for clarity
        double noteWidth = wholeNoteAspectRatio * noteHeight;
        double xOffset = noteOffsets[i] * noteOffsetRatio * noteWidth;
        double noteTopLeftX = (size.width - noteWidth) / 2.0 - xOffset;
        double noteTopLeftY = (middleCValue - note) * noteVerticalSpacing + middleCYPosition;

        final src = Rect.fromLTWH(0, 0, wholeNote!.width.toDouble(), wholeNote!.height.toDouble());
        final dst = Rect.fromLTWH(noteTopLeftX, noteTopLeftY, noteWidth, noteHeight); // Resize to 40x40 and draw at (100, 100)
        canvas.drawImageRect(wholeNote!, src, dst, paint);

    }

  }

  drawRange(Canvas canvas, Size size, minNote, maxNote){

    middleCYPosition = size.height * (1/2);


    // for now, always display both staves if drawing notes
    drawStaves(canvas, size, true, true);
    drawLedgerLines(canvas, size, <int>[minNote,maxNote], true, true);

    final linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..filterQuality = FilterQuality.high;

    drawNotes(canvas, size, <int>[minNote,maxNote]);

    double verticalLineX = size.width/2 - 50;
    double maxY = (middleCValue - minNote  + 3) * noteVerticalSpacing + middleCYPosition;
    double minY = (middleCValue - maxNote - 1) * noteVerticalSpacing + middleCYPosition;
    canvas.drawLine(Offset(verticalLineX, minY), Offset(verticalLineX, maxY), linePaint);
    canvas.drawLine(Offset(verticalLineX, minY), Offset(verticalLineX + noteWidth / 2, minY), linePaint);
    canvas.drawLine(Offset(verticalLineX, maxY), Offset(verticalLineX + noteWidth / 2, maxY), linePaint);


  }
}

class PreviewStaffPainter extends CustomPainter {
  final double numNotes;
  final double noteRange;
  final double lowestNote;
  final bool trebleChecked;
  final bool bassChecked;
  final bool drawingRange;
  final bool updateVariable; // kinda janky way to update the drawing, but it works and is
  final Staff staff;


  PreviewStaffPainter(this.staff, this.numNotes,this.noteRange,this.lowestNote, this.trebleChecked, this.bassChecked, this.drawingRange, this.updateVariable);

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
