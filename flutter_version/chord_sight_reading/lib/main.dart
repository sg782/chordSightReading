import 'package:chord_sight_reading/customize_notes.dart';
import 'package:chord_sight_reading/entry_page.dart';
import 'package:chord_sight_reading/settings_page.dart';
import 'package:chord_sight_reading/trainer_page.dart';
import 'package:chord_sight_reading/test_audio_capture.dart';
import 'package:chord_sight_reading/customize_notes.dart';

import 'package:flutter/material.dart';

// function to trigger build when the app is run
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const EntryPage(),
      '/settings': (context) => const SettingsPage(),
      '/customize': (context) => const NoteCustomization(),
      '/training': (context) => const TrainingPage(),
      // '/audio_cap': (context) => TestAudioCapture(),
      // '/soundTest': (context) => SoundTest(),
    },
    debugShowCheckedModeBanner: false,
  )); //MaterialApp
}

