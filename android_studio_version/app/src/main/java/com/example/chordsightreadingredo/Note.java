package com.example.chordsightreadingredo;

public class Note {
    private int NaturalKey;
    private int noteAccidental;

    Note(int naturalKey, int accidental) {
        NaturalKey = naturalKey;
        noteAccidental = accidental;
    }


}


/*  String[] accidentalArray = new String[] {"DoubleFlat","Flat","Natural","Sharp","DoubleSharp"};
        int[] accidentalValueArray = new int[] {-2,-1,0,1,2};
        Map<String,Integer> accidentals = new LinkedHashMap<>();
        accidentals.put("DoubleFlat",-2);
        accidentals.put("Flat",-1);
        accidentals.put("Natural",0);
        accidentals.put("Sharp",1);
        accidentals.put("DoubleSharp",2);*/