import 'package:flutter/material.dart';
import 'app_theme.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // AppTheme().toggleTheme();
    final style = AppTheme().current;

    return Scaffold(
      backgroundColor: style.background,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.music_note_sharp, size: 80, color: style.primary),
              const SizedBox(height: 10),
              Text('Sight Reading Trainer', style: style.title),
              const SizedBox(height: 4),
              Text('Train your note recognition skills', style: style.subtitle),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: style.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: Text(
                  'Play',
                  style: style.buttonText,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: style.accent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                ),
                child: Text(
                  'Settings',
                  style: style.buttonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
