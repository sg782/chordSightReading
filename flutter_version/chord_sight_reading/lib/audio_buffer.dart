import 'dart:typed_data';

class AudioBuffer {
  final int maxSize;
  final List<double> _buffer = [];

  AudioBuffer({required this.maxSize});

  void addSamples(Float32List newSamples) {
    _buffer.addAll(newSamples);

    // Keep buffer size within maxSize
    if (_buffer.length > maxSize) {
      _buffer.removeRange(0, _buffer.length - maxSize);
    }
  }

  List<double> get data => List.unmodifiable(_buffer);
}
