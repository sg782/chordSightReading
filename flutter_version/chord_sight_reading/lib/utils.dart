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

  List<int> notes = pool.sublist(0,numNotes);
  return notes;

}


Future<ui.Image> loadImageFromFile(String path) async {
  final bytes = await File(path).readAsBytes();
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  return frame.image;
}