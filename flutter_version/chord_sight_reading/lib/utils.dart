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