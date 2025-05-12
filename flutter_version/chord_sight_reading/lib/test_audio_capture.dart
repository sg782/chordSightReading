import 'package:fftea/impl.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:chord_sight_reading/waveform_painter.dart';

import 'dart:math';
import 'dart:typed_data';

void main() => runApp(TestAudioCapture());

class TestAudioCapture extends StatefulWidget {
  @override
  _TestAudioCaptureState createState() => _TestAudioCaptureState();
}

class _TestAudioCaptureState extends State<TestAudioCapture> {
  FlutterAudioCapture _plugin = new FlutterAudioCapture();

  @override
  void initState() {
    super.initState();
    // Need to initialize before use note that this is async!
    _plugin.init();
  }

  Future<void> _startCapture() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      print("Microphone permission not granted");
      return;
    }
    await _plugin.start(listener, onError, sampleRate: 16000, bufferSize: 3000);
  }

  Future<void> _stopCapture() async {
    await _plugin.stop();
  }

  int argmax(List<double> list) {
    if (list.isEmpty) {
      throw ArgumentError('List is empty');
    }

    double maxVal = list[0];
    int maxIndex = 0;

    for (int i = 1; i < list.length; i++) {
      if (list[i] > maxVal) {
        maxVal = list[i];
        maxIndex = i;
      }
    }

    return maxIndex;
  }
  
  void get_max(data){
    int max = argmax(data);
    print(max);
  }

  int dominantPitch = -1;
  List<double> _waveformBuffer = [];

  void listener(dynamic obj) {
    final samples = List<double>.from(obj);
    final fft = FFT(samples.length);
    final freq = fft.realFft(samples);

    final magnitudes = freq.map((f) {
      final real = f.x;
      final imag = f.y;
      return sqrt(real * real + imag * imag);
    }).toList();



    // final freq_list = List<double>.from(freq);

    // Keep only most recent 2048 samples
    _waveformBuffer.addAll(magnitudes);
    if (_waveformBuffer.length > 2048) {
      _waveformBuffer.removeRange(0, _waveformBuffer.length - 2048);
    }

    setState(() {
      int dominantIdx = argmax(magnitudes);

      dominantPitch = (dominantIdx * 16000 / samples.length).toInt();
    }); // re-render waveform
  }

  void onError(Object e) {
    print(e);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Audio Capture Plugin'),
        ),
        body: Column(children: [
          Text("Argmax: " + dominantPitch.toString()),
          Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Center(
                          child: ElevatedButton(
                              onPressed: _startCapture, child: Text("Start")))),
                  Expanded(
                      child: Center(
                          child: ElevatedButton(
                              onPressed: _stopCapture, child: Text("Stop")))),
                ],
              )),
          WaveformWidget(samples: _waveformBuffer),

        ]),
      ),
    );
  }
}