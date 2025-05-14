import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:fftea/impl.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_audio_capture/flutter_audio_capture.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:chord_sight_reading/waveform_painter.dart';

import 'package:chord_sight_reading/utils.dart';


import 'dart:math';
import 'dart:typed_data';
class NoteListener {

  final int numNotes;

  NoteListener(this.numNotes);

  FlutterAudioCapture _cap = new FlutterAudioCapture();



  // final List<double> _waveformBuffer = [];
  int sampleRate = 44100;
  int bufferSize = 16384;

  ValueNotifier<List<int>> latestSamples = ValueNotifier<List<int>>([]);

  Future<void> startCapture() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      print("Microphone permission not granted");
      return;
    }
    await _cap.start(listener, onError, sampleRate: sampleRate, bufferSize: bufferSize);
  }

  FlutterAudioCapture getCapture() {
    return _cap;
  }

  Future<void> stopCapture() async {
    await _cap.stop();
  }

  void listener(dynamic obj) {
    final samples = List<double>.from(obj);

    final fft = FFT(samples.length);


    // apply hann window before FFT
    for(int i=0;i<samples.length;i++){
      samples[i] *= (1-cos(2 * pi * i / (samples.length - 1)));
    }

    // try skewing window? to make notes resolve faster?
    // for(int i=0;i<samples.length;i++){
    //   int x = samples.length - i;
    //   int exponent = 9;
    //
    //   double skew = pow(x / (samples.length - 1), exponent).toDouble();
    //
    //
    //   samples[i] *= (1-cos(2 * pi * skew));
    // }


    final freq = fft.realFft(samples);

    final magnitudes = freq.map((f) {
      final real = f.x;
      final imag = f.y;
      return sqrt(real * real + imag * imag);
    }).toList();

    final croppedMagnitudes = magnitudes.sublist(0, magnitudes.length ~/ 2);


    int k = 2 * numNotes + 3; // number of frequencies to take. Random formula for it
    int n = numNotes;  // number of final notes to output
    List<int> topKDominantFrequencies = topKFrequencies(croppedMagnitudes, k);

    double multiplier =  (sampleRate / samples.length);
    topKDominantFrequencies = topKDominantFrequencies.map((i) => (i * multiplier).toInt()).toList();

    Set <int> topNNotes = {};
    for(int i=0;i<k;i++){
      double frequency = topKDominantFrequencies[i].toDouble();
      int freqIndex = binSearchNearest(noteFrequencies, frequency);
      topNNotes.add(freqIndex);

      if(topNNotes.length >= n){
        break;
      }
    }

    // print(topKDominantFrequencies);
    // print(topKDominantFrequencies.map((i)=>(noteNames[binSearchNearest(noteFrequencies, i.toDouble())])).toList());
    latestSamples.value = topNNotes.toList();


  }

  void onError(Object e) {
    print(e);
  }

  void dispose() {
    latestSamples.dispose();
  }


}