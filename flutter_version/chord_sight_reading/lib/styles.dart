import 'package:flutter/material.dart';



class Styles {
  static final dark = _DarkStyles();
  static final light = _LightStyles();
  static final sunset = _SunsetStyles();
  static final retro = _RetroStyles();
  static final parchment = _ParchmentStyles();
}

class _DarkStyles {
  final Color background = const Color(0xFF121212);
  final Color primary = const Color(0xFF1DB954);
  final Color accent = const Color(0xFFBB86FC);
  final Color textColor = Colors.white;

  final TextStyle title = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  final TextStyle subtitle = const TextStyle(
    fontSize: 16,
    color: Colors.white70,
  );

  final TextStyle buttonText = const TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  final TextStyle text = const TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
}

class _LightStyles {
  final Color background = const Color(0xFFF5EDF9);
  final Color primary = const Color(0xFF4B0082);
  final Color accent = const Color(0xFF9370DB);
  final Color textColor = const Color(0xFF1C1C1C);

  final TextStyle title = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1C1C1C),
  );

  final TextStyle subtitle = const TextStyle(
    fontSize: 16,
    color: Color(0xFF444444),
  );

  final TextStyle buttonText = const TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  final TextStyle text = const TextStyle(
    fontSize: 16,
    color: Color(0xFF1C1C1C),
  );
}


class _SunsetStyles {
  final Color background = const Color(0xFFFFF3E0); // warm cream
  final Color primary = const Color(0xFFFF7043); // deep orange
  final Color accent = const Color(0xFFFFA726); // sunbeam amber
  final Color textColor = const Color(0xFF3E2723); // dark brown

  final TextStyle title = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFF3E2723),
  );

  final TextStyle subtitle = const TextStyle(
    fontSize: 16,
    color: Color(0xFF5D4037),
  );

  final TextStyle text = const TextStyle(
    fontSize: 16,
    color: Color(0xFF3E2723),
  );

  final TextStyle buttonText = const TextStyle(
    fontSize: 18,
    color: Colors.white,
  );
}


class _RetroStyles {
  final Color background = const Color(0xFF1F1D36); // dark purple
  final Color primary = const Color(0xFFE94560); // neon red
  final Color accent = const Color(0xFF0F3460); // steel blue
  final Color textColor = const Color(0xFFFDFDFD);

  final TextStyle title = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFFFDFDFD),
  );

  final TextStyle subtitle = const TextStyle(
    fontSize: 16,
    color: Color(0xFFB8B8FF),
  );

  final TextStyle text = const TextStyle(
    fontSize: 16,
    color: Color(0xFFFDFDFD),
  );

  final TextStyle buttonText = const TextStyle(
    fontSize: 18,
    color: Colors.white,
  );
}

class _ParchmentStyles {
  final Color background = const Color(0xFFFFFBF0); // parchment cream
  final Color primary = const Color(0xFF2E2E2E); // dark gray (for buttons/icons)
  final Color accent = const Color(0xFF8C7853); // brass/golden-brown (for highlights)
  final Color textColor = const Color(0xFF1C1C1C); // dark text for contrast

  final TextStyle title = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFF2E2E2E),
    fontFamily: 'Georgia', // gives classical serif feel
  );

  final TextStyle subtitle = const TextStyle(
    fontSize: 16,
    color: Color(0xFF5A4E3C),
    fontStyle: FontStyle.italic,
  );

  final TextStyle text = const TextStyle(
    fontSize: 16,
    color: Color(0xFF1C1C1C),
  );

  final TextStyle buttonText = const TextStyle(
    fontSize: 18,
    color: Colors.white,
  );
}
