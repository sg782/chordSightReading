import 'package:chord_sight_reading/note_listen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:chord_sight_reading/utils.dart';


void main() => runApp(const TestAudioCapture());

class TestAudioCapture extends StatefulWidget {
  const TestAudioCapture({super.key});

  @override
  _TestAudioCaptureState createState() => _TestAudioCaptureState();
}

class _TestAudioCaptureState extends State<TestAudioCapture> {
  NoteListener noteListener = NoteListener();

  @override
  void initState() {
    super.initState();
    // Need to initialize before use note that this is async!
    noteListener.getCapture().init();
  }

  Future<void> _startCapture() async {

    noteListener.startCapture();
  }

  Future<void> _stopCapture() async {
    await noteListener.stopCapture();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Audio Capture Plugin'),
        ),
        body: Column(children: [
          ValueListenableBuilder<List<int>>(
            valueListenable: noteListener.latestSamples,
            builder: (context, notes, _) {
              return Text('Current Note: ${notes.map((i) => noteNames[i]).toList()}');
            },
          ),
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
        ]),
      ),
    );
  }
}