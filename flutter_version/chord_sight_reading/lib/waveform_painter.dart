import 'package:flutter/material.dart';
import 'dart:math';

class WaveformPainter extends CustomPainter {
  final List<double> samples;

  WaveformPainter(this.samples);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 1;

    final middleY = size.height / 2;
    final sampleCount = samples.length;

    for (int i = 0; i < sampleCount - 1; i++) {
      final x1 = (i / sampleCount) * size.width;
      final x2 = ((i + 1) / sampleCount) * size.width;
      final y1 = middleY - samples[i] * middleY;
      final y2 = middleY - samples[i + 1] * middleY;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) {
    return true;
  }
}


class WaveformWidget extends StatelessWidget {
  final List<double> samples;

  const WaveformWidget({required this.samples, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 100),
      painter: WaveformPainter(samples),
    );
  }
}
