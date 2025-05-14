class AppSettings {
  static final AppSettings _instance = AppSettings._internal();

  factory AppSettings() => _instance;

  AppSettings._internal();

  double numNotes = 5;
  double noteRange = 10;
  double lowestNote = 21;
  bool useTrebleClef = true;
  bool useBassClef = false;
  bool useNoteListener = true;


}
