package com.example.chordsightreadingredo;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;

import androidx.appcompat.app.AppCompatActivity;

import java.util.Arrays;

public class pageTwo extends AppCompatActivity {


    int noteCountNum = 5;
    int rangeNum = 10;
    int lowestNoteNum = 25;
    boolean trebleChecked = true;
    boolean bassChecked = false;

    MyCanvas tort;
    boolean[] accidentalsKey;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        super.onCreate(savedInstanceState);
        getSupportActionBar().hide();
        Intent intent = getIntent();
        accidentalsKey = new boolean[5];
        /////////
        //accidentalsKey[doubleflat,flat,natural,sharp, doublesharp];
        accidentalsKey[0] = intent.getBooleanExtra("doubleflatChecked",false);
        accidentalsKey[1] = intent.getBooleanExtra("flatChecked",false);
        accidentalsKey[2] = true;
        accidentalsKey[3] = intent.getBooleanExtra("sharpChecked",false);
        accidentalsKey[4] = intent.getBooleanExtra("doublesharpChecked",false);

        System.out.println("Qtest23:"+Arrays.toString(accidentalsKey));

        ///////
        noteCountNum = intent.getIntExtra("noteCount", 3);
        rangeNum = intent.getIntExtra("range", 10);
        lowestNoteNum= intent.getIntExtra("lowest", 25);
        trebleChecked = intent.getBooleanExtra("trebleClicked",true);
        bassChecked = intent.getBooleanExtra("bassClicked",false);
        if(!trebleChecked && !bassChecked){
            trebleChecked = true;
        }
                setContentView(R.layout.activity_page_two);
       // System.out.println("QtestSWITCH:"+ trebleChecked + bassChecked);
        tort = new MyCanvas(getApplicationContext(),noteCountNum,rangeNum,lowestNoteNum,trebleChecked,bassChecked,accidentalsKey);
        tort.remake(noteCountNum,rangeNum,lowestNoteNum,trebleChecked,bassChecked,accidentalsKey);
        System.out.println("Qtest6");
        setContentView(tort); //this will make it better



        tort.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
               // tort = new MyCanvas(getApplicationContext(),noteCountNum,rangeNum,lowestNoteNum););
             //   System.out.println("Qtest5:" + noteCountNum + rangeNum + lowestNoteNum);
                tort.remake(noteCountNum,rangeNum,lowestNoteNum,trebleChecked,bassChecked,accidentalsKey);
            }
        });






    }

    //ReturnArray

        public static int[] returnArray( int n, int range, int lowest)
        { //literally the exact same thing as above but returns array of integers instead of note objects
            // System.out.print("noteArray1 ");                            //for debugging purposes rn
            if (n + lowest >= 53) lowest = 53 - n;
            int NatKey;
            int spread = Math.max(range, n);
            int[] noteArray = new int[n];
            int trueSpread;
            if (spread + lowest > 53) {
                trueSpread = spread - ((lowest + spread) % 53);
            } else {
                trueSpread = spread;
            }
            int[] possibleNotes = new int[trueSpread];
            int ArraySpread = trueSpread;

            Note[] notes = new Note[n];
            for (int i = 0; i < trueSpread; i++) { //makes initial array with length trueSpread
                possibleNotes[i] = i + lowest;
            }
            //Main Function
            for (int i = 0; i < n; i++) {
                int index = (int) (ArraySpread * Math.random()); //random index within the bounds
                NatKey = possibleNotes[index]; //random element in possible notes array is assigned here
                int NoteAcc = 0; //ignoring accidentals for now
                notes[i] = new Note(NatKey, NoteAcc); //relevant array
                noteArray[i] = NatKey;
                int[] copy = new int[possibleNotes.length - 1];
                for (int k = 0, j = 0; k < possibleNotes.length; k++) {
                    if (k != index) {
                        copy[j++] = possibleNotes[k];//shrinks the array list
                    }
                }
                possibleNotes = copy;
                ArraySpread = ArraySpread - 1;
            }
            Arrays.sort(noteArray);
            return noteArray;
        }

}
