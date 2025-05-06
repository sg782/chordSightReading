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


/*

Accidentals will come in the next update
It requires too many inputs (how many accidentals, which accidentals, specific notes, etc) for me to want to do when trying to make a polished project

 */
// List<int> returnAccidentalsOffset(List<int> acc, List<int> offset,List<int> notes){//offsets the accidentals tied to each note
// int [] array = new int[acc.length];
// int len = notes.length;
// double[][] safeBound = {{1.3,2.4},{-1.1,2.2},{0,0},{-1.6,1.6},{-1,1}}; //{lower,higher , width} (width will be potentially added idk yet)
// //^ use the actual size of the notes to be more specific with the safebound
// System.out.println("Qtest33Notes:"+ Arrays.toString(newNoteList));
// System.out.println("Qtest33acc:"+ Arrays.toString(acc));
//
// //next 17ish lines weed out the naturals, can add an if statement later on to toggle this if naturals are to be shown.
// int NattyCount = 0;
// for (int i = 0; i < len; i++) {
// if(acc[i]==0){
// NattyCount+=1;
// }
// }
// int newlen = len - NattyCount;
// int[] cleanAccArray = new int[newlen];
// int[] cleanNoteArray = new int[newlen];
// int k = 0;
// for (int i = 0; i < len; i++) {
// if(acc[i]!=0){
// cleanAccArray[k] = acc[i];
// cleanNoteArray[k] = notes[i];
// k+=1;
// }
// }
// System.out.println("Qtest33:" + Arrays.toString(cleanAccArray) + Arrays.toString(cleanNoteArray));
// //
//
// for(int i = 0;i<newlen;i++){
// boolean bottomTouching = false;
// boolean topTouching = false;
// double accUpperBound = notes[i] + safeBound[acc[i]+2][1];
// double accLowerBound = notes[i] + safeBound[acc[i]+2][0];
// if(i<newlen-1){//Ignores the top note
// for(int j = i+1;j<newlen;j++){//Check if the top is touching
// if(accUpperBound > cleanNoteArray[j] + safeBound[cleanAccArray[j]+2][0]){//if The top of the current acc is above the bottom of the next acc (touching)
// topTouching = true;
// }
// }
// }
// if(i>0){//Ignores the bottom note
// for(int j = newlen-1;j> i;j--){//Check if the bottom is touching
// if(accLowerBound < cleanNoteArray[j] + safeBound[cleanAccArray[j]+2][1]){//if The bottom of the current acc is below the top of the next acc (touching)
// topTouching = true;
// }
// }
// }
// if(!bottomTouching && !topTouching){
//
// }
// System.out.print("Qtest33:"+bottomTouching+topTouching);
//
//
// //for each non natural accidental
// //check above accidental to see if it is clear
// //check below accidental to see if it is clear
// //it it is completely clear, give it a zero offset and remove it from the list
// }
//
//
//
//
//
// for(int i = 0;i<len;i++){
// int j = i;
// }
// /*
//         for(int i = 0;i<newlen;i++) { //for each accidental
//             boolean LowTouching = false;
//             boolean HighTouching = false;
//             double accUpperBound = notes[i] + safeBound[acc[i]+2][1];
//             double accLowerBound = notes[i] + safeBound[acc[i]+2][0];
//             if(i<newlen-1){ //if not the top note
//                 for(int j = i+1;j<newlen;j++){//check every accidental above the current one
//                     if(accUpperBound < cleanNoteArray[j] + safeBound[cleanAccArray[j]+2][0]){ //if accupperbound < the next acclowerbound
//                         HighTouching = false;
//
//                     }else{
//                         HighTouching = true;
//                         break; //if any accidentals above the original are touching
//                     }
//                 }
//             }
//             if(i>0){ //if not the bottom note
//                 for(int j = 1;j<i;j++){//check every accidental below the current one
//                     if(accLowerBound > cleanNoteArray[j] + safeBound[cleanAccArray[j]+2][1]){ //if acclowerbound > the previous accupperbound
//                         LowTouching = false;
//                     }else{
//                         LowTouching = true;
//                         break; //if any accidentals above the original are touching
//                     }
//                 }
//             }
//
//             if(!LowTouching && !HighTouching){
//                 array[i] = 0;
//                 System.out.println("Qtest33:"+ cleanNoteArray[i] + ";"+LowTouching + HighTouching);
//             }else{
//                 array[i] = -1;
//                 System.out.println("Qtest33:"+ cleanNoteArray[i]  + ";"+LowTouching + HighTouching);
//             }
//         }*/
// return(array);
// }

// List<int> returnAccidentals(int n,List<bool> validAccidentals){
//   List<int> allowedList = List<int>.filled(5, 0); //5 possible accidentals
//
//   for(int i = 0; i<validAccidentals.length;i++){
//     if(validAccidentals[i]){
//       allowedList[i] = i-2;//-2 is regarded as double flat
//     }else{
//       allowedList[i] = 3; // if there is a 3 in the array, it will be ignored
//     }
//   }
//   int[] accidentals = new int[n];
//   for(int i = 0;i<n;i++){
//     int j = 3;
//     while(j==3){ //in theory removes the threes
//     j = allowedList[(int)(5*Math.random())];
//   }
//   accidentals[i] = j;
//   }
//   return(accidentals);
// }


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