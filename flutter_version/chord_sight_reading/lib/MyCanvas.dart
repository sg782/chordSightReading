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
    double sidePadding = size.width /15.0;
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..filterQuality = FilterQuality.high;

    // crude staff
    double staffLineHeight = 30;
    for(int i=1;i<=5;i++){
      canvas.drawLine(Offset(sidePadding,i * staffLineHeight),Offset(size.width-sidePadding,i * staffLineHeight),paint);
    }


    for(int note in notes){
      canvas.drawCircle(Offset(50, note * 10),5,paint);

      if (wholeNote != null) {
        // canvas.drawImage(wholeNote!, Offset(60, note * 10), paint);

        // final paint = Paint();
        final src = Rect.fromLTWH(0, 0, wholeNote!.width.toDouble(), wholeNote!.height.toDouble());
        final dst = Rect.fromLTWH(100, 100, 40, 40); // Resize to 40x40 and draw at (100, 100)

        canvas.drawImageRect(wholeNote!, src, dst, paint);
      }else{
        print("not loaded");
      }

    }

  }
}