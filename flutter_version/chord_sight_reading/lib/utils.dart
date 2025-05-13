import 'dart:math';
import 'dart:ui' as ui;
import 'dart:io';

int maxRange = 53;

// does not worry about accidentals RN
// to do so, just make a note class to hold the natural key and accidental
List<int> returnNoteArray (int numNotes, int range, int lowest){
  if(lowest + numNotes > maxRange){
    // adjusting the lower bound to be able to fit all the notes
    lowest = maxRange - numNotes;
  }

  // total note spread
  int spread =  max(range, numNotes);

  // if total note spread + lowest is too much, shrink the spread
  if(spread + lowest > maxRange) {
     spread -= ((lowest + spread) % maxRange);
  }

  List<int> pool = List.generate(spread, (i) => i + lowest);
  pool.shuffle(Random());

  List<int> notes = (pool.sublist(0, numNotes)..sort((a, b) => a - b));  return notes;

}


List<int> returnOffsetList(List<int> notes){ //Finds any adjacent notes that need to be offset to avoid clipping
  List<int> offsetList = List.filled(notes.length, 0);

  offsetList[0] = 0; //never offset bottom note
  for(int i = 1; i < notes.length;i++){
    if(notes[i] - notes[i-1] == 1 && offsetList[i-1] !=1){//if notes are touching and isnt already offset
      offsetList[i] = 1;
    }else{
      offsetList[i] = 0;
    }
  }
  return(offsetList);
  //at the end, if there are more offset notes than not offset notes, flip them
}




Future<ui.Image> loadImageFromFile(String path) async {
  final bytes = await File(path).readAsBytes();
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  return frame.image;
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

List<int> topKFrequencies(List<double> data, int k) {
  if (k <= 0 || k > data.length) {
    throw ArgumentError('Invalid value for k');
  }
  final indexed = List.generate(data.length, (i) => MapEntry(i, data[i]));

  // Sort by magnitude descending
  indexed.sort((a, b) => b.value.compareTo(a.value));

  // Return the top K indices
  return indexed.take(k).map((e) => e.key).toList();
}



final Map<int, String> pianoNotesMap = {
  1: "A0",
  2: "B0",
  3: "C1",
  4: "D1",
  5: "E1",
  6: "F1",
  7: "G1",
  8: "A1",
  9: "B1",
  10: "C2",
  11: "D2",
  12: "E2",
  13: "F2",
  14: "G2",
  15: "A2",
  16: "B2",
  17: "C3",
  18: "D3",
  19: "E3",
  20: "F3",
  21: "G3",
  22: "A3",
  23: "B3",
  24: "C4",
  25: "D4",
  26: "E4",
  27: "F4",
  28: "G4",
  29: "A4",
  30: "B4",
  31: "C5",
  32: "D5",
  33: "E5",
  34: "F5",
  35: "G5",
  36: "A5",
  37: "B5",
  38: "C6",
  39: "D6",
  40: "E6",
  41: "F6",
  42: "G6",
  43: "A6",
  44: "B6",
  45: "C7",
  46: "D7",
  47: "E7",
  48: "F7",
  49: "G7",
  50: "A7",
  51: "B7",
  52: "C8",
};

List<String> noteNames = [
  "C0", "C#0", "D0", "D#0", "E0", "F0", "F#0", "G0", "G#0", "A0", "A#0", "B0",
  "C1", "C#1", "D1", "D#1", "E1", "F1", "F#1", "G1", "G#1", "A1", "A#1", "B1",
  "C2", "C#2", "D2", "D#2", "E2", "F2", "F#2", "G2", "G2#", "A2", "A2#", "B2",
  "C3", "C3#", "D3", "D3#", "E3", "F3", "F3#", "G3", "G3#", "A3", "A3#", "B3",
  "C4", "C4#", "D4", "D4#", "E4", "F4", "F4#", "G4", "G4#", "A4", "A4#", "B4",
  "C5", "C5#", "D5", "D5#", "E5", "F5", "F5#", "G5", "G5#", "A5", "A5#", "B5",
  "C6", "C6#", "D6", "D6#", "E6", "F6", "F6#", "G6", "G6#", "A6", "A6#", "B6",
  "C7", "C7#", "D7", "D7#", "E7", "F7", "F7#", "G7", "G7#", "A7", "A7#", "B7",
  "C8", "C8#", "D8", "D8#", "E8", "F8", "F8#", "G8", "G8#", "A8", "A8#", "B8",
  "Beyond B8"
];

List<double> noteFrequencies = [
  16.35, 17.32, 18.35, 19.45, 20.60, 21.83, 23.12, 24.50, 25.96, 27.50,
  29.14, 30.87, 32.70, 34.65, 36.71, 38.89, 41.20, 43.65, 46.25, 49.00,
  51.91, 55.00, 58.27, 61.74, 65.41, 69.30, 73.42, 77.78, 82.41, 87.31,
  92.50, 98.00, 103.83, 110.00, 116.54, 123.47, 130.81, 138.59, 146.83,
  155.56, 164.81, 174.61, 185.00, 196.00, 207.65, 220.00, 233.08, 246.94,
  261.63, 277.18, 293.66, 311.13, 329.63, 349.23, 369.99, 392.00, 415.30,
  440.00, 466.16, 493.88, 523.25, 554.37, 587.33, 622.25, 659.26, 698.46,
  739.99, 783.99, 830.61, 880.00, 932.33, 987.77, 1046.50, 1108.73, 1174.66,
  1244.51, 1318.51, 1396.91, 1479.98, 1567.98, 1661.22, 1760.00, 1864.66,
  1975.53, 2093.00, 2217.46, 2349.32, 2489.02, 2637.02, 2793.83, 2959.96,
  3135.96, 3322.44, 3520.00, 3729.31, 3951.07, 4186.01, 4434.92, 4698.64,
  4978.03, 5274.04, 5587.65, 5919.91, 6271.93, 6644.88, 7040.00, 7458.62,
  7902.13, 8000.00
];


int binSearchNearest(List<double> values, double target) {
  int l = 0;
  int r = values.length - 1;

  while (r - l > 1) {
    int m = (l + r) ~/ 2;

    if (values[m] == target) {
      return m;
    } else if (values[m] < target) {
      l = m;
    } else {
      r = m;
    }
  }

  double distL = (values[l] - target).abs();
  double distR = (values[r] - target).abs();

  return distL < distR ? l : r;
}


